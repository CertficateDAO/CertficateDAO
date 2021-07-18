pragma solidity ^0.4.0;

import "./LevelEnum.sol";
import "./CertificateDFA.sol";

library CertificateCommon {
    struct Certificate {
        uint256 id;
        uint256 dna;
        byte32 name;
        address sponsor;
        LevelEnum.Level Level;
        uint createTime;
        uint modifyTime;
        address[] allowCastingAddresses;
    }


}
