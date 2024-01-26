pragma solidity >=0.7.0 <0.9.0;
import "./actor.sol";
contract ActorDb {
    Actor[] public actor_list;

    function add_actor(Actor actor) public {
        actor_list.push(actor);
    }
    function search_actor(address addr) public view returns(int) {
        for(uint i=0;i<actor_list.length;i++){
            if(actor_list[i].get_address() == addr)
                return int(i);
        }
        return -1;
    }
    function get_actor(address addr) public view returns(Actor){
        
        int pos = search_actor(addr);
        require(pos != -1);
        return actor_list[uint(pos)];
    }
    function get_count() public view returns(uint) {
        return actor_list.length;
    }
    function display_all_actors() public {
        for(uint i=0;i<actor_list.length;i++){
            Actor current_actor = actor_list[i];
            current_actor.show_actor_details();
        }
    }
}