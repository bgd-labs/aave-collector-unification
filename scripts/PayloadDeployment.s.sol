// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Script} from 'forge-std/Script.sol';
import 'aave-address-book/AaveAddressBook.sol';
// import {AaveV2Ethereum, AaveV2Avalanche, AaveV2Polygon, AaveV3Polygon, AaveV3Avalanche, AaveV3Optimism, AaveV3Arbitrum, AaveV3Fantom, AaveV3Harmony, AaveGovernanceV2, AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {UpgradeAaveCollectorPayload} from '../src/contracts/payloads/UpgradeAaveCollectorPayload.sol';
import {Collector} from '../src/contracts/Collector.sol';

uint256 constant DEFAULT_STREAM_ID = 100000;

contract DeployMainnet is Script {
  function run() external {
    vm.startBroadcast();

    Collector collector = new Collector();
    collector.initialize(AaveGovernanceV2.SHORT_EXECUTOR, 0);

    new UpgradeAaveCollectorPayload(
      address(AaveV2Ethereum.COLLECTOR),
      address(collector),
      MiscEthereum.PROXY_ADMIN,
      AaveGovernanceV2.SHORT_EXECUTOR,
      0
    );
    vm.stopBroadcast();
  }
}

contract DeployPolygon is Script {
  function run() external {
    vm.startBroadcast();

    Collector collector = new Collector();
    collector.initialize(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR, 0);

    new UpgradeAaveCollectorPayload(
      address(AaveV3Polygon.COLLECTOR),
      address(collector),
      MiscPolygon.PROXY_ADMIN,
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR,
      DEFAULT_STREAM_ID
    );

    vm.stopBroadcast();
  }
}

contract DeployAvalanche is Script {
  function run() external {
    vm.startBroadcast();

    Collector collector = new Collector();
    collector.initialize(address(0xa35b76E4935449E33C56aB24b23fcd3246f13470), 0); // Avalanche v3 Guardian

    new UpgradeAaveCollectorPayload(
      address(AaveV3Avalanche.COLLECTOR),
      address(collector),
      MiscAvalanche.PROXY_ADMIN,
      address(0xa35b76E4935449E33C56aB24b23fcd3246f13470), // Avalanche v3 Guardian
      DEFAULT_STREAM_ID
    );

    vm.stopBroadcast();
  }
}

contract DeployOptimism is Script {
  function run() external {
    vm.startBroadcast();

    Collector collector = new Collector();
    collector.initialize(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR, 0);

    new UpgradeAaveCollectorPayload(
      address(AaveV3Optimism.COLLECTOR),
      address(collector),
      MiscOptimism.PROXY_ADMIN,
      AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR,
      DEFAULT_STREAM_ID
    );
    vm.stopBroadcast();
  }
}

contract DeployArbitrum is Script {
  function run() external {
    vm.startBroadcast();

    Collector collector = new Collector();
    collector.initialize(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR, 0);

    new UpgradeAaveCollectorPayload(
      address(AaveV3Arbitrum.COLLECTOR),
      address(collector),
      MiscArbitrum.PROXY_ADMIN,
      AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR,
      DEFAULT_STREAM_ID
    );
    vm.stopBroadcast();
  }
}

contract DeployFantom is Script {
  function run() external {
    vm.startBroadcast();

    Collector collector = new Collector();
    collector.initialize(address(0xf71fc92e2949ccF6A5Fd369a0b402ba80Bc61E02), 0); // Guardian

    new UpgradeAaveCollectorPayload(
      address(AaveV3Fantom.COLLECTOR),
      address(collector),
      // MiscFantom.PROXY_ADMIN,
      address(0xf71fc92e2949ccF6A5Fd369a0b402ba80Bc61E02), // Guardian
      address(0xf71fc92e2949ccF6A5Fd369a0b402ba80Bc61E02), // Guardian
      DEFAULT_STREAM_ID
    );
    vm.stopBroadcast();
  }
}

// contract DeployHarmony is Script {
//   function run() external {
//     vm.startBroadcast();
//     new UpgradeAaveCollectorPayload(
//       AaveV3Harmony.COLLECTOR,
//       address(0) // Guardian
//     );
//     vm.stopBroadcast();
//   }
// }
