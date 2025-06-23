# 📈 Stock Broker App (Frontend)

A Flutter-based frontend for simulating a stock trading platform. This app allows users to sign in as brokers, view their holdings, positions, order history, and place buy/sell orders on listed stocks.

---

## 🚀 Features

- 🔐 Broker-based login system
- 📊 View real-time portfolio with profit/loss (PnL) calculations
- 💼 Holdings and Positions tracking
- 📃 Order history and trade summaries
- 🛒 Seamless Buy/Sell interface with order pad
- 🎨 Clean UI with loading shimmers and responsive layout

---

## 🧩 Tech Stack

- Flutter (Frontend)
- Provider (State Management)
- Shared Preferences (Local Storage)
- Mock Database (In-memory user and stock data)
- Shimmer Effect (For loading UI)
- Custom UI Components

---

## 🧪 Test Credentials

You can use the following broker user details to log in:

### 🔹 User 1

- **Username**: `user1`  
- **Password**: `user1@123`

### 🔹 User 2


- **Username**: `user2`  
- **Password**: `user2@123`

*Note: You can extend or modify user data via `MockDatabase`.*

---

## 🔄 App Flow

1. **Broker Selection**
   - Choose your broker from a grid list.
   - Brokers include: Zerodha, Upstox, Groww, Angel One, HDFC.

2. **Login**
   - Enter username and password.
   - Credentials are matched against the mock database.

3. **Dashboard (Post Login)**
   - View holdings summary with invested amount, current value, and PnL.
   - Explore open positions and completed orders.
   - Tap any stock to open the **Order Pad**.

4. **Order Pad**
   - Choose Buy or Sell.
   - Enter quantity.
   - Simulates placing an order.

5. **Logout**
   - Clears session data via Shared Preferences.

---

## 📁 Project Structure
```
lib/
│
├── models/ # Data models (User, Order, Holding, Position)
├── services/ # StockDB and mock database service
├── screens/ # Login, Home, Holdings, Orders, etc.
├── widgets/ # Reusable UI components (cards, buttons, shimmer)
├── utils/ # Color constants and helper methods
└── main.dart # Entry point
```
---


## 🖼 Screenshots

<h3>📱 App Screens</h3>
<p float="left">
  <img src="https://github.com/user-attachments/assets/875ad387-8c5e-49f7-944d-9f0938974efb" width="200" />
  <img src="https://github.com/user-attachments/assets/519f5274-b860-4235-b103-7f53fc8a2f90" width="200" />
  <img src="https://github.com/user-attachments/assets/5ef1f243-2490-4f94-9f20-36acfef97bda" width="200" />
  <img src="https://github.com/user-attachments/assets/d12dd282-e24a-4ac6-a14f-c5e6c6cca1ae" width="200" />
  <img src="https://github.com/user-attachments/assets/d95e83da-6471-4f2c-ada0-790d3d522b5e" width="200" />
  <img src="https://github.com/user-attachments/assets/8e6cec13-b710-4f8c-932a-a81c03798697" width="200" />
  <img src="https://github.com/user-attachments/assets/fc29a19f-3392-4f36-929a-162264f3da78" width="200" />
  <img src="https://github.com/user-attachments/assets/85327263-1e49-41b2-954a-7034fe5ca2ea" width="200" />
</p>


📌 Notes
This app uses local mock data for demonstration purposes.

No backend or real-time trading logic is implemented.

We can expand it by integrating Firebase or a real-time backend in future.

📬 Contact

<h3 align="left">Connect with me:</h3>
<p align="left">
<a href="https://www.linkedin.com/in/madhur-nadamwar" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="madhur nadamwar" height="30" width="40" /></a>
</p>


<h3 align="center"> Made with ❤️ by Madhur Nadamwar </h3>
