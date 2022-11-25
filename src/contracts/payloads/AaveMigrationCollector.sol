// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

import {IERC20} from '@aave/core-v2/contracts/dependencies/openzeppelin/contracts/IERC20.sol';
import {IAaveIncentivesController} from '@aave/core-v2/contracts/interfaces/IAaveIncentivesController.sol';
import {VersionedInitializable} from '../../interfaces/v2/VersionedInitializable.sol';

/**
 * @title AaveMigrationCollector
 * @notice Migrates all assets from this proxy to the new Collector
 * @author Aave
 **/
contract AaveMigrationCollector is VersionedInitializable {
  uint256 public constant REVISION = 3;

  address public RECIPIENT_COLLECTOR;

  IAaveIncentivesController public INCENTIVES_CONTROLLER;

  /**
   * @notice returns the revision of the implementation contract
   */
  function getRevision() internal pure override returns (uint256) {
    return REVISION;
  }

  /**
   * @notice returns the recipient collector
   */
  function getRecipientCollector() internal view returns (address) {
    return RECIPIENT_COLLECTOR;
  }

  /**
   * @notice returns the address of the incentives controller
   */
  function getIncentivesController() internal view returns (address) {
    return address(INCENTIVES_CONTROLLER);
  }

  /**
   * @notice initializes the contract upon assignment to the InitializableAdminUpgradeabilityProxy
   * migrates all the assets to the new collector
   * @param assets list of the aTokens to transfer.
   * @param incentivesController the address of the incentives controller.
   * @param recipientCollector the address of the recipient collector.
   */
  function initialize(
    address[] calldata assets,
    address incentivesController,
    address recipientCollector
  ) external initializer {
    RECIPIENT_COLLECTOR = recipientCollector;
    INCENTIVES_CONTROLLER = IAaveIncentivesController(incentivesController);

    claimRewards(assets);
    transferToRecipientCollector(assets);
  }

  /**
   * @notice migrates all the assets to the new collector
   * @param assets list of the aTokens to transfer.
   */
  function transferToRecipientCollector(address[] calldata assets) public {
    for (uint256 i = 0; i < assets.length; i++) {
      IERC20 token = IERC20(assets[i]);
      uint256 balance = token.balanceOf(address(this));
      if (balance > 0) {
        token.transfer(RECIPIENT_COLLECTOR, balance);
      }
    }
  }

  /**
   * @notice migrates all the rewards to the new recipient collector
   * @param assets list of the aTokens to claim rewards for.
   */
  function claimRewards(address[] memory assets) public {
    uint256 balance = INCENTIVES_CONTROLLER.getRewardsBalance(assets, address(this));
    INCENTIVES_CONTROLLER.claimRewards(assets, balance, RECIPIENT_COLLECTOR);
  }
}
