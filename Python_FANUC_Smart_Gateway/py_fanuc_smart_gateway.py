import socket
import csv
import os
import time
from datetime import datetime

HOST = '127.0.0.1'
PORT = 12345
TIMEOUT_SECONDS = 5

CSV_FILE = "process_results.csv"

command_counter = 1
program_running = True

def build_client_request(command_id, action, product, tool, speed):
    if (action == "GET_STATUS") or (action == "GET_PROCESS_RESULT") or (action == "ROBOT_RECOVERY"):
        return f"CMD_ID={command_id};ACTION={action}"
    else:
        return f"CMD_ID={command_id};ACTION={action};PRODUCT={product};TOOL={tool};SPEED={speed}"

def parse_robot_response(message):
    message_fields = message.split(";")

    parsed_response = {}

    for field in message_fields:
        key_value = field.split("=")
        key = key_value[0].strip()
        value = key_value[1].strip()
        parsed_response[key] = value

    return parsed_response

def execute_robot_action(command_id, action, product, tool, speed):

    client_socket = None
    try:
        request = build_client_request(command_id, action, product, tool, speed)
        print("REQUEST:", request)

        client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        client_socket.settimeout(TIMEOUT_SECONDS)

        client_socket.connect((HOST, PORT))

        client_socket.sendall(request.encode("utf-8"))

        received = client_socket.recv(1024)

        if not received:
            print("EMPTY RESPONSE FROM FANUC SERVER")
            return None

        received = received.decode("utf-8")

        parsed_response = parse_robot_response(received)

        return parsed_response

    except ConnectionRefusedError:
        print("CONNECTION TO THE SERVER REFUSED")

    except TimeoutError:
        print("SERVER TIMEOUT")

    finally:
        if client_socket is not None:
            client_socket.close()
            print("SOCKET CLOSED")

valid_action_selection  = False
valid_product_selection = False
valid_tool_selection    = False
valid_speed_selection   = False

while program_running:
    valid_action_selection  = False
    valid_product_selection = False
    valid_tool_selection    = False
    valid_speed_selection   = False


    while not valid_action_selection:
        print("SELECT ACTION:")
        action_choice = input("1 = GET_STATUS\n2 = RUN_PROCESS\n3 = GET_PROCESS_RESULT\n4 = ROBOT_RECOVERY\nX = EXIT\n")

        if action_choice == "1":
            print("GET_STATUS SELECTED\n")
            action = "GET_STATUS"
            product = None
            tool = None
            speed = None
            valid_action_selection = True
        elif action_choice == "2":
            print("RUN_PROCESS SELECTED")
            action = "RUN_PROCESS"

            while not valid_product_selection:
                print("\nSELECT PRODUCT:")
                product_choice = input("1 = LEFT DOOR\n2 = RIGHT DOOR\n")

                if product_choice == "1":
                    product = "LEFT_DOOR"
                    print("LEFT DOOR SELECTED")
                    valid_product_selection = True
                elif product_choice == "2":
                    product = "RIGHT_DOOR"
                    print("RIGHT DOOR SELECTED")
                    valid_product_selection = True
                elif product_choice.upper() in ("X", "EXIT"):
                    print("CLOSING PROGRAM")
                    exit()
                else:
                    print("INVALID PRODUCT SELECTION")

            while not valid_tool_selection:
                print("\nSELECT TOOL:")
                tool_choice = input("1 = GLUEGUN GREEN\n2 = GLUEGUN BLUE\n")

                if tool_choice  == "1":
                    print("GLUEGUN GREEN SELECTED")
                    tool = "TOOL_1"
                    valid_tool_selection = True
                elif tool_choice == "2":
                    print("GLUEGUN BLUE SELECTED")
                    tool = "TOOL_2"
                    valid_tool_selection = True
                elif tool_choice.upper() in ("X", "EXIT"):
                    print("CLOSING PROGRAM")
                    exit()
                else:
                    print("INVALID TOOL SELECTION")

            while not valid_speed_selection:
                print("\nTYPE SPEED [mm/s]:")
                speed_choice = input()
                if speed_choice.upper() in ("X", "EXIT"):
                    print("CLOSING PROGRAM")
                    exit()
                try:
                    speed = int(speed_choice)
                except ValueError:
                    print("\nSPEED MUST BE AN INTEGER")
                    continue

                if 0 < speed <= 2000:
                    valid_speed_selection = True
                else:
                    print("SPEED MUST BE IN RANGE BETWEEN 0 AND 2000")

            valid_action_selection = True

            print(f"\nPROCESS PARAMETERS:\nPRODUCT={product}\nTOOL={tool}\nSPEED={speed}")             

        elif action_choice == "3":
            print("\nGET_PROCESS_RESULT SELECTED")
            action = "GET_PROCESS_RESULT"
            product = None
            tool = None
            speed = None
            valid_action_selection = True

        elif action_choice == "4":
            print("ROBOT_RECOVERY SELECTED\n")
            action = "ROBOT_RECOVERY"
            product = None
            tool = None
            speed = None
            valid_action_selection = True

        elif action_choice.upper() in ("X", "EXIT"):
            print("CLOSING PROGRAM")
            program_running = False
            valid_action_selection = True
        else:
            print("INVALID ACTION SELECTION")

    if not program_running:
        break

    command_id = (f"CMD_{command_counter:04d}")

    robot_response = execute_robot_action(command_id, action, product, tool, speed)

    if robot_response is not None:

        if robot_response["ACTION"] == "GET_PROCESS_RESULT":
            current_date_time = datetime.now()
            date_stamp = current_date_time.strftime("%Y-%m-%d")
            time_stamp = current_date_time.strftime("%H:%M:%S")
            robot_response.update({"DATE" : date_stamp, "HOUR" : time_stamp})

            file_exists = os.path.exists(CSV_FILE)

            with open(CSV_FILE, "a", newline="", encoding="utf-8") as csv_file:
                fieldnames = robot_response.keys()
                writer = csv.DictWriter(csv_file, fieldnames=fieldnames)

                if not file_exists:
                    writer.writeheader()

                writer.writerow(robot_response)

    command_counter += 1

    time.sleep(1)

    print("FANUC SERVER RESPONSE:", robot_response)








