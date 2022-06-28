// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Roles.sol";

contract CarRole {
  using Roles for Roles.Role;

  event CarAdded(address indexed account);
  event CarRemoved(address indexed account);

  Roles.Role private cars;

  modifier onlyCars() {
    require(isCar(msg.sender),"Only cars can call this.");
    _;
  }

  function isCar(address account) public view returns (bool) {
    return cars.has(account);
  }

  function addCar(address account) internal {
    cars.add(account);
    emit CarAdded(account);
  }

  function renounceCar() internal {
    cars.remove(msg.sender);
    emit CarRemoved(msg.sender);
  }
}