// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CFEToken is
ERC20,
Ownable
{
    /*
     * RETURN CODE
     */
    string public ONLY_COMMITTEE = "100000001";
    string public LOCKED_COOLING_TIME = "100000002";

    /*
     * constant
     */
    uint256 public rate = 10000;

    mapping(address => bool) committee;

    mapping(address => uint256) freezeToken;

    /**
    * @dev
    */
    modifier onlyCommittee(address account) {
        require(committee[account], ONLY_COMMITTEE);
        _;
    }

    //    modifier checkMiningTime {
    //        require(miningTime[_msgSender()] - block.timestamp < 1 weeks, LOCKED_COOLING_TIME);
    //        _;
    //    }


    constructor(string memory name_, string memory symbol_, uint256 initialSupply) ERC20(name_, symbol_) payable {
        committee[_msgSender()] = true;
        _mint(msg.sender, initialSupply);
    }

    function addCommitteeMember(address account_) onlyOwner public returns (bool)  {
        committee[account_] = true;
        return true;
    }

    function isCommitteeMember(address account_) view public returns (bool) {
        return committee[account_];
    }

    // 挖矿从主账户转账
    function mint(uint256 amount_) onlyCommittee(_msgSender()) public {
        transfer(_msgSender(), amount_);
    }

    // 已投票的代币
    // 是否被调用时是合约发起的呢？
    function freezeAccountToken(address account_, uint256 amount_)
    external
    returns (uint256) {
        require(balanceOf(account_) > 0);
        uint256 previousFreezeToken = freezeToken[account_];
        freezeToken[account_] = previousFreezeToken + amount_;
        assert(previousFreezeToken + amount_ <= freezeToken[account_]);
        return balanceOf(account_) - freezeToken[account_];
    }

    function freezeBalanceOf(address account_) public view returns (uint256) {
        return freezeToken[account_];
    }

    function availableBalanceOf(address account_)
    external
    view returns (uint256){
        assert(balanceOf(account_) >= freezeBalanceOf(account_));
        return balanceOf(account_) - freezeBalanceOf(account_);
    }

    // 只允许委员会销毁特定账户的代币
    function burn(address account_, uint256 amount_) onlyCommittee(_msgSender()) public returns (uint256){
        _burn(account_, amount_);
        return this.balanceOf(account_);
    }

}
