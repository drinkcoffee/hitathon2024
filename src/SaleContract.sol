// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeMath} from "@openzeppelin/contracts/utils/math/SafeMath.sol";
import {Power} from "./Power.sol";

contract SaleContract is Power {
  using SafeMath for uint256;
  uint32 private constant MAX_RESERVE_RATIO = 1000000;

  IERC20 gameToken;

  constructor(
      address gameTokenAddr,
      uint256 totalAmountToSell,
      uint256 initialPrice,
      uint256 raiseTarget,
      uint256 endTime) {
  }

  function calculatePurchaseReturn(
    uint256 _supply,          // <- the current supply of this token
    uint256 _reserveBalance, // <- current balance of IMX
    uint32 _reserveRatio,   // <- 100000 (10%)
    uint256 _depositAmt     // <- the depositted IMX
  ) internal view returns (uint256) { // <- returns the amount of token bought
    require(_supply > 0 && _reserveBalance > 0 && _reserveRatio > 0 && _reserveRatio <= MAX_RESERVE_RATIO);
    // Special case for 0 deposit amt
    if (_depositAmt == 0) {
      return 0;
    }
    // Special case if the ratio is 100%
    if (_reserveRatio == MAX_RESERVE_RATIO) {
      return _supply.mul(_depositAmt).div(_reserveBalance);
    }

    uint256 result;
    uint8 precision;
    uint256 baseN = _depositAmt.add(_reserveBalance);
    (result, precision) = power(
      baseN, _reserveBalance, _reserveRatio, MAX_RESERVE_RATIO
    );

    uint256 newTokenSupply = _supply.mul(result) >> precision;
    return newTokenSupply - _supply;
  }
}