// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import "../src/VolcanoNFT.sol";

import {Utils} from "./utils/Utils.sol";

contract VolcanoNFTTest is Test {
    Utils internal utils;

    address payable[] internal users;

    address internal alice;
    address internal bob;
    address internal dave;

    VolcanoNFT public volcanoNFT;

    function setUp()public {
        utils = new Utils();
        users = utils.createUsers(3);
        alice = users[0];
        vm.label(alice, "Alice");
        bob = users[1];
        vm.label(bob, "Bob");
        dave = users[2];

        vm.prank(address(dave));
        volcanoNFT = new VolcanoNFT();
    }

    function testMint() public {
        vm.prank(address(dave));
        uint256 itemId = volcanoNFT.mintNFT{value: 0.01 ether}(address(alice), "https://pixabay.com/photos/new-zealand-volcano-crater-3018634/");
        assert(itemId > 0);
        assertEq(volcanoNFT.balanceOf(address(alice)), 1);
    }

    function testTransfer() public {
        vm.prank(address(dave));
        uint256 itemId = volcanoNFT.mintNFT{value: 0.01 ether}(address(alice), "https://pixabay.com/photos/new-zealand-volcano-crater-3018634/"); 
        vm.prank(address(address(alice)));
        volcanoNFT.approve(address(bob), itemId);
        vm.prank(address(dave)); 
        volcanoNFT.transferOwnership(address(bob));
        assertEq(volcanoNFT.owner(), address(bob));
    }

}