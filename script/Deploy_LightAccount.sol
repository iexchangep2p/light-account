// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";

import {IEntryPoint} from "account-abstraction/interfaces/IEntryPoint.sol";

import {LightAccount} from "../src/LightAccount.sol";

contract Deploy_LightAccount is Script {
    // Load entrypoint from env
    address public entryPointAddr = vm.envAddress("ENTRYPOINT");
    IEntryPoint public entryPoint = IEntryPoint(payable(entryPointAddr));

    // Load factory owner from env
    address public owner = vm.envAddress("OWNER");

    error InitCodeHashMismatch(bytes32 initCodeHash);
    error DeployedAddressMismatch(address deployed);

    function run() public {
        vm.startBroadcast();

        console.log("Cinfo", vm.activeFork());

        console.log("********************************");
        console.log("******** Deploy Inputs *********");
        console.log("********************************");
        console.log("Owner:", owner);
        console.log("Entrypoint:", address(entryPoint));
        console.log();
        console.log("********************************");
        console.log("******** Deploying.... *********");
        console.log("********************************");

        LightAccount account = new LightAccount{
            salt: 0x00000000000000000000000000000000000000005f1ffd9d31306e056bcc959c
        }(entryPoint, 0x612Dfa9fF8d6D19eff48A78D2827aC5a8F138596);

        // Deployed address check
  

        console.log("LightAccount:", address(account));
        // account.initialize(owner);
        // console.log("account initialised");

        vm.stopBroadcast();
    }

}
