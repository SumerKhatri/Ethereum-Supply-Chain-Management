pragma solidity >=0.7.0 <0.9.0;


contract SupplyChainManagement {
    struct Actor {
        string actor_type;
        string actor_name;
        string actor_region;
        string actor_national_id;
    }
    struct Order {
        address orderer_id;
        address supplier_id;
        uint quantity;
        bool accepted;
    }
    mapping(address => Actor) address_to_actor;
    mapping(address => bool) is_registered;
    mapping(address => Order) address_to_order;

    event registration(address actor_address,string actor_type,string actor_name,string actor_region,string actor_national_id);
    event reorder_point(uint rop);
    event economic_order_quantity(uint eoq);

    modifier valid_user() {
        require(is_registered[msg.sender]);
        _;
    }
    modifier orderer() {
        Actor memory creator = address_to_actor[msg.sender];
        require(keccak256(abi.encodePacked(creator.actor_type)) == keccak256(abi.encodePacked("Distributor")) ||
        keccak256(abi.encodePacked(creator.actor_type)) == keccak256(abi.encodePacked("Retailer")) ||
        keccak256(abi.encodePacked(creator.actor_type)) == keccak256(abi.encodePacked("Customer"))
        );
        _;
    }
    function str_cmp(string memory str1, string memory str2) internal pure returns(bool) {
        if(keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2)))
            return true;
        return false;    
    }
    function register(string memory actor_type,string memory actor_name,string memory actor_region,string memory actor_national_id) public { 
        require(!is_registered[msg.sender]);
        address_to_actor[msg.sender] = Actor(actor_type,actor_name,actor_region,actor_national_id);
        is_registered[msg.sender] = true;
        emit registration(msg.sender, actor_type, actor_name, actor_region, actor_national_id);
    }
    function calculate_reorder_point(uint annual_demand, uint days_open, uint delivery_days) public valid_user returns(uint) {
        uint daily_demand = annual_demand / days_open;
        uint rop = daily_demand * delivery_days;
        emit reorder_point(rop);
        return rop;
    }
    function calculate_economic_order_quantity(uint annual_demand, uint cost_to_place_and_process, uint holding_cost) public valid_user returns(uint) {
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
}