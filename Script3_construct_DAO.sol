// SPDX-License-Identifier: GPL-3.0
//https://github.com/ehteshaxm/CharityDAO/blob/master/ethereum/contracts/CharityDAO.sol
pragma solidity '0.8.9';

contract DAO {

    address DAOAddress = address(this);

    uint public memberBuyin;
    uint memberCount;
    mapping(address => bool) public members;

    User[] public allUsers;
    mapping(address => bool) public users;
    mapping(address => User) public metamaskAssociatedUser;

    constructor(uint buyin) {
        memberBuyin = buyin;
    }

    function createMember() public payable {
        require(!users[msg.sender]);
        require(!members[msg.sender]);
        require(msg.value == memberBuyin);
        memberCount++;
        members[msg.sender] = true;
    }

    function createUser(string memory name, string memory description, string memory locationAddress, string memory phone, string memory email) public {
        require(!members[msg.sender]);
        require(!users[msg.sender]);
        User newUser = new User(name, description, locationAddress, phone, email, msg.sender, DAOAddress);
        users[msg.sender] = true;
        allUsers.push(newUser);
        metamaskAssociatedUser[msg.sender] = newUser;
    }

    function getAllUsers() public view returns(User[] memory){
        return allUsers;
    }

    function getPoolAmount() public view returns(uint) {
        return address(this).balance; //get smart contract balance
    }

    function addToPool() public payable {
        require(msg.value > 0); 
    }

    function transact(address payable recipient, uint value) public {
        recipient.transfer(value);
    }


    function isAMember(address member) public view returns(bool) {
        bool ans = members[member];
        return ans;
    }

     function isAUser(address user) public view returns(bool) {
        bool ans = users[user];
        return ans;
     }

    function getMemberCount() public view returns(uint) {
        return memberCount;
    }

}
