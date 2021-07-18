// contracts/CertificateFactory.sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./CertificateCommon.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./CertificateCommon.sol";

contract CertificateFactory is Ownable {

    Certificate[] public certificates;

    //    using SafeMath for uint256;
    //    using SafeMath32 for uint32;
    //    using SafeMath16 for uint16;

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint coolDownTime = 1 days;

    mapping(uint => address) public certificateToOwner;
    mapping(address => uint) ownerCertificateCount;

    // 通知前端创建了一个证书
    event NewCertificate(
        address indexed _from,
        bytes32 indexed _id,
        string name
    );

    function _createCertificate(byte32 _name, uint _dna) internal onlyOwner {

        // 生成一个id

        uint id = certificates.push(
            Certificate({
                name : _name,
                sponsor : msg.sender,
                level : LevelEnum.Level.Beginner,
                createTime : now,
                updateTime : now
            })) - 1;
        certificateToOwner[id] = msg.sender;
        ownerCertificateCount[msg.sender] = ownerCertificateCount[msg.sender].add(1);
        emit NewZombie(owner(), id, _name);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createZombie(_name, randDna);
    }

}


