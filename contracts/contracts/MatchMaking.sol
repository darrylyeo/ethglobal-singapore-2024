// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Matchmaking {
    mapping(address => uint8[]) private _usersResponse;

    // Array to store unique addresses
    address[] public uniqueAddresses;

    // Mapping to track whether an address has already been added
    mapping(address => bool) private addressExists;

    function setUserResponse(uint8[] memory response) external {
        // Check if the caller's address has already been added
        // In production, this check should not be removed.
        // require(!addressExists[msg.sender], "Address already stored");
        if (!addressExists[msg.sender]){
          // Add the caller's address to the array
          uniqueAddresses.push(msg.sender);   
          // Mark the caller's address as added in the mapping
          addressExists[msg.sender] = true;
        }
        _usersResponse[msg.sender] = response;
    }

    function compatibilityScore(address stranger) external view returns (uint8) {
      uint8[] memory senderResponse = _usersResponse[msg.sender];
      uint8[] memory partnerResponse = _usersResponse[stranger];
      uint8 score = 0;
      uint8 length = uint8(senderResponse.length);
      if (length > partnerResponse.length) {
        length = uint8(partnerResponse.length);
      }
      for (uint i = 0; i < length; i++) {
        if(senderResponse[i] == partnerResponse[i]){
          score += 5;
        }
      }

      return score;
    }

    // Function to retrieve all stored addresses
    function getUniqueAddresses() external view returns (address[] memory) {
        return uniqueAddresses;
    }
}

