pragma solidity ^0.4.0;

import "./BaseCertificate.sol";

contract CertificateDFA is BaseCertificate {

    uint256 id;
    string name;
    address sponsor;
    LevelEnum.Level level;

    function CertificateDFA(string _name, LevelEnum.Level _level){
        id += 1;
        name = _name;
        sponsor = msg.sender;
        level = _level;
    }

    function getCertificateId() returns (uint){
        return id;
    }

    function getCertificateName() returns (string){
        return name;
    }

    function isExpired() returns (bool);

    function getCertificateSponsor() returns (address) {
        return sponsor;
    }

    function getCertificateLevel() returns (LevelEnum.Level){
        return level;
    }

    function castingByOwner() returns (bool){
        return true;
    }

    function getExtendInfo() returns (string);


}
