// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./OPR/upgradeable/DefaultOperatorFiltererUpgradeable.sol";

contract SBCMinting is  DefaultOperatorFiltererUpgradeable, ERC721URIStorage, Ownable {
    
    // IERC721 SBCColletion;

    using Counters for Counters.Counter;
    using Counters for uint256;
    
    bool public lockingState = true;
    uint256 public MAX_SUPPLY;
    uint256 public totalMinted;
    address contractOwner;

    constructor(
        string memory _name,
        string memory _symbol
        // bool lockingState,
        // IERC721 _SBCCollection
    ) ERC721(_name, _symbol) {
        contractOwner = msg.sender;
        MAX_SUPPLY = 1111;
        totalMinted = 0;
    }

    function minting(string memory _baseURI) external {
        uint256 tokenId = totalMinted ++;
        safeMint(tokenId);
        _setTokenURI(tokenId, _baseURI);
    }

    function safeMint(uint256 _tokenId) internal {
        require(_tokenId < MAX_SUPPLY, "over minting state");
        _safeMint(msg.sender, _tokenId);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public override(IERC721, ERC721) {
        require(
            lockingState == false,
            "Cannot transfer - currently locked"
        );
        super.transferFrom(_from, _to, _tokenId);
    }

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory data
    ) public override(IERC721, ERC721) {
        require(
            lockingState == false,
            "Cannot transfer - currently locked"
        );
        super.safeTransferFrom(_from, _to, _tokenId, data);
    }

    function modifyLockingState() external onlyOwner {
        lockingState = true;
    }
}
