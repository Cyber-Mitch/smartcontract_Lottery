//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract Lottery{

    address[] players; 
    address public Casino; 
    
    
    constructor(){
       
       Casino = msg.sender; 
    }
    
   
    receive () payable external{
       
        require(msg.value == 1 ether);
       
        players.push(msg.sender);
    }

    function join() external payable{
        require(msg.sender != Casino, "Casino Can't play");
        require(msg.value >= 1 ether);
        address player = msg.sender;
       players.push(player);
       


    }
    
 
    function getBalance() public view returns(uint){
        require(msg.sender == Casino);
        return address(this).balance ;
    }
    
   
    function random() internal view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }
    
    
   
    function WinnerWinnerChickenDinner() public{
       
        require(msg.sender == Casino);
        require (players.length >= 3);
        
        uint r = random();
        address winner;
    
        uint index = r % players.length;
    
        winner = players[index]; 
        uint contractBal = address(this).balance;
        
      
        payable(winner).transfer(contractBal);
        
       
    }
 
}

