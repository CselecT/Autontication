// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Roles.sol";

contract CentralRole {
  using Roles for Roles.Role;

  event CentralAdded(address indexed account);
  event CentralRemoved(address indexed account);

  Roles.Role private central;

  modifier onlyCentral() {
    require(isCentral(msg.sender),"Only central authority can call this.");
    _;
  }

  function isCentral(address account) public view returns (bool) {
    return central.has(account);
  }

  function addCentral(address account) internal {
    if(central.any()==false){
      central.add(account);
      emit CentralAdded(account);
    }

  }

  function renounceCentral() internal {
    central.remove(msg.sender);
    emit CentralRemoved(msg.sender);
  }

}