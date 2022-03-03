// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import './interfaces/IJBFundingCycleDataSource.sol';

contract StudioDAOFundingCycleDataSource is IJBFundingCycleDataSource {

  IJBPayDelegate studioDAODelegate;

  constructor(IJBPayDelegate _delegate) {
    studioDAODelegate = _delegate;
  }

  function payParams(JBPayParamsData calldata _param)
    external
    view
    override
    returns (
      uint256 weight,
      string memory memo,
      IJBPayDelegate delegate,
      bytes memory delegateMetadata
    ) {
      return (_param.weight, _param.memo, studioDAODelegate, new bytes(0));
    }

  function redeemParams(JBRedeemParamsData calldata _param)
    external
    view
    override
    returns (
      uint256 reclaimAmount,
      string memory memo,
      IJBRedemptionDelegate delegate,
      bytes memory delegateMetadata
    ) {
      return (0, '', IJBRedemptionDelegate(address(0)), new bytes(0));
    }
}
