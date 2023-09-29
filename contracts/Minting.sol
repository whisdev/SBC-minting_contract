// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Guardian/Erc721LockRegistry.sol";
import "./interfaces/IERC721xHelper.sol";
import "./OPR/upgradeable/DefaultOperatorFiltererUpgradeable.sol";

contract SBCMinting is ERC721x, DefaultOperatorFiltererUpgradeable, IERC721xHelper, ERC721URIStorage, Ownable {
    
    IERC721 SBCColletion;

    using Counters for Counters.Counter;
    using Counters for uint256;

    uint256 public MAX_SUPPLY;
    uint256 public totalMinted;
    address contractOwner;

    mapping (uint256=>bool) sendNFTLocked;

    constructor(
        string memory _name,
        string memory _symbol,
        IERC721 _SBCCollection
    ) ERC721(_name, _symbol) {
        contractOwner = msg.sender;
        MAX_SUPPLY = 1111;
        totalMinted = 0;
        SBCColletion = _SBCCollection;
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
        address _to,
        uint256 _tokenId
    ) public payable {
        require(
            sendNFTLocked[_tokenId] == false,
            "Cannot transfer - currently locked"
        );
        super.transferFrom(contractOwner, _to, _tokenId);
    }

    function safeTransferFrom(
        address _to,
        uint256 _tokenId,
        bytes memory data
    ) public payable {
        require(
            sendNFTLocked[_tokenId] == false,
            "Cannot transfer - currently locked"
        );
        super.safeTransferFrom(contractOwner, _to, _tokenId, data);
    }

    function setNFTLock (uint256 _tokenId) public onlyOwner{
        require(SBCColletion.ownerOf(_tokenId) == msg.sender, "Not Owner");
        sendNFTLocked[_tokenId] = true;
    }

    function setNFTUnLock (uint256 _tokenId) public onlyOwner {
        require(SBCColletion.ownerOf(_tokenId) == msg.sender, "Not Owner");
        sendNFTLocked[_tokenId] = false;
    }
}
