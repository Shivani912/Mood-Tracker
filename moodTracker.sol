pragma solidity 0.5.8;

interface IMood {
    enum Mood {HAPPY, ENERGIZED, BORED, TIRED, SAD}
    
    function happy() external;
    function energized() external;
    function bored() external;
    function tired() external;
    function sad() external;
}

contract Owner {
    address owner;
    event ownerChanged(address oldOwner, address newOwner);
    constructor() public{
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    function changeOwner(address newOwner) onlyOwner public {
        owner = newOwner;
        emit ownerChanged(msg.sender,owner);
    }
}

contract ChangeMood is IMood, Owner{
    
    Mood mood;
    
    function happy() public onlyOwner {
        mood = Mood.HAPPY;
    }
    function energized() public onlyOwner{
        mood = Mood.ENERGIZED;
    }
    function bored() public onlyOwner{
        mood = Mood.BORED;
    }
    function tired() public onlyOwner{
        mood = Mood.TIRED;
    }
    function sad() public onlyOwner{
        mood = Mood.SAD;
    }
    function myMood() public view returns(Mood);
}

contract MoodTracker is ChangeMood {
    function myMood() public view onlyOwner returns (Mood) {
        return mood;
    }
}
