import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:agenix/agenix.dart';

import 'tools/menu_tool.dart';
import 'tools/order_tool.dart';
import 'tools/reservation_tool.dart';


const _firebaseOptions = FirebaseOptions(
  apiKey: 'YOUR_FIREBASE_WEB_API_KEY',
  appId: 'YOUR_APP_ID',
  messagingSenderId: 'YOUR_SENDER_ID',
  projectId: 'YOUR_PROJECT_ID',
  storageBucket: 'YOUR_BUCKET',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: _firebaseOptions);

  // Create a single orchestrator agent, as per Agenix docs
  final agent = await Agent.create(
    dataStore: DataStore.firestoreDataStore(),
    llm: LLM.geminiLLM(apiKey: 'GEMINI_API_KEY', modelName: 'gemini-1.5-flash'),
    name: 'Orchestrator',
    role:
        'You are the primary assistant. Understand the user, call tools, and reply concisely.',
  );

  agent.toolRegistry.registerTool(MenuTool());

  agent.toolRegistry.registerTool(OrderTool());

  agent.toolRegistry.registerTool(ReservationTool());

  runApp(RestaurantApp(agent: agent));
}

class RestaurantApp extends StatelessWidget {
  final Agent agent;
  const RestaurantApp({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Chatbot (Agenix + Gemini)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: ChatScreen(agent: agent),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final Agent agent;
  const ChatScreen({super.key, required this.agent});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final user = ChatUser(id: 'user', firstName: 'You');
  final bot = ChatUser(id: 'bot', firstName: 'Bot');
  final List<ChatMessage> _messages = [];
  int _convoCounter = 1;

  String get _convoId => _convoCounter.toString();

  Future<void> _send(String text) async {
    final msg = ChatMessage(user: user, createdAt: DateTime.now(), text: text);
    setState(() => _messages.insert(0, msg));

    final userMessage = AgentMessage(
      content: text,
      generatedAt: DateTime.now(),
      isFromAgent: false,
      imageData: null,
    );

    // Ask the agent to respond (Agenix will use system_data.json + tools)
    final res = await widget.agent.generateResponse(
      convoId: _convoId,
      userMessage: userMessage,
    );

    final reply = ChatMessage(
      user: bot,
      createdAt: DateTime.now(),
      text: res.content ?? "Sorry, I couldn’t process that.",
    );
    setState(() => _messages.insert(0, reply));
  }

  void _newConversation() {
    setState(() {
      _convoCounter++;
      _messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Chatbot'),
        actions: [
          IconButton(
            onPressed: _newConversation,
            tooltip: 'New conversation',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: DashChat(
        currentUser: user,
        onSend: (m) => _send(m.text),
        messages: _messages,
        inputOptions: const InputOptions(alwaysShowSend: true),
      ),
    );
  }
}
