pragma solidity >=0.7.0 <0.9.0;

contract Product {
    uint product_id;
    uint batch_id;
    uint quantity;
    function get_product_id() public view returns(uint) {
        return product_id;
    }
    function get_batch_id() public view returns(uint) {
        return batch_id;
    }
    function get_quantity() public view returns(uint) {
        return quantity;
    }
    function update_quantity(uint new_quantity) public {
        quantity = new_quantity;
    }
}