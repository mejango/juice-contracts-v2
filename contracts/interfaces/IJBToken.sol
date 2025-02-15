// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

interface IJBToken {
  function totalSupply(uint256 _projectId) external view returns (uint256);

  function balanceOf(address _account, uint256 _projectId) external view returns (uint256);

  function mint(
    uint256 _projectId,
    address _account,
    uint256 _amount
  ) external;

  function burn(
    uint256 _projectId,
    address _account,
    uint256 _amount
  ) external;

  function transferOwnership(address _newOwner) external;

  function transferFrom(
    address _from,
    address _to,
    uint256 _amount
  ) external returns (bool);
}
