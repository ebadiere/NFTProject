// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/VolcanoNFT.sol";

import {Utils} from "./utils/Utils.sol";

contract VolcanoNFTTest is Test {
    Utils internal utils;

    address payable[] internal users;

    address internal alice;
    address internal bob;

    VolcanoNFT public volcanoNFT;

    function setUp()public {
        utils = new Utils();
        users = utils.createUsers(2);
        alice = users[0];
        vm.label(alice, "Alice");
        bob = users[1];
        vm.label(bob, "Bob");

        volcanoNFT = new VolcanoNFT();
    }

    function testMint() public {
        uint256 itemId = volcanoNFT.mintNFT(alice, "https://pixabay.com/photos/new-zealand-volcano-crater-3018634/");
        assert(itemId > 0);
        assertEq(volcanoNFT.balanceOf(alice), 1);
    }

    function testTransfer() public {
        uint256 itemId = volcanoNFT.mintNFT(alice, "https://pixabay.com/photos/new-zealand-volcano-crater-3018634/"); 
        vm.prank(address(alice));
        volcanoNFT.approve(bob, itemId);
        volcanoNFT.transferOwnership(bob);
        assertEq(volcanoNFT.owner(), bob);
    }

}