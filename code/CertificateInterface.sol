pragma solidity ^0.4.0;

import "./LevelEnum.sol";

interface CertificateInterface {

    function getCertificateId() returns (uint);

    function getCertificateName() returns (string);

    function isExpired() returns (bool);

    function getCertificateSponsor() returns (address);

    function getCertificateLevel() returns (LevelEnum.Level);

    function castingByOwner() returns (bool);

    function getExtendInfo() returns (string);

    function createDateTime() returns (uint);

    function updateDateTime() returns (uint);

}
