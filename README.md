# reWILD DAO
rewildao\logo.jpg



## Project Description
For our DAO Investors, we enable easy participation in a natural carbon capture process, through our support of a forest creation service that is continuously tracked and transparent, to recreate the lungs of the earth and support new forest development on non-productive agriculture land. Bringing together a community of individuals to pool their money and vote on usage of forest creation. The DAO is a global and scalable way to restore forest cover. It provides the opportunity to participate in conservation by creating real world forests and experiencing their digital recreation in the metaverse. reWILD DAO is a crowdfunding ecosystem in the blockchain which is orchestrated in a smart contract. The smart contracts are developed in Solidity

Features & Benefits: Rewilding, Carbon Capture, Education/ contribution, Transparency, Monitoring & Tracking Tools, Wilding the Metaverse


## Demo 
add image with url link 
rewildao\reWILD DAO - Figma - 22 June 2022.mp4

## Pitch video
add image with url link 
rewildao\reWILD DAO - Presentation - 23 June 2022.mp4


## Smart contract addresses: 
The smart contracts are accessible on the celo blockchain 

Smart contract 1 address:
Smart contract 2 address: 
Smart contract 2 address: 

## Tech Stack 
* Solidity 
* Remix IDE 
* Openzepplin 
* Javascript 

## Files
This repo contains 4 files namely:
* `voting_ballet.sol` : Solidity file for the smart contract to vote on proposals
* `chairtysmartcontract.sol` : Charity smart contract
* `createBytes.js` : Convert strings to Byte32
* `parseBytes.js` : Convert strings to Byte32

##  Smart Contract 1 
### Description: 
`voting_ballet.sol` smart contract include the following functionalities:
* `giveRightToVote` : Function returns a boolean (i.e. true or false). If true, a voter as already voted or delegate his or her right to vote to another voter, and if false, voter has not voted yet and has a weight (voting power) = 1
* `delegate` : Delegate votes to another voter
* `vote` : Give vote (including votes delegated to self) to proposal `proposals[proposal].name`
* `winningProposal` : Computes the winning proposal taking all previous votes into account
* `winnerName` : Calls the `winningProposal()` function to get the index of the winner contained in the proposals array and then returns the name of the winner

## Smart Contract 2
### Description: 
Main components of the `chairtysmartcontract.sol` include:
* `createProposal` :  Interacts with blockchain state, which we can call in our dApp to add a new Proposal, it accepts three parameters: `description`, `charityAddress` and `amount`
* `vote` : An external function that allows voting on proposals when called with the proposal’s id and a second true/false argument depending on whether the vote is in support or against the proposal
* `votable` : Verifies if a proposal can be voted on
* `payCharity` : Handles payment to the specified address after the voting period of the proposal has ended. It takes the proposalId as an argument and retreives that proposal from the mapping
* `makeStakeholder` : Adds a new Stakeholder to the DAO if the total contribution of the user is more than or equal to 5 Celo. If the total contribution is less than 5 then the user is made a Contributor instead
* `getProposals` : Returns a list of all the proposals in the DAO here
* `getProposal` : Takes a proposal id as an argument to get the proposal from the mapping, then return the proposal
* `getStakeholderVotes` : Gets and returns a list containing the id of all the proposals that a particular stakeholder has voted on
* `getStakeholderBalance` : Returns the total amount of contribution a stakeholder has contributed to the DAO
* `isStakeholder` : Returns true or false depending on whether the caller is a stakeholder or not
* `getContributorBalance` : Returns the total balance of a contributor
* `isContributor` : Returns true or false depending on whether the caller is a contributor or not



