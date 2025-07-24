// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contracts/CocktailNFT.sol";

contract CocktailNFTTest is Test {
    CocktailNFT nft;
    address owner;
    address user1;

    function setUp() public {
        owner = address(this);
        user1 = address(0x1111);
        nft = new CocktailNFT();
    }

    function testMintAndOwnership() public {
        string memory uri = "ipfs://example-metadata-uri";
        uint256 tokenId = nft.mint(user1, uri);
        assertEq(nft.ownerOf(tokenId), user1);
        assertEq(nft.tokenURI(tokenId), uri);
    }

    function testOnlyOwnerCanMint() public {
        string memory uri = "ipfs://example-metadata-uri";
        vm.prank(user1);
        vm.expectRevert();
        nft.mint(user1, uri);
    }
} 