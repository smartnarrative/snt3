// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import "https://github.com/0xcert/ethereum-erc721/src/contracts/tokens/nf-token-metadata.sol";
import "https://github.com/0xcert/ethereum-erc721/src/contracts/ownership/ownable.sol";

contract snnNFT is NFTokenMetadata, Ownable {

    constructor() {
        nftName = "SmartNarrative";
        nftSymbol = "SNN";
    }

    function mint(address _to, uint256 _tokenId, string calldata _uri) external onlyOwner {
        super._mint(_to, _tokenId);
        super._setTokenUri(_tokenId, _uri);
    }

    function getTokenURI(uint256 _tokenId) external view onlyOwner returns (string memory) {
        return super._tokenURI(_tokenId);
    }
}
