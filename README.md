# Solidity-smart-works
Insurance Claim System:
A User is added to the system if covered by the particular insurance,
there will be 3 types of Users, Customers, verifiers, management.
The Users request for a claim, the verifiers verify the claim and the management
approves the claims, adds customers into the system.
The Customer may not verify the documents or add other customers into the system.
The verifier cannot request/approve a claim and cannot add/reomve Customers into the system.
The management cannot do the actions of the verifiers or the customers.

this implies that the user's role defines the possible function calls.

the functions in the systems are:
AddNewUser(Username, Details)
RequestClaim(ClaimDetails)
VerifyClaim(ClaimId,Status)
ApproveClaim(ClaimId,Result)
ViewClaimStatus(ClaimId)
RemoveClaim(ClaimId)
RemoveUser(Username)
