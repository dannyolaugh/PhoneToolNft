pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract PhoneToolIcon is ERC721Enumerable {
  address _owner;
  constructor() ERC721("PhoneToolIcon", "ICON") {
          _owner = msg.sender;
  }
}
