pragma solidity >=0.7.0 <0.9.0;
import "./inventory.sol";
contract Actor{
    address actor_address;
    string actor_type;
    string actor_name;
    string actor_region;
    string actor_national_id;
    Inventory inventory;
    uint annual_demand;
    uint days_open;
    uint delivery_days;
    uint cost_to_place_and_process;
    uint holding_cost;
    
    event event_show_all_details(address actor_address,
    string actor_type,
    string actor_name,
    string actor_region,
    string actor_national_id,
    uint quantity,
    uint annual_demand,
    uint days_open,
    uint delivery_days,
    uint cost_to_place_and_process,
    uint holding_cost);

    constructor(address addr,
    string memory atype,
    string memory name,
    string memory region,
    string memory national_id,
    uint _quantity,
    uint _annual_demand,
    uint _days_open,
    uint _delivery_days,
    uint _cost_to_place_and_process,
    uint _holding_cost) {
        actor_address = addr;
        actor_type = atype;
        actor_name = name;
        actor_region = region;
        actor_national_id = national_id;
        inventory = new Inventory(_quantity);
        annual_demand = _annual_demand;
        days_open = _days_open;
        delivery_days = _delivery_days;
        cost_to_place_and_process = _cost_to_place_and_process;
        holding_cost = _holding_cost;
    }
    function get_address() public view returns(address) {
        return actor_address;
    }
    function get_type() public view returns(string memory) {
        return actor_type;    
    }
    function get_name() public view returns(string memory) {
        return actor_name;
    }
    function get_region() public view returns(string memory) {
        return actor_region;
    }
    function get_national_id() public view returns(string memory) {
        return actor_national_id;
    }
    function get_inventory() public view returns (Inventory) {
        return inventory;
    }
    function set_national_id(string memory id) public {
        actor_national_id = id;
    }
    function set_inventory(uint quantity) public {
        inventory.set_quantity(quantity);
    }
    function show_actor_details() public {
        emit event_show_all_details(actor_address, actor_type, actor_name, actor_region, actor_national_id, inventory.get_quantity(), annual_demand, days_open, delivery_days, cost_to_place_and_process, holding_cost);
    }
    function get_annual_demand() public view returns(uint) {
        return annual_demand;
    }
    function get_days_open() public view returns(uint) {
        return days_open;
    }
    function get_delivery_days() public view returns(uint) {
        return delivery_days;
    }
    function get_cost_to_place_and_process_order() public view returns(uint) {
        return cost_to_place_and_process;
    }
    function get_holding_cost() public view returns(uint) {
        return holding_cost;
    }
}