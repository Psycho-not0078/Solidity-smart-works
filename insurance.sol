pragma solidity >=0.7.0 <0.9.0;

contract Insurance{
    struct User {
        uint id;
        address ad;
        string name;
        ufixed claimable;
        int role;
    }
    
    struct claim {
        uint claimId;
        string claimStatus;
    }
    
    struct renew{
        uint renewId;
        ufixed amount;
        bool approvalStatus;
    }
    uint public userCount;
    uint public claimCount;
    uint public renewCount;
    
    constructor () public {
        
    }
    
    function addUser() public view returns(string memory){
        
    }
    
}