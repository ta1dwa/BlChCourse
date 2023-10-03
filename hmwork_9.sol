// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.8.2;

library StringComparer{
    function compare(string memory str1, string memory str2) public pure returns (bool){
        return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
    }
}

contract Animal{

    string name;

    constructor (string memory _name){
        name = _name;
    }

    function eat(string calldata _food) virtual view public returns(string memory){
        return "Nom-nom";
    }

    function sleep() view public returns(string memory){
        return "Zzz";

    }

    function speak() virtual view public returns(string memory){
        return "Animal speaks ";
    }

}

abstract contract Herbivore is Animal{

    string canEat = "plant";

    function eat(string calldata _food) override virtual view public returns(string memory){
        require(StringComparer.compare(_food,canEat), "Herbivore cannot eat this");
        return "Nom-nom";
    }

}


abstract contract Carnivore is Animal{

    string canEat = "meat";

    function eat(string calldata _food) override virtual view public returns(string memory){
        require(StringComparer.compare(_food,canEat), "Carnivore cannot eat this");
        return "Nom-nom";
    }

}

abstract contract Omnivore is Animal{

    string[2] canEat = ["plant", "meat"];

    function eat(string calldata _food) override virtual view public returns(string memory){
        require(
            StringComparer.compare(_food, canEat[0]) || 
            StringComparer.compare(_food, canEat[1]), 
            "Omnivore cannot eat this"
        );
        return "Nom-nom";

    }

}

contract Horse is Herbivore{


    constructor(string memory _name) Animal(_name){

    }

    function getName() view public returns(string memory){
            return name;
        } 

    function speak() override view public returns(string memory){
        return "Igogo";
    }


}

contract Cow is Herbivore{

    constructor(string memory _name) Animal(_name){

    }

    function getName() view public returns(string memory){
            return name;
        } 

    function speak() override view public returns(string memory){
        return "Moo-moo";
    }

}

contract Wolf is Carnivore{


    constructor(string memory _name) Animal(_name){

    }

    function getName() view public returns(string memory){
            return name;
        } 

    function speak() override view public returns(string memory){
        return "Awoooo";
    }


}

contract Dog is Omnivore{

    constructor(string memory _name) Animal(_name){
    
    }

     function getName() view public returns(string memory){
            return name;
        } 

     function eat(string calldata _food) override view public returns(string memory) {
        require(!StringComparer.compare(_food, "chocolate"), "Dog cannot eat chocolate");
        return super.eat(_food);
     }

    function speak() override view public returns(string memory){
        return "Woof-woof";
    }

}

contract Pig is Omnivore{

    constructor(string memory _name) Animal(_name){

    }

    function getName() view public returns(string memory){
            return name;
        } 

    function eat(string calldata food) override view public returns(string memory){
        return "Pig eats";
    } 

    function speak() override view public returns(string memory){
        return "Grunting";
    }

}

