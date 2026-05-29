# 🍽️ Agentic Restaurant Chatbot  

An **AI-powered restaurant assistant** built with **Agenix** and **Google Gemini**, showcasing an **agentic approach** to tool use and orchestration.  

This is a demo project designed to highlight **LLM orchestration + agent tooling** skills for restaurant-related tasks such as:  
- 📜 Viewing the menu  
- 🛒 Placing food orders  
- 📅 Making table reservations  

---

## ✨ Features  
- 🤖 **Agentic design**: Each tool handles a specialized task (Menu, Orders, Reservations).  
- 🧩 **Modular tools**: Tools are registered directly in the agent, enabling flexible orchestration.  
- 💬 **Conversational UI**: Chat with the bot just like you would with a waiter.  
- 🔗 **Gemini LLM**: Powered by Google Gemini for natural, context-aware responses.  
- 🔥 **Showcase-ready**: Built to demonstrate **agent-based reasoning + tool use** in Flutter/Dart.  

---

## 🏗️ Project Structure  

```
lib/
├── main.dart           # App entry point
└──tools/
   ├── menu_tool.dart
   ├── order_tool.dart
   └── reservation_tool.dart

```

- `agents/` → Tool definitions + agent setup  
- `ui/` → Chat interface components  

---

## 🚀 Getting Started  

### 1️⃣ Clone the repo  
```bash
git clone https://github.com/ak2106-47/Restaurant-Agent-Chatbot.git
cd Restaurant-Agent-Chatbot
```

### 2️⃣ Install dependencies  
```bash
flutter pub get
```

### 3️⃣ Add your Gemini API key  
Create a `.env` file in the root:  
```
GEMINI_API_KEY=your_api_key_here
```

### 4️⃣ Run the app  
```bash
flutter run
```

---

## 🧑‍🍳 Example Usage  

User: *"Show me the menu"*  
Agent: *"Here’s today’s menu: 🍕 Pizza, 🍔 Burger, 🥗 Salad"*  

User: *"I’d like to order 2 pizzas"*  
Agent: *"Got it! ✅ Your order for 2 pizzas has been placed."*  

User: *"Book a table for 4 at 8pm"*  
Agent: *"Done! 📅 Table for 4 reserved at 8:00 PM."*  

---

## 📚 Tech Stack  
- **Flutter** (cross-platform UI)  
- **Agenix** (agentic orchestration framework)  
- **Google Gemini API** (LLM backend)  

---

## 🛠️ Skills Demonstrated  
- LLM Orchestration (Agent + Tools)  
- Prompt Engineering  
- Tool Design (`MenuTool`, `OrderTool`, `ReservationTool`)  
- Agent Reasoning & Context Management  
- Flutter UI Integration with LLM  

---

## 📌 Roadmap(Future Plans)
- [ ] Add payment flow simulation  
- [ ] Add Firestore persistence for orders  
- [ ] Multi-agent collaboration (e.g., PaymentAgent, FeedbackAgent)  
- [ ] Rich UI (images for menu items, order status tracker)  

---

## 📜 License  
MIT License © 2026 Apoorva Kumar

---

## 🙌 Acknowledgements  
- Agenix for agent framework  
- Google Gemini for LLM  
