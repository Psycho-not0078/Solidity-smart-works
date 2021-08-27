pragma solidity ^0.8.4;

contract Insurance{
    struct User {
        uint id;
        address ad;
        string name;
        uint claimable;
        int role;
    }
    mapping(uint => User) public user;// mapping a user to a integer 
    mapping(address => User) private userAddress;//mapping a user to his/her address to check if a incoming request is from which role user
    
    struct Claim {
        uint claimId;
        address claimBy;
        uint claimAmount;
        string claimStatus;
    }
    mapping(uint => Claim) public claim;//mapping a claim to a integer
    
    struct Renew{
        uint renewId;
        address renewer;
        uint amount;
    }
    mapping(uint => Renew) public renew;//mapping a renew request to a integer
    
    uint public userCount;//counter
    uint public claimCount;//counter
    uint public renewCount;//counter
    
    constructor() public {
        init(msg.sender);
    }
    
    struct ret{
        uint claimid;
        string name;
        uint amt;
        string status;
    }
    
    function addUser(string memory _name, address _address, uint _claimable) public {// function to add customer
        require(userAddress[msg.sender].role==1);
        userCount++;
        user[userCount]=User(userCount, _address, _name,_claimable,3);
        userAddress[_address]=User(userCount, _address, _name,_claimable,3);
    }
    
    function addUser(string memory _name, address _address,int _role) public {// the function to add user that is not a customer
        require(userAddress[msg.sender].role==1);
        userCount++;
        user[userCount]=User(userCount, _address, _name,0,_role);
        userAddress[_address]=User(userCount, _address, _name,0,_role);
    }
    
    function init(address _address) private {//the function to add a admin user
        userCount++;
        userAddress[_address]=User(userCount, _address, "Admin",0,1);
        user[userCount]=User(userCount, _address, "Admin",0,1);
    }
    
    function requestClaim(uint _claimAmount) public {//the  claim request function
        require(userAddress[msg.sender].role==3);
        require(_claimAmount<=userAddress[msg.sender].claimable);
        claimCount++;
        claim[claimCount]=Claim(claimCount,msg.sender,_claimAmount,"Pending|Not Approved");
    }
    
    function verifyClaim(int _status,uint _claimId) public {// the verification function
        require(userAddress[msg.sender].role==2);
        if (_status==1){
            claim[_claimId].claimStatus="Verified|Not Approved";
        }
        else{
            claim[_claimId].claimStatus="Not Verified|Not Approved";
        }
    }
    
    function claimStatusChange(int _status, uint _claimId) public {// the approval function
        require(userAddress[msg.sender].role==1);
        if (_status==1){
            claim[_claimId].claimStatus="Verified|Approved";
        }
        else{
            claim[_claimId].claimStatus="Verified|Not Approved";
        }
    }
    
    function viewClaim(uint _claimid) public view returns(ret memory){
        require(userAddress[msg.sender].role==1);
        
        string memory Claimer = userAddress[claim[_claimid].claimBy].name;
        uint Amt=claim[_claimid].claimAmount;
        string memory status=claim[_claimid].claimStatus;
        
        return ret(_claimid,Claimer,Amt,status);
    }
    
    function renewal(uint _amount) public{
        require(userAddress[msg.sender].role==3);
        renewCount++;
        renew[renewCount]=Renew(renewCount,msg.sender,_amount);
        userAddress[msg.sender].claimable+=_amount;
        user[userAddress[msg.sender].id].claimable+=_amount;
    }
}