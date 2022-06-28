// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./CarRole.sol";
import "./CentralRole.sol";

contract CarMessaging is CarRole,CentralRole{
    string public message;

    function hi() public onlyCentral{
        message = "Hi i am central";
    }

    function registerCar(address requestSender) public onlyCentral{
        addCar(requestSender);
    }

    
}