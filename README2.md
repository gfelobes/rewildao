# reWILD DAO

## Project Description
Bringing together a community of individuals to pool their money and vote on usage of forest creation. The DAO is a global and scalable way to restore forest cover. It provides the opportunity to participate in conservation by creating real world forests and experiencing their digital recreation in the metaverse. 

reWILD DAO is a crowdfunding ecosystem in the blockchain which is orchestrated in a smart contract. The smart contracts are developed in Solidity

## Problem Statement

## Dependencies
* Truffle
* ganache
* Node.js

## Files
This repo contains 4 files namely:
* `voting_ballet.sol` : Solidity file for the smart contract to vote on proposals
* `chairtysmartcontract.sol` : Charity smart contract
* `createBytes.js` : Convert strings to Byte32
* `parseBytes.js` : Convert strings to Byte32

##  Smart Contract Features
`voting_ballet.sol` smart contract include the following functionalities:
* `giveRightToVote` : Function returns a boolean (i.e. true or false); is true, a voter as already voted or delegate his or her right to vote to another voter, and if false, voter has not voted yet and has a weight (voting power) = 1.
* `delegate` : Delegate votes to another voter
* `vote` : Give vote (including votes delegated to self) to proposal 'proposals[proposal].name'
* `winningProposal` : Computes the winning proposal taking all previous votes into account
* `winnerName` : Calls winningProposal() function to get the index of the winner contained in the proposals array and then returns the name of the winner

Main conmponents of the `chairtysmartcontract.sol` include:
* `giveRightToVote` : 
