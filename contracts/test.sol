pragma solidity >=0.7.0 <0.9.0;

import "./actor_database.sol";
import "./actor.sol";
import "./order_database.sol";
import "./order.sol";
import "./product_database.sol";
import "./product_database.sol";
import "./inventory.sol";

contract SupplyChainManagement {
    ActorDb actor_db;
    OrderDb order_db;
    constructor() {
        actor_db = new ActorDb();
        order_db = new OrderDb();
    }
    receive() external payable { }

    event event_show_payment(address payable sender, address payable recipient, uint256 amount);
    event event_show_balance(uint balance);
    event reorder_point(uint rop);
    event economic_order_quantity(uint eoq);
    event order(uint,uint,address,address,bool);

    function register(string memory actor_type,
                     string memory actor_name,
                     string memory actor_region,
                     string memory actor_national_id,
                     uint _initial_quantity,
                     uint _annual_demand,
                     uint _days_open,
                     uint _delivery_days,
                     uint _cost_to_place_and_process,
                     uint _holding_cost) public { 
        Actor new_actor = new Actor(msg.sender,actor_type,actor_name,actor_region,actor_national_id,_initial_quantity,_annual_demand,_days_open,_delivery_days,_cost_to_place_and_process,_holding_cost);
        actor_db.add_actor(new_actor);
        new_actor.show_actor_details();
    }
    function dummy_register(
                     address dummy_address,
                     string memory actor_type,
                     string memory actor_name,
                     string memory actor_region,
                     string memory actor_national_id,
                     uint _initial_quantity,
                     uint _annual_demand,
                     uint _days_open,
                     uint _delivery_days,
                     uint _cost_to_place_and_process,
                     uint _holding_cost) public { 
        Actor new_actor = new Actor(dummy_address,actor_type,actor_name,actor_region,actor_national_id,_initial_quantity,_annual_demand,_days_open,_delivery_days,_cost_to_place_and_process,_holding_cost);
        actor_db.add_actor(new_actor);
        new_actor.show_actor_details();
    }
    function display_actors() public {
        actor_db.display_all_actors();
    }
    function calculate_reorder_point(uint annual_demand, uint days_open, uint delivery_days) public returns(uint) {
        uint daily_demand = annual_demand / days_open;
        uint rop = daily_demand * delivery_days;
        emit reorder_point(rop);
        return rop;
    }
    function calculate_economic_order_quantity(uint annual_demand, uint cost_to_place_and_process, uint holding_cost) public returns(uint) {
        uint x = (2 * annual_demand * cost_to_place_and_process / holding_cost);
        uint z = (x + 1) / 2;
        uint y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
        emit economic_order_quantity(y);
        return y;
    }
    function accept_order(uint _order_id,bool accepted) public {
        if(accepted){
            order_db.accept_order(_order_id);
        }
        display_all_orders();
    }
    function create_order(uint quantity,address orderer, address supplier) public {
        uint order_id = order_db.get_count();
        bool accepted = false;
        Order new_order = new Order(order_id,quantity,orderer,supplier,accepted);
        order_db.add_order(new_order);
        emit order(order_id,quantity,orderer,supplier,accepted);
    }
    function display_all_orders() public {
        order_db.display_all_orders();
    }
    function execute_order(uint order_id, address suppliers_supplier) public payable {
        Order curr_order = order_db.get_order(order_id);
        require (curr_order.is_accepted()); 
        uint quantity = curr_order.get_quantity();
        address payable orderer_addr = payable(curr_order.get_orderer());
        address payable supplier_addr = payable(curr_order.get_supplier());
        // get actors
        Actor orderer = actor_db.get_actor(orderer_addr);
        Actor supplier = actor_db.get_actor(supplier_addr);
        orderer.show_actor_details();
        supplier.show_actor_details();
        uint qty = orderer.get_inventory().get_quantity();
        orderer.set_inventory(qty + quantity);
        qty = supplier.get_inventory().get_quantity();
        supplier.set_inventory(qty - quantity);
        //payment
        
        transferEther(orderer_addr, supplier_addr, msg.value);
        uint supplier_rop = calculate_reorder_point(supplier.get_annual_demand(), supplier.get_days_open(), supplier.get_delivery_days());
        if(qty-quantity < supplier_rop) {
            uint supplier_eoq = calculate_economic_order_quantity(supplier.get_annual_demand(), supplier.get_cost_to_place_and_process_order(), supplier.get_holding_cost());
            create_order(supplier_eoq, supplier_addr , suppliers_supplier);
        }
        orderer.show_actor_details();
        supplier.show_actor_details();
    }
    function transferEther(address payable sender, address payable recipient, uint amount) internal {
        require(sender.balance >= amount);
        emit event_show_balance(address(this).balance);
        emit event_show_balance(sender.balance);
        emit event_show_balance(recipient.balance);
        (bool sent,) = recipient.call{value: amount}("");
        require(sent,"Transaction failed!!!");
        emit event_show_payment(sender, recipient, amount);
    }
    
}