// contracts/PhoneToolIcon.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./PhoneToolIconLibrary.sol";
import "./SvgContract.sol";

contract PhoneToolIcon is ERC721Enumerable {

    using PhoneToolIconLibrary for uint8;

    address public svgContractAddress;

    //Mappings
    mapping(string => bool) svgToMinted;
    mapping(uint256 => string) internal tokenIdToSvg;
    mapping(address => string) addressToAlias;
    mapping(string => bool) aliasToMintedFoundationsIcon;
    mapping(string => bool) aliasToMintedQuipsterIcon;

    //uint256s
    uint256 MAX_SUPPLY = 10000;

    //address
    address _owner;

    constructor(address _svgContractAddress) ERC721("PhoneToolIcon", "ICON") {
        _owner = msg.sender;
        svgContractAddress = _svgContractAddress;
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
        SvgContract svgContract = SvgContract(svgContractAddress);
        uint256 _totalSupply = totalSupply();
        require(_totalSupply < MAX_SUPPLY);
        require(!PhoneToolIconLibrary.isContract(msg.sender));
        require(aliasToMintedFoundationsIcon[addressToAlias[msg.sender]] != true);

        uint256 thisTokenId = _totalSupply;

        tokenIdToSvg[thisTokenId] = svgContract.getFoundationsSvg();

        svgToMinted[tokenIdToSvg[thisTokenId]] = true;
        addressToAlias[msg.sender] = _alias;
        aliasToMintedFoundationsIcon[addressToAlias[msg.sender]] = true;

        _mint(msg.sender, thisTokenId);
    }

    function mintMobileBetaIcon(string memory _alias) public {
        SvgContract svgContract = SvgContract(svgContractAddress);
        uint256 _totalSupply = totalSupply();
        require(_totalSupply < MAX_SUPPLY);
        require(!PhoneToolIconLibrary.isContract(msg.sender));
        require(aliasToMintedQuipsterIcon[addressToAlias[msg.sender]] != true);

        uint256 thisTokenId = _totalSupply;

        // TODO: Add the SVG Code here
        tokenIdToSvg[thisTokenId] = svgContract.getMobileBetaSvg();
        svgToMinted[tokenIdToSvg[thisTokenId]] = true;
        addressToAlias[msg.sender] = _alias;
        aliasToMintedQuipsterIcon[addressToAlias[msg.sender]] = true;

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
