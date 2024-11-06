# Restaurant Chatbot

Rasa-based chatbot designed to streamline customer service for a restaurant.

## Features

- **Order Management**: Users can place and change orders, and the bot maintains a list of ordered items.
- **Menu Information**: The bot can display the restaurant’s menu and pricing based on JSON file.
- **Opening Hours**: Users can ask about the restaurant’s opening hours based on JSON file.
- **Order Types**: Supports both pickup and delivery, with time estimates based on item preparation.
- **Fallback Handling**: Provides a friendly message when user input is unclear.

## Project structure

- [actions.py](actions/actions.py) - Contains custom actions for handling user intents, such as validating ordered items, calculating total prices, determining order preparation times, and accessing source files for menu items and opening hours.
- [nlu.yml](data/nlu.yml) - Defines the natural language understanding (NLU) training data. This file includes examples of user inputs for different intents, allowing the bot to recognize user goals accurately.
- [rules.yml](data/rules.yml) - Contains rules that determine how the bot should respond to specific intents or actions, such as fallback behaviors and order confirmation workflows.
- [stories.yml](data/stories.yml) - Provides conversation examples, that train the bot on user-bot interactions.
- [domain.yml](domain.yml) - Defines the bot's domain, including intents, entities, slots, responses, and actions. This file serves as the central configuration for the bot's behavior and structure.
- [config.yml](config.yml) - Contains model configuration settings for Rasa, such as pipeline settings for language processing and policies for conversation management.
- [endpoints.yml](endpoints.yml) - Configures external endpoints: action servers. Enabling the bot to handle custom actions and store conversations.

_Note: The `credentials.yml` file, which contains secrets and access tokens for Facebook integration, is excluded from the repository for obvious safety reasons._

## How to run
1. Install [requirements](requirements.txt)
```bash
pip install -r requirements.txt
```
2. Train bot
```bash
rasa train
```
3. Run actions server and run bot locally
```bash
rasa run actions
rasa shell
```


## Example
<div align="center">
  <img src="https://github.com/user-attachments/assets/7ae64433-d093-48c4-b7e4-474e2029e421" width="687" alt="Screenshot 1">
  <p><i>Screenshot 1: menu check and pickup order</i></p>

  <img src="https://github.com/user-attachments/assets/ca0ae4d6-7df2-405e-b224-125aee36cf82" width="687" alt="Screenshot 2">
  <p><i>Screenshot 2: simple delivery order</i></p>

  <img src="https://github.com/user-attachments/assets/65d86cff-084d-4d2b-a7a8-2048ec6a4ba0" width="687" alt="Screenshot 3">
  <p><i>Screenshot 3: item not available, order canceled and change</i></p>

  <img src="https://github.com/user-attachments/assets/23c8daeb-54aa-4b16-81cf-629200f35913" width="687" alt="Screenshot 4">
  <p><i>Screenshot 4: question about open hours</i></p>
</div>
