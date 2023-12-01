// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3FantomAssets} from 'aave-address-book/AaveV3Fantom.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {IInitializableAdminUpgradeabilityProxy} from '../src/interfaces/IInitializableAdminUpgradeabilityProxy.sol';
import {BaseTest} from './BaseTest.sol';
import 'aave-address-book/AaveAddressBook.sol';

contract ProposalTestMainnet is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16621900);
    _setUp(
      address(AaveV2Ethereum.COLLECTOR),
      MiscEthereum.PROXY_ADMIN,
      AaveGovernanceV2.SHORT_EXECUTOR,
      0,
      AaveGovernanceV2.SHORT_EXECUTOR,
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN)
    );
  }
}

contract ProposalTestPolygon is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 39271550);
    _setUp(
      address(AaveV3Polygon.COLLECTOR),
      MiscPolygon.PROXY_ADMIN,
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR,
      100000,
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR,
      IERC20(AaveV3PolygonAssets.USDC_A_TOKEN)
    );
  }
}

contract ProposalTestAvalanche is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 26194290);
    _setUp(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.PROXY_ADMIN,
      address(0xa35b76E4935449E33C56aB24b23fcd3246f13470), // Avalanche v3 Guardian
      100000,
      address(0xa35b76E4935449E33C56aB24b23fcd3246f13470), // Avalanche v3 Guardian
      IERC20(AaveV3AvalancheAssets.USDC_A_TOKEN)
    );
  }
}

contract ProposalTestOptimism is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 86860560);
    _setUp(
      address(AaveV3Optimism.COLLECTOR),
      MiscOptimism.PROXY_ADMIN,
      AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR,
      100000,
      AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR, // Safe Guardian owns the collector now, will work after permissions switch
      IERC20(AaveV3OptimismAssets.USDC_A_TOKEN)
    );
  }
}

contract ProposalTestArbitrum is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'));
    _setUp(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.PROXY_ADMIN,
      AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR,
      100000,
      AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR, // Safe Guardian owns the collector now, will work after permissions switch
      IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN)
    );
  }
}

contract ProposalTestFantom is BaseTest {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('fantom'), 55648655);
    _setUp(
      address(AaveV3Fantom.COLLECTOR),
      address(0xf71fc92e2949ccF6A5Fd369a0b402ba80Bc61E02), // Guardian
      AaveV3Fantom.ACL_ADMIN,
      100000,
      AaveV3Fantom.ACL_ADMIN,
      IERC20(AaveV3FantomAssets.USDC_A_TOKEN)
    );
  }
}

// contract ProposalTestHarmony is BaseTest {
//   function setUp() public {
//     vm.createSelectFork(vm.rpcUrl('harmony'), 33354598);
//     _setUp(
//       AaveV3Harmony.COLLECTOR,
//       AaveV3Harmony.DEFAULT_INCENTIVES_CONTROLLER,
//       AaveV3Harmony.ACL_ADMIN
//     );
//   }
// }
