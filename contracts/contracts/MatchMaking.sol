// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Matchmaking {
    mapping(address => uint8[]) private _usersResponse;

    function setUserResponse(uint8[] memory response) external {
        _usersResponse[msg.sender] = response;
    }

    function compatibilityScore(address stranger) external view returns (uint8) {
      uint8[] memory senderResponse = _usersResponse[msg.sender];
      uint8[] memory partnerResponse = _usersResponse[stranger];
      uint8 score = 0;

      for (uint i = 0; i < senderResponse.length; i++) {
        if(senderResponse[i] == partnerResponse[i]){
          score += 5;
        }
      }

      return score;
    }
}

