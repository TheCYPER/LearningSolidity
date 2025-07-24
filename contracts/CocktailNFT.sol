// contracts/CocktailNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract CocktailNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;

    constructor() ERC721("CocktailNFT", "COCKTAIL") Ownable(msg.sender) {}

    // 铸造NFT，to为接收者，tokenURI为元数据链接
    function mint(address to, string memory tokenURI) external onlyOwner returns (uint256) {
        uint256 tokenId = nextTokenId;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        nextTokenId++;
        return tokenId;
    }
}
