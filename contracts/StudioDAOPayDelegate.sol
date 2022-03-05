pragma solidity ^0.8.0;

//import "@jbx-protocol/contracts-v2/contracts/interfaces/IJBPayDelegate.sol";
import './interfaces/IJBPayDelegate.sol';
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract NFTRewards is ERC721URIStorage, IJBPayDelegate, Ownable, AccessControl  {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    uint256 constant BRONZE  = 1000000000000000;
    uint256 constant SILVER  = 10000000000000000;
    uint256 constant GOLD    = 1000000000000000000;

    address trusted_caller;

    bytes32 public constant TRUSTED_CALLER_ROLE = keccak256("TRUSTED_CALLER_ROLE");

    constructor() ERC721("StudioRewards", "STDIOR") {
        _setupRole(TRUSTED_CALLER_ROLE, msg.sender);
    }

    function setTrustedCaller(address new_trusted_caller) public onlyOwner {
        _setupRole(TRUSTED_CALLER_ROLE, new_trusted_caller);
    }

    function didPay(JBDidPayData calldata _param) public override {
        require(hasRole(TRUSTED_CALLER_ROLE, msg.sender), "Caller is not a trusted caller");

        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(_param.payer, newItemId);
        if (_param.amount < BRONZE) {
            _setTokenURI(newItemId, "https://gateway.pinata.cloud/ipfs/QmV4eDCDfYoaBcCoTU6ce9DSq2SFv4dEm7c8wkBEdWYVVD");
        } else if (_param.amount >= BRONZE && _param.amount < SILVER) {
            _setTokenURI(newItemId, "https://gateway.pinata.cloud/ipfs/QmY9T2yY65aCrASiwRuH98NxyQTbceSWuM5A1Mmg3S9CHA");
        } else if (_param.amount >= SILVER && _param.amount < GOLD) {
            _setTokenURI(newItemId, "https://gateway.pinata.cloud/ipfs/QmXupnWuoCF18ZX4CJcHZTVc5GjkYWorXqjypnEGSpaM3d");
        } else if (_param.amount >= GOLD) {
            _setTokenURI(newItemId, "https://gateway.pinata.cloud/ipfs/QmdkHedPr3et5kKQELy56M1fQvLBvPF9KkuTK9dTtpFRjg");
        }
        
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
    
}
