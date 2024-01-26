pragma solidity >=0.7.0 <0.9.0;

contract Inventory {
    uint quantity;
    constructor(uint _quantity) {
        quantity = _quantity;
    }

    function get_quantity() public view returns(uint) {
        return quantity;
    }

    function set_quantity(uint qty) public {
        quantity = qty;
    }

}