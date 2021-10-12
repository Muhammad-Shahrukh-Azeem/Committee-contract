// SPDX-License-Identifier: unlicenced

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract committee is ERC20{
    
    uint256 tokenAmount = 100;
    uint256 interval;
    bool sucess;
    address _owner;
    uint256 intervalCount = 0;
    
    struct advanceFee{
        address newMember;
        uint256 advanceFee;
     }
    struct committeeMembers{
        address member;
        string name;
    }
    
    committeeMembers[] public committeeMember;
    
    mapping(address => advanceFee) public entranceSecurity;
    mapping(address => mapping(uint256 => bool)) paymentRecord;
    mapping(address => uint) numOfMembers;
    
    modifier onlyOwner() {
    require(msg.sender == _owner);
    _;
  }
    function AdvanceFee(address _newMember,uint256 _advanceFee) external payable{
        require(_advanceFee == tokenAmount*5);
        _transfer(_newMember,_owner,_advanceFee);
        entranceSecurity[] = advanceFee(_newMember,_advanceFee);
    }
    
    function addMembers(address _member, string memory _name) public{
        require( numOfMembers[_member] <= 10);
        require(transferFrom(_member,msg.sender,advanceFee));
        committeeMember.push(committeeMembers(_member,_name));
        numOfMembers[_member]++;
    }
    
    function membersCommittee(address _member,address payable _owner) external payable{
        require(tokenAmount == 100);
        require(paymentRecord[_member][tokenAmount] = false);
        transferFrom(_member,_owner,tokenAmount);
        paymentRecord[_member][tokenAmount] = true;
    }
    
    function payMembers(address payable _member,address _owner ,uint256 _committeeAmount) public payable onlyOwner returns(bool){
        require( paymentRecord[_member][tokenAmount] == true);
        require(interval >= 30 days);
        transferFrom(_owner,_member,_committeeAmount);
        for(int i = 0; i<=10 ; i++){
        paymentRecord[_member][_committeeAmount] = false;
        intervalCount++;
        if(intervalCount == 10){
             for(int i = 0; i<=10 ; i++){
                 transferFrom(msg.sender,_member,advanceFee);
             }
        }
        return sucess;
    }
} 
}