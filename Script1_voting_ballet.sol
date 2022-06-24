// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.9 < 0.8.15;

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract Ballot {

    struct Voter {
        uint weight; // weight is accumulated by delegation. Note that delegation is involved at this point. 
        bool voted;  // if true, that person already voted
        address delegate; // person delegated to. This is used if I want to delegate my vote to someone else 
        uint vote;   // index of the voted proposal
    }

    struct Proposal {
        // If you can limit the length to a certain number of bytes, 
        // always use one of bytes1 to bytes32 because they are much cheaper
        bytes32 name;   // short name (up to 32 bytes)
        uint voteCount; // number of accumulated votes
    }

    address public chairperson; // can be viewed from inside and outside the contract (example and web app)

    mapping(address => Voter) public voters; //voters variable, and the key is address. the value at the key is Voter. Voter is defined above as a struct

    Proposal[] public proposals; // array initalized as an empty array. 

    /** 
     * @dev Create a new ballot to choose one of 'proposalNames'.
     * @param proposalNames names of proposals
     */
    constructor(bytes32[] memory proposalNames) { // takes an array of proposal names of type byte 32
        chairperson = msg.sender;
        voters[chairperson].weight = 1; //set the chairperson vote weigth as 1

        for (uint i = 0; i < proposalNames.length; i++) {
            // 'Proposal({...})' creates a temporary
            // Proposal object and 'proposals.push(...)'
            // appends it to the end of 'proposals'.
            proposals.push(Proposal({ // array of proposals. Within which there is a Proposal struct (defined above). Loop over all proposal names and set the votecount to zero
                name: proposalNames[i], // type of byte 32 
                voteCount: 0 // initially set to zero 
            }));
        }
    }

    /** 
     * @dev Give 'voter' the right to vote on this ballot. May only be called by 'chairperson'.
     * @param voter address of voter
     */
     // This is the function to add the checks 
    function giveRightToVote(address voter) public { // argument is the address 
        require( // checks that the message sender is the chairperson 
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );
        require( // checks if the voter has not already voted by looking at the voter mapping 
            !voters[voter].voted, // check vote boolean is false. If true then the message below appears 
            "The voter already voted."
        );
        require(voters[voter].weight == 0); // check that voter didnt give the right to vote 
        voters[voter].weight = 1; // set weight of the voter to 1, then they are allowed to vote 
    }

    /**
     * @dev Delegate your vote to the voter 'to'.
     * @param to address to which vote is delegated
     */
     // Pass the address that I want to give the right to my vote to someone else (Address given)
    function delegate(address to) public { // argument is the address of 'to' which is the address that will get the delagted vote
        Voter storage sender = voters[msg.sender]; // get the sender address and store it in 'sender' using the mapping 'Voters'
        require(!sender.voted, "You already voted."); //check sender didnt already vote 
        require(to != msg.sender, "Self-delegation is disallowed."); // prevent self-delegation 

        while (voters[to].delegate != address(0)) {  // check for 'to' in 'voters'. If empty, then code proceeds. If not empty, then voter 
                                                    //delgated their vote to someone else
            to = voters[to].delegate; // assign the vote delagted to the delegation of 'to' (chain of delegation)

            // We found a loop in the delegation, not allowed.
            require(to != msg.sender, "Found loop in delegation."); // if the delegation chain makes a loop, its fails.
        }
        sender.voted = true; // set the voted boolean to true
        sender.delegate = to; // set the delegate to the address 'to' 
        Voter storage delegate_ = voters[to]; // create a new variable called 'delegate_' as the representation which the the address 'to'
        if (delegate_.voted) {  // the following condition either adds the sender weight to the decision made by the delegate or updates 
                                //the delegate weight
            // If the delegate already voted,
            // directly add to the number of votes
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            // If the delegate did not vote yet,
            // add to her weight.
            delegate_.weight += sender.weight;
        }
    }

    /**
     * @dev Give your vote (including votes delegated to you) to proposal 'proposals[proposal].name'.
     * @param proposal index of proposal in the proposals array
     */
    function vote(uint proposal) public { // takes in the proposal integer. Takes in the index of the proposal I want to vote to 
        // to vote for first item in proposal array, then input will be 0
        Voter storage sender = voters[msg.sender]; //store the voter address in sender 
        // Checks:
        require(sender.weight != 0, "Has no right to vote"); // check if the weight is not zero 
        require(!sender.voted, "Already voted."); // check boolean voted condition, make sure its false to be able to vote
        sender.voted = true; // set it to true 
        sender.vote = proposal; // set the vote in sender to the proposal selected 

        // If 'proposal' is out of the range of the array,
        // this will throw automatically and revert all
        // changes.
        proposals[proposal].voteCount += sender.weight; // increase vote count for the proposal voted for by the weight they have 
    }

    /** 
     * @dev Computes the winning proposal taking all previous votes into account.
     * @return winningProposal_ index of winning proposal in the proposals array
     */
    function winningProposal() public view 
            returns (uint winningProposal_) // Retrieve info for the winning proposal 
    {
        uint winningVoteCount = 0; //set to zero to initialize. loop over all proposals. winning is the one with the highest count in the loop
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) { // compare to previous highest 
                winningVoteCount = proposals[p].voteCount; //set winning proposal count 
                winningProposal_ = p; // set winning proposal 
            }
        }
    }

    /** 
     * @dev Calls winningProposal() function to get the index of the winner contained in the proposals array and then
     * @return winnerName_ the name of the winner
     */
    function winnerName() public view
            returns (bytes32 winnerName_) // retieve the winner name, which is the proposal name of the winning proposal 
    {
        winnerName_ = proposals[winningProposal()].name;
    }
}