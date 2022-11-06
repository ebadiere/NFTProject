//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import {console} from "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


error MintPriceNotPaid();
error MaxSupply();

contract VolcanoNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    uint256 public constant TOTAL_SUPPLY = 10_000;
    uint256 public constant MINT_PRICE = 0.01 ether;

    constructor() ERC721("VolcanoNFT", "NFT") {}

    function mintNFT(address recipient, string memory tokenURI)
        public payable onlyOwner
        returns (uint256)
    {
        console.log("%s: %d", "msg.value", msg.value);
        if (msg.value != MINT_PRICE) {
            revert MintPriceNotPaid();
        }
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
