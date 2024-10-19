// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import {Hooks} from "v4-core/libraries/Hooks.sol";
import {PoolManager} from "v4-core/PoolManager.sol";
import {MockERC20} from "solmate/test/utils/mocks/MockERC20.sol";

import {IPoolManager} from "v4-core/interfaces/IPoolManager.sol";
import {PointsHook} from "../src/PointsHook.sol";
import {HookMiner} from "../test/utils/HookMiner.sol";

/// @notice Forge script for deploying PointsHook to **anvil**
contract PointsHookDeploy is Script {
    address public constant CREATE2_DEPLOYER = 0x4e59b44847b379578588920cA78FbF26c0B4956C;

    function run() public {
        vm.startBroadcast();

        // Deploy PoolManager contract with the desired fee
        PoolManager manager = new PoolManager(500000); // Fee rate of 500000

        // Set the hook flags for AFTER_SWAP and AFTER_ADD_LIQUIDITY
        uint160 flags = uint160(
            Hooks.AFTER_SWAP_FLAG | Hooks.AFTER_ADD_LIQUIDITY_FLAG
        );

        // Mine a valid salt to generate the correct hook address
        (address hookAddress, bytes32 salt) = HookMiner.find(
            CREATE2_DEPLOYER,
            flags,
            1000, // Number of iterations to attempt
            type(PointsHook).creationCode,
            abi.encode(address(manager), "Points Token", "PTS")
        );

        // Deploy the PointsHook contract using CREATE2 with mined salt
        PointsHook pointsHook = new PointsHook{salt: salt}(
            IPoolManager(address(manager)),
            "Points Token",
            "PTS"
        );

        // Validate the hook address matches the mined address
        require(address(pointsHook) == hookAddress, "Hook address mismatch!");

        // Log the deployed hook address
        console.log("PointsHook deployed at:", address(pointsHook));

        vm.stopBroadcast();
    }


}
