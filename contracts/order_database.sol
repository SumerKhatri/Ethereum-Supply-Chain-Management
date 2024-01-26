pragma solidity >=0.7.0 <0.9.0;
import "./order.sol";
contract OrderDb {
    Order[] order_list;
    function add_order(Order order) public{
        order_list.push(order);
    }
    function get_count() public view returns(uint) {
        return order_list.length;
    }
    function display_all_orders() public { 
        for(uint i=0;i<order_list.length;i++){
            Order order = order_list[i];
            order.show_order_details();
        }
    }
    function get_order(uint _order_id) public view returns (Order) {
        int pos = search_order(_order_id);
        return order_list[uint(pos)];
    }
    function search_order(uint _order_id) public view returns(int){
        for(uint i=0;i<order_list.length;i++){
            if(_order_id == order_list[i].get_order_id()){
                return int(i);
            }
        }
        return -1;
    }
    function accept_order(uint _order_id) public {
        order_list[_order_id].accept();
    }
}