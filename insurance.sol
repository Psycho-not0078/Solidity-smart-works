pragma solidity ^0.8.4;

contract Insurance{
    struct User {
        uint id;
        address ad;
        string name;
        uint claimable;
        int role;
    }
    mapping(uint => User) public user;
    mapping(address => User) private userAddress;
    
    struct Claim {
        uint claimId;
        address claimBy;
        uint claimAmount;
        string claimStatus;
    }
    mapping(uint => Claim) public claim;
    
    struct Renew{
        uint renewId;
        uint amount;
        bool approvalStatus;
    }
    mapping(uint => Renew) public renew;
    
    uint public userCount;
    uint public claimCount;
    uint public renewCount;
    
    constructor () public {
        init(msg.sender);
    }
    
    function addUser(string memory _name, address _address, uint _claimable) public {
        require(userAddress[msg.sender].role==1);
        userCount++;
        user[userCount]=User(userCount, _address, _name,_claimable,3);
        userAddress[_address]=User(userCount, _address, _name,_claimable,3);
    }
    
    function addUser(string memory _name, address _address,int _role) public {
        require(userAddress[msg.sender].role==1);
        userCount++;
        user[userCount]=User(userCount, _address, _name,0,_role);
        userAddress[_address]=User(userCount, _address, _name,0,_role);
    }
    
    function init(address _address) private {
        userCount++;
        userAddress[_address]=User(userCount, _address, "Admin",0,1);
        user[userCount]=User(userCount, _address, "Admin",0,1);
    }
    
    function requestClaim(uint _claimAmount) public {
        require(userAddress[msg.sender].role==3);
        require(_claimAmount<=userAddress[msg.sender].claimable);
        claimCount++;
        claim[claimCount]=Claim(claimCount,msg.sender,_claimAmount,"Pending|Not Approved");
    }
    
    function verifyClaim(int _status,uint _claimId) public {
        require(userAddress[msg.sender].role==2);
        if (_status==1){
            claim[_claimId].claimStatus="Verified|Not Approved";
        }
        else{
            claim[_claimId].claimStatus="Not Verified|Not Approved";
        }
    }
    
    function claimStatusChange(int _status, uint _claimId) public {
        require(userAddress[msg.sender].role==1);
        if (_status==1){
            claim[_claimId].claimStatus="Verified|Approved";
        }
        else{
            claim[_claimId].claimStatus="Verified|Not Approved";
        }
    }
    function viewClaimStatus(uint _claimId) public view returns(string memory) {
        return claim[_claimId].claimStatus;
    }
    
}