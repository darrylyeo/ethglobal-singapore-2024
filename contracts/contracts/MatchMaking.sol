// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MatchMaking {
    mapping(address => int8[]) private _usersResponse;

    function setUserResponse(int8[] memory response) external {
        _usersResponse[msg.sender] = response;
    }

    function compatibilityScore(address stranger) external view returns (int8, int8, int8) {
      // if (msg.sender!=author) {
      //   revert("not allowed");
      // }
      int8[] memory senderResponse = _usersResponse[msg.sender];
      int8[] memory partnerResponse = _usersResponse[stranger];
      // For loop to compare the responses
      int8 score = 0;
      int8 denominatorA = 0;
      int8 denominatorB = 0;

      for (uint i = 0; i < senderResponse.length; i++) {
        score += senderResponse[i] * partnerResponse[i];
        denominatorA += senderResponse[i] * senderResponse[i];
        denominatorB += partnerResponse[i] * partnerResponse[i];
      }

      return (score, denominatorA, denominatorB);
    }
}
