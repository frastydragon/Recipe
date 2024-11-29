import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> messageBoards = [
    {'name': 'General Chat', 'icon': '📢'},
    {'name': 'Tech Talk', 'icon': '💻'},
    {'name': 'Random', 'icon': '🎲'},
  ];

  void _openChat(BuildContext context, String boardName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(boardName: boardName),
      ),
    );
  }

  void _openProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message Boards')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Message Boards'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () => _openProfile(context),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => _openSettings(context),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: messageBoards.length,
        itemBuilder: (context, index) {
          final board = messageBoards[index];
          return ListTile(
            leading: Text(board['icon']!, style: TextStyle(fontSize: 24)),
            title: Text(board['name']!),
            onTap: () => _openChat(context, board['name']!),
          );
        },
      ),
    );
  }
}
