//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";//包含ERC-721标准的实现，我们的NFT智能合约将继承这个标准。(要成为一个有效的NFT，你的智能合约必须实现ERC-721标准的所有方法)
import "@openzeppelin/contracts/utils/Counters.sol";//提供了只能加 1或减1 的计数器。我们的智能合约使用计数器来跟踪已铸币的NFT总数，并在我们的新NFT上设置唯一的ID。(每个使用智能合约铸造的NFT必须被分配一个唯一的ID-- 在本文案例中，我们的唯一ID只是由存在的NFT总数决定。例如，我们用智能合约铸造的第一个NFT的ID是 1，我们的第二个NFT的ID是 2，等等）
import "@openzeppelin/contracts/access/Ownable.sol";//在我们的智能合约上设置了访问控制，所以只有智能合约的所有者（你）可以铸币NFT。(注意，包括访问控制完全是一种偏好。如果你希望任何人都能使用你的智能合约铸造NFT，请删除第10行的Ownable一词和第17行的onlyOwner）
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    //构造函数中，传递了两个字符串，MyNFT 和 NFT。第一个变量是智能合约的名称，第二个是其符号。可以随心所欲地给这些变量命名!
    constructor() ERC721("MyNFT", "NFT") {}

    /*
    铸造NFT的函数，接收两个变量；mintNFT 从继承的ERC-721库中调用一些方法，并最终返回一个数字，代表新铸造的 NFT 的ID
    address recipient指定将收到你新铸的NFT的地址
    string memory tokenURI是一个字符串，应该解析为一个描述NFT元数据的JSON文档。NFT的元数据实际上是给它带来生命的东西，允许它有可配置的属性，如名称、描述、图像和其他属性
    */
    function mintNFT(address recipient, string memory tokenURI)
        public onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
