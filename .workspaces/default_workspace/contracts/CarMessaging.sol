// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./CarRole.sol";
import "./CentralRole.sol";

contract CarMessaging is CarRole,CentralRole{
    struct Car{
        
        string plate;
        int posY;
        int posX;
    }   
    event PositionUpdated(address indexed account);
   
    address[] listOfAddresses;
    string public message;

    mapping (address => Car) private cars;
 
    function hi() public onlyCentral{
        message = "Hi i am central";
    }
    
  address[] closeCars;

    function registerCar(address requestSender) public onlyCentral{
        addCar(requestSender);
        bool contains=false;
        for (uint i =0 ;i< listOfAddresses.length;i++){
              if (requestSender == listOfAddresses[i]) {
               contains = true;   
                break;             
            }          
        }
        if(!contains){
            listOfAddresses.push(requestSender);
        }
    }

    function getCloseCars() public onlyCars returns(address[] memory){
        closeCars=new address[](listOfAddresses.length);
        int senderX=cars[msg.sender].posX;
        int senderY=cars[msg.sender].posY;
        for (uint i =0 ;i< listOfAddresses.length;i++){
                int proximity= ((cars[listOfAddresses[i]].posY-senderY)**2+(cars[listOfAddresses[i]].posX-senderX)**2);
           if(msg.sender!=listOfAddresses[i] && proximity<10**2){ 
                  
              
                  closeCars[i]=listOfAddresses[i]; 

                }
        }
        return closeCars;

    }

    function updatePosition(int x,int y) public onlyCars {
       
        cars[msg.sender].posX=x;
        cars[msg.sender].posY=y;
        emit PositionUpdated(msg.sender);
    }


 
    
}