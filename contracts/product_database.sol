pragma solidity >=0.7.0 <0.9.0;
import "./product.sol";
contract ProductDb {
    Product[] product_list;
    function add_product(Product product) public{
        product_list.push(product);
    }
}