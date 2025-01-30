// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract IncidentContract {
    struct Incident {
        uint id;
        uint No_Patient;
        uint Gender;
        uint AGE;
        uint[10] medicalData;  // Stocke les valeurs Urea, Cr, HbA1c, etc.
    }

    mapping(uint => Incident) private incidents;
    uint[] private incidentIds;
    address public owner;

    event IncidentRecorded(uint id, uint No_Patient, uint Gender, uint AGE);

    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Not contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function recordIncident(
        uint _id,
        uint _No_Patient,
        uint _Gender,
        uint _AGE,
        uint[10] memory _medicalData
    ) public onlyOwner {
        require(incidents[_id].id == 0, "Error: Incident ID already exists");

        incidents[_id] = Incident(_id, _No_Patient, _Gender, _AGE, _medicalData);
        incidentIds.push(_id);
        
        emit IncidentRecorded(_id, _No_Patient, _Gender, _AGE);
    }

    function getIncidentById(uint _id) public view returns (Incident memory) {
        require(incidents[_id].id != 0, "Error: Incident not found");
        return incidents[_id];
    }
}
