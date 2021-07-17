pragma solidity ^0.4.0;

import "./Certificate.sol";

contract BaseCertificate is Certificate {

    uint createDateTime;
    uint updateDateTime;

    function BaseCertificate() {
        createDateTime = now;
        updateDateTime = now;
    }

    modifier updateDateTime {
        updateDateTime = now;
        _;
    }

    function createDateTime() returns (uint) {
        return createDateTime;
    }

    function updateDateTime() returns (uint){
        return updateDateTime;
    }

}
