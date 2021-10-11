// SPDX-License-Identifier: unlicenced

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract committee is ERC20{
    
    address payable owner;
    uint256 tokenAmount;
    uint256 interval;
    
    constructor(){
        owner = msg.sender;
        tokenAmount = 100;
    }
    
    struct committeeMembers{
        address member;
        string name;
    }
    
    committeeMembers[] public committeeMember;
    mapping(address => mapping(uint256 => bool)) paymentRecord;
    mapping(address => uint) numOfMembers;
    
    modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
    
    function addMembers(address _member, string memory _name) public onlyOwner{
        require( numOfMembers[_member] <= 10);
        committeeMember.push(committeeMembers(_member,_name));
        numOfMembers[_member]++;
    }
    
    function membersCommittee(address payable _member) external payable{
        require(tokenAmount == 100);
        require(committeeMembers.member[_member] == true);
        require(paymentRecord[_member][tokenAmount] = false);
        transferFrom(_member,owner,tokenAmount);
        paymentRecord[_member][tokenAmount] = true;
    }
    
    function payMembers(address payable _member, uint256 _committeeAmount) public payable onlyOwner{
        require( paymentRecord[_member][tokenAmount] == true);
        require(interval >= 30 days);
        transferFrom(owner,_member,_committeeAmount);
        for(int i = 0; i<=10 ; i++){
        paymentRecord[_member]+i[tokenAmount] = false;
    }
} 
}