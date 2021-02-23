// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "https://github.com/0xcert/ethereum-erc721/src/contracts/tokens/nf-token-metadata.sol";
import "https://github.com/0xcert/ethereum-erc721/src/contracts/tokens/nf-token-enumerable.sol";
import "https://github.com/0xcert/ethereum-erc721/src/contracts/ownership/ownable.sol";

/**
 * @dev This is an example contract implementation of NFToken with metadata extension.
 */
contract SNFT is
NFTokenMetadata,
Ownable
{

    /**
     * @dev Contract constructor. Sets metadata extension `name` and `symbol`.
     */
    constructor()
    {
        nftName = "Smart Narrative";
        nftSymbol = "SNFT";
    }

    /**
     * @dev Mints a new NFT.
     * @param _to The address that will own the minted NFT.
     * @param _tokenId of the NFT to be minted by the msg.sender.
     * @param _uri String representing RFC 3986 URI.
     */
    function createNode(
        address _to,
        uint256 _tokenId,
        string calldata _uri
    )
    external
    onlyOwner
    {
        super._mint(_to, _tokenId);
        super._setTokenUri(_tokenId, _uri);
    }

    function deleteNode(
        uint256 _tokenId
    )
    external
    onlyOwner
    {
        super._burn(_tokenId);
    }

}
