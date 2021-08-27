pragma solidity >=0.7.0 <0.9.0;

contract Insurance{
    struct User {
        uint id;
        address ad;
        string name;
        ufixed claimable;
        int role;
    }
    mapping(uint => User) public user;
    mapping(address => user) private userAddress;
    struct Claim {
        uint claimId;
        address claimBy;
        ufixed claimAmount;
        string claimStatus;
    }
    mapping(uint => Claim) public claim;
    struct Renew{
        uint renewId;
        ufixed amount;
        bool approvalStatus;
    }
    mapping(uint => Renew) public renew;
    uint public userCount;
    uint public claimCount;
    uint public renewCount;
    
    constructor () public {
        
    }
    
    function addUser(string memory _name, address _address, ufixed _claimable) public {
        require(userAddress[msg.sender].role<2);
        userCount++;
        user[userCount]=User(userCount, _address, _name,_claimable,3);
    }
    function requestClaim(ufixed _claimAmount) public {
        require(userAddress[msg.sender].role==3);
        require(_claimAmount<=userAddress[msg.sender].claimable);
        claimCount++;
        claim[claimCount]=Claim(claimCount,msg.sender,_claimAmount,"Pending|Not Approved");
    }
    function verifyClaim(string memory _status) public {
        require(userAddress[msg.sender].role==2);
        
        
    }
    function viewClaimStatus(uint _claimId) public view returns(string memory) {
        return claim[_claimId].claimStatus;
    }
    
}