pragma solidity >=0.7.0 <0.9.0;

contract Order {
    uint order_id;
    uint quantity;
    address orderer;
    address supplier;
    bool accepted;

    event event_show_order_details(uint order_id,
    uint quantity,
    address orderer,
    address supplier,
    bool accepted
    );

    constructor(uint _order_id,
    uint _quantity,
    address _orderer,
    address _supplier,
    bool _accepted) {
        order_id = _order_id;
        quantity = _quantity;
        orderer = _orderer;
        supplier = _supplier;
        accepted = _accepted;
    }


    function get_order_id() public  view returns(uint) {
        return order_id;
    }

    function get_quantity() public  view returns(uint) {
        return quantity;
    }

    function get_orderer() public  view returns(address) {
        return orderer;
    }

    function get_supplier() public  view returns(address) {
        return supplier;
    }

    function is_accepted() public  view returns(bool) {
        return accepted;
    }
    function accept() public {
        accepted = true;
    }
    function show_order_details() public {
        emit event_show_order_details(order_id, quantity, orderer, supplier, accepted);
    }
}