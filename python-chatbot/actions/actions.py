import json
from rasa_sdk import Action, Tracker
from rasa_sdk.events import SlotSet
from rasa_sdk.executor import CollectingDispatcher

MENU_JSON_PATH = "data/menu.json"
OPENING_HOURS_JSON_PATH = "data/opening_hours.json"


class SumUpOrder(Action):
  def name(self) -> str:
    return "sum_up_order"

  def run(self,
      dispatcher: CollectingDispatcher,
      tracker: Tracker,
      domain: dict) -> None:
    order = tracker.get_slot("order")
    menu_items = MenuItemDto.parse_json(MENU_JSON_PATH)
    message = "So you want to order:\n"
    order_sum = 0

    for item_name in order:
      item_price = self.get_price(item_name, menu_items)
      if item_price is not None:
        order_sum += item_price
        message += f"- {item_name.capitalize()} - {item_price}€\n"
      else:
        dispatcher.utter_message(text=f"{item_name.capitalize()} is not on our menu, sorry!")

    message += f"Your total is: {order_sum}€"
    dispatcher.utter_message(text=message)

  def get_price(self, item_name, menu_items):
    item = next((m for m in menu_items
                 if compare_without_case(m.name, item_name)),
                None)
    return item.price if item else None

class ActionResetOrder(Action):
  def name(self) -> str:
    return "action_reset_order"

  def run(self,
      dispatcher: CollectingDispatcher,
      tracker: Tracker,
      domain: dict) -> list:
    return [SlotSet("order", [])]


class RetrieveOpeningHours(Action):
  def name(self) -> str:
    return "retrieve_opening_hours"

  def run(self,
      dispatcher: CollectingDispatcher,
      tracker: Tracker,
      domain: dict) -> None:
    opening_hours = OpeningHoursDto.parse_json(OPENING_HOURS_JSON_PATH)
    message = "These are our work hours:\n"
    for item in opening_hours:
      message += f"- {item.day} we are "
      if item.open_hour == 0 and item.close_hour == 0:
        message += "closed\n"
      else:
        message += f"open from {item.open_hour}:00 to {item.close_hour}:00\n"
    dispatcher.utter_message(text=message)


class RetrieveMenu(Action):
  def name(self) -> str:
    return "retrieve_menu"

  def run(self,
      dispatcher: CollectingDispatcher,
      tracker: Tracker,
      domain: dict) -> None:
    menu_items = MenuItemDto.parse_json(MENU_JSON_PATH)
    message = "This is our menu:\n"
    for item in menu_items:
      message += f"- {item.name.capitalize()} - {item.price:.2f}€\n"
    dispatcher.utter_message(text=message)


class RegisterPickupOrder(Action):
  def name(self) -> str:
    return "register_pickup_order"

  def run(self,
      dispatcher: CollectingDispatcher,
      tracker: Tracker,
      domain: dict) -> None:
    menu_items = MenuItemDto.parse_json(MENU_JSON_PATH)
    order = tracker.get_slot("order")

    max_time = -1
    for item_name in order:
      item = next(
          (m for m in menu_items
           if compare_without_case(m.name, item_name)), None)
      if item:
        max_time = max(max_time, item.preparation_time)

    if max_time != -1:
      message = f"Order registered, please come to pick it up in {int(60 * max_time)} minutes"
      dispatcher.utter_message(text=message)


class RegisterDeliveryOrder(Action):
  def name(self) -> str:
    return "register_delivery_order"

  def run(self,
      dispatcher: CollectingDispatcher,
      tracker: Tracker,
      domain: dict) -> None:
    menu_items = MenuItemDto.parse_json(MENU_JSON_PATH)
    order = tracker.get_slot("order")
    address = tracker.get_slot("address")

    max_time = -1
    for item_name in order:
      item = next(
          (m for m in menu_items
           if compare_without_case(m.name, item_name)), None)
      if item:
        max_time = max(max_time, item.preparation_time)

    if max_time != -1:
      message = f"Order registered, will be delivered to {address} in {int(60 * max_time + 15)} minutes"
      dispatcher.utter_message(text=message)


class OpeningHoursDto:
  def __init__(self, day, open_hour, close_hour):
    self.day = day
    self.open_hour = open_hour
    self.close_hour = close_hour

  @staticmethod
  def parse_json(file_path):
    with open(file_path, "r") as file:
      data = json.load(file)
      return [OpeningHoursDto(
          day,
          hours["open"],
          hours["close"])
        for day, hours in data["items"].items()]


class MenuItemDto:
  def __init__(self, name, price, preparation_time):
    self.name = name
    self.price = price
    self.preparation_time = preparation_time

  @staticmethod
  def parse_json(file_path):
    with open(file_path, "r") as file:
      data = json.load(file)
      return [MenuItemDto(
          item["name"],
          item["price"],
          item["preparation_time"])
        for item in data["items"]]


def compare_without_case(left, right):
  return left.lower() == right.lower()
