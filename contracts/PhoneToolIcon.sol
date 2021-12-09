// contracts/Phone.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./PhoneToolIconLibrary.sol";

contract PhoneToolIcon is ERC721Enumerable {

    using PhoneToolIconLibrary for uint8;

    //Mappings
    mapping(string => bool) svgToMinted;
    mapping(uint256 => string) internal tokenIdToSvg;
    mapping(address => string) addressToAlias;
    mapping(string => bool) aliasToMintedFoundationsIcon;

    //uint256s
    uint256 MAX_SUPPLY = 10000;

    //address
    address _owner;

    constructor() ERC721("PhoneToolIcon", "ICON") {
        _owner = msg.sender;
    }

    /*
  __  __ _     _   _             ___             _   _
 |  \/  (_)_ _| |_(_)_ _  __ _  | __|  _ _ _  __| |_(_)___ _ _  ___
 | |\/| | | ' \  _| | ' \/ _` | | _| || | ' \/ _|  _| / _ \ ' \(_-<
 |_|  |_|_|_||_\__|_|_||_\__, | |_| \_,_|_||_\__|\__|_\___/_||_/__/
                         |___/
   */

    /**
     * @dev Mints new tokens.
     */
    function mintFoundationsIcon(string memory _alias) public {
        uint256 _totalSupply = totalSupply();
        require(_totalSupply < MAX_SUPPLY);
        require(!PhoneToolIconLibrary.isContract(msg.sender));
        require(aliasToMintedFoundationsIcon[addressToAlias[msg.sender]] != true);

        uint256 thisTokenId = _totalSupply;

        tokenIdToSvg[thisTokenId] = '<svg width="116" height="30" viewBox="0 0 116 30" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><rect width="116" height="30" fill="url(#pattern0)"/><defs><pattern id="pattern0" patternContentUnits="objectBoundingBox" width="1" height="1"><use xlink:href="#image0_1_4" transform="scale(0.00862069 0.0333333)"/></pattern><image id="image0_1_4" width="116" height="30" xlink:href="data:image/jpeg;base64,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"/></defs></svg>';

        svgToMinted[tokenIdToSvg[thisTokenId]] = true;
        addressToAlias[msg.sender] = _alias;
        aliasToMintedFoundationsIcon[addressToAlias[msg.sender]] = true;

        _mint(msg.sender, thisTokenId);
    }

    function mintQuipsterIcon(string memory _alias) public {
        uint256 _totalSupply = totalQuipsterSupply();
        require(_totalSupply < MAX_SUPPLY);
        require(!PhoneToolIconLibrary.isContract(msg.sender));
        require(aliasToMintedFoundationsIcon[addressToAlias[msg.sender]] != true);

        uint256 thisTokenId = _totalSupply;

        // TODO: Add the SVG Code here
        tokenIdToSvg[thisTokenId] = '';
        svgToMinted[tokenIdToSvg[thisTokenId]] = true;
        addressToAlias[msg.sender] = _alias;
        aliasToMintedFoundationsIcon[addressToAlias[msg.sender]] = true;

        _mint(msg.sender, thisTokenId);
    }

    /*
 ____     ___   ____  ___        _____  __ __  ____     __ ______  ____  ___   ____   _____
|    \   /  _] /    ||   \      |     ||  |  ||    \   /  ]      ||    |/   \ |    \ / ___/
|  D  ) /  [_ |  o  ||    \     |   __||  |  ||  _  | /  /|      | |  ||     ||  _  (   \_
|    / |    _]|     ||  D  |    |  |_  |  |  ||  |  |/  / |_|  |_| |  ||  O  ||  |  |\__  |
|    \ |   [_ |  _  ||     |    |   _] |  :  ||  |  /   \_  |  |   |  ||     ||  |  |/  \ |
|  .  \|     ||  |  ||     |    |  |   |     ||  |  \     | |  |   |  ||     ||  |  |\    |
|__|\_||_____||__|__||_____|    |__|    \__,_||__|__|\____| |__|  |____|\___/ |__|__| \___|

*/

    /**
     * @dev Returns the SVG and metadata for a token Id
     * @param _tokenId The tokenId to return the SVG and metadata for.
     */
    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(_exists(_tokenId));
        return tokenIdToSvg[_tokenId];
    }

    /**
     * @dev Returns the tokens of a given wallet. Mainly for ease for frontend devs.
     * @param _wallet The wallet to get the tokens of.
     */
    function walletOfOwner(address _wallet)
        public
        view
        returns (uint256[] memory)
    {
        uint256 tokenCount = balanceOf(_wallet);

        uint256[] memory tokensId = new uint256[](tokenCount);
        for (uint256 i; i < tokenCount; i++) {
            tokensId[i] = tokenOfOwnerByIndex(_wallet, i);
        }
        return tokensId;
    }

    /*

  ___   __    __  ____     ___  ____       _____  __ __  ____     __ ______  ____  ___   ____   _____
 /   \ |  |__|  ||    \   /  _]|    \     |     ||  |  ||    \   /  ]      ||    |/   \ |    \ / ___/
|     ||  |  |  ||  _  | /  [_ |  D  )    |   __||  |  ||  _  | /  /|      | |  ||     ||  _  (   \_
|  O  ||  |  |  ||  |  ||    _]|    /     |  |_  |  |  ||  |  |/  / |_|  |_| |  ||  O  ||  |  |\__  |
|     ||  `  '  ||  |  ||   [_ |    \     |   _] |  :  ||  |  /   \_  |  |   |  ||     ||  |  |/  \ |
|     | \      / |  |  ||     ||  .  \    |  |   |     ||  |  \     | |  |   |  ||     ||  |  |\    |
 \___/   \_/\_/  |__|__||_____||__|\_|    |__|    \__,_||__|__|\____| |__|  |____|\___/ |__|__| \___|

    /**
     * @dev Transfers ownership
     * @param _newOwner The new owner
     */
    function transferOwnership(address _newOwner) public onlyOwner {
        _owner = _newOwner;
    }

    /**
     * @dev Modifier to only allow owner to call functions
     */
    modifier onlyOwner() {
        require(_owner == msg.sender);
        _;
    }
}
