import json
from web3.auto import w3
from web3 import Web3
import time

def make_connection():
    ganache_url = "http://127.0.0.1:7545"
    web3 = Web3(Web3.HTTPProvider(ganache_url))
    abi = json.loads('[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"eoq","type":"uint256"}],"name":"economic_order_quantity","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"balance","type":"uint256"}],"name":"event_show_balance","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address payable","name":"sender","type":"address"},{"indexed":false,"internalType":"address payable","name":"recipient","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"event_show_payment","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"","type":"uint256"},{"indexed":false,"internalType":"address","name":"","type":"address"},{"indexed":false,"internalType":"address","name":"","type":"address"},{"indexed":false,"internalType":"bool","name":"","type":"bool"}],"name":"order","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"rop","type":"uint256"}],"name":"reorder_point","type":"event"},{"inputs":[{"internalType":"uint256","name":"_order_id","type":"uint256"},{"internalType":"bool","name":"accepted","type":"bool"}],"name":"accept_order","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"annual_demand","type":"uint256"},{"internalType":"uint256","name":"cost_to_place_and_process","type":"uint256"},{"internalType":"uint256","name":"holding_cost","type":"uint256"}],"name":"calculate_economic_order_quantity","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"annual_demand","type":"uint256"},{"internalType":"uint256","name":"days_open","type":"uint256"},{"internalType":"uint256","name":"delivery_days","type":"uint256"}],"name":"calculate_reorder_point","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"quantity","type":"uint256"},{"internalType":"address","name":"orderer","type":"address"},{"internalType":"address","name":"supplier","type":"address"}],"name":"create_order","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"display_actors","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"display_all_orders","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"dummy_address","type":"address"},{"internalType":"string","name":"actor_type","type":"string"},{"internalType":"string","name":"actor_name","type":"string"},{"internalType":"string","name":"actor_region","type":"string"},{"internalType":"string","name":"actor_national_id","type":"string"},{"internalType":"uint256","name":"_initial_quantity","type":"uint256"},{"internalType":"uint256","name":"_annual_demand","type":"uint256"},{"internalType":"uint256","name":"_days_open","type":"uint256"},{"internalType":"uint256","name":"_delivery_days","type":"uint256"},{"internalType":"uint256","name":"_cost_to_place_and_process","type":"uint256"},{"internalType":"uint256","name":"_holding_cost","type":"uint256"}],"name":"dummy_register","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"order_id","type":"uint256"},{"internalType":"address","name":"suppliers_supplier","type":"address"}],"name":"execute_order","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"string","name":"actor_type","type":"string"},{"internalType":"string","name":"actor_name","type":"string"},{"internalType":"string","name":"actor_region","type":"string"},{"internalType":"string","name":"actor_national_id","type":"string"},{"internalType":"uint256","name":"_initial_quantity","type":"uint256"},{"internalType":"uint256","name":"_annual_demand","type":"uint256"},{"internalType":"uint256","name":"_days_open","type":"uint256"},{"internalType":"uint256","name":"_delivery_days","type":"uint256"},{"internalType":"uint256","name":"_cost_to_place_and_process","type":"uint256"},{"internalType":"uint256","name":"_holding_cost","type":"uint256"}],"name":"register","outputs":[],"stateMutability":"nonpayable","type":"function"},{"stateMutability":"payable","type":"receive"}]')
    address = web3.to_checksum_address('0x031d5fcE27015C47456146ec947187ac5Db80069')
    contract = web3.eth.contract(address = address , abi = abi)
    print()
    return contract

def current_milli_time():
    return round(time.time() * 1000)

def display_actors(name,x_axis,y_axis,no_of_times,contract,file):
    times = []
    print(f"***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    file.write(f"\n***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    for k in range(len(no_of_times)):
        start_time = current_milli_time()
        for i in range(no_of_times[k]):
            contract.functions.display_actors().call()
        end_time = current_milli_time()
        times.append((end_time-start_time)/1000)
        print(f"{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")
        file.write(f"\n{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")
    file.write(str(times))    
    print("-------------------------------------------------------------------------------------------------")
    file.write("\n-------------------------------------------------------------------------------------------------")

def display_all_orders(name,x_axis,y_axis,no_of_times,contract,file):
    print(f"***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    file.write(f"\n***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    for k in range(len(no_of_times)):
        start_time = current_milli_time()
        for i in range(no_of_times[k]):
            contract.functions.display_all_orders().call()
        end_time = current_milli_time()
        print(f"{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")
        file.write(f"\n{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")    
    print("-------------------------------------------------------------------------------------------------")
    file.write("\n-------------------------------------------------------------------------------------------------")

def register(name,x_axis,y_axis,no_of_times,contract,file):
    print(f"***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    file.write(f"\n***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    for k in range(len(no_of_times)):
        start_time = current_milli_time()
        for i in range(no_of_times[k]):
            transaction_hash = contract.functions.register("Customer","test_actor","Pune","123",0,10,300,5,75,25).call()
            print(transaction_hash)
        end_time = current_milli_time()
        
        print(f"{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")
        file.write(f"\n{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")    
    print("-------------------------------------------------------------------------------------------------")
    #file.write("\n-------------------------------------------------------------------------------------------------")

def create_order(name,x_axis,y_axis,no_of_times,contract,file):
    print(f"***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    file.write(f"\n***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    for k in range(len(no_of_times)):
        start_time = current_milli_time()
        for i in range(no_of_times[k]):
            contract.functions.create_order(100,"0x01204358B463175B9d7E7BF30355eF6b336E0F8C","0x1374b09511188C41f42e3c6d9C397065A811467f").call()
        end_time = current_milli_time()
        print(f"{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")
        file.write(f"\n{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")    
    print("-------------------------------------------------------------------------------------------------")
    file.write("\n-------------------------------------------------------------------------------------------------")
    
def accept_order(name,x_axis,y_axis,no_of_times,contract,file):
    print(f"***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    file.write(f"\n***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    for k in range(len(no_of_times)):
        start_time = current_milli_time()
        for i in range(no_of_times[k]):
            contract.functions.accept_order(0,True).call()
        end_time = current_milli_time()
        print(f"{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")
        file.write(f"\n{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")    
    print("-------------------------------------------------------------------------------------------------")
    file.write("\n-------------------------------------------------------------------------------------------------")

def calculate_reorder_point(name,x_axis,y_axis,no_of_times,contract,file):
    print(f"***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    file.write(f"\n***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    for k in range(len(no_of_times)):
        start_time = current_milli_time()
        for i in range(no_of_times[k]):
            contract.functions.calculate_reorder_point(1000,300,5).call()
        end_time = current_milli_time()
        print(f"{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")
        file.write(f"\n{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")    
    print("-------------------------------------------------------------------------------------------------")
    file.write("\n-------------------------------------------------------------------------------------------------")


def calculate_economic_order_quantity(name,x_axis,y_axis,no_of_times,contract,file):
    print(f"***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    file.write(f"\n***** Function Name : {name} *****\n X-axis : {x_axis} \n Y-axis : {y_axis} ")
    for k in range(len(no_of_times)):
        start_time = current_milli_time()
        for i in range(no_of_times[k]):
            contract.functions.calculate_economic_order_quantity(1000,75,25).call()
        end_time = current_milli_time()
        print(f"{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")
        file.write(f"\n{k+1}. Execution time for {name} for {no_of_times[k]} times is {end_time-start_time} ms")    
    print("-------------------------------------------------------------------------------------------------")
    file.write("\n-------------------------------------------------------------------------------------------------")

if __name__ == "__main__":
    file = open("output.txt","a")
    print("\n---------------------------------PROGRAM TO GET DATA FROM GANCHE---------------------------------")
    file.write("\n---------------------------------PROGRAM TO GET DATA FROM GANCHE---------------------------------")
    contract = make_connection()
    no_of_times = [100,200]
    register("register()","No. of Transactions","Time",no_of_times,contract,file)
    # create_order("create_order()","No. of Transactions","Time",no_of_times,contract,file)
    # accept_order("accept_order()","No. of Transactions","Time",no_of_times,contract,file)
    # calculate_reorder_point("calculate_reorder_point()","No. of Transactions","Time",no_of_times,contract,file)
    # calculate_economic_order_quantity("calculate_economic_order_quantity()","No. of Transactions","Time",no_of_times,contract,file)
    # display_actors("display_actors()","No. of Transactions","Time",no_of_times,contract,file)
    # display_all_orders("display_all_orders()","No. of Transactions","Time",no_of_times,contract,file)
    file.close()