import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userData;

  Future<void> _fetchUserData() async {
    final user = _auth.currentUser;
    final snapshot = await _firestore.collection('users').doc(user!.uid).get();
    setState(() {
      userData = snapshot.data();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Name: ${userData!['firstName']} ${userData!['lastName']}'),
            Text('Email: ${userData!['email']}'),
            Text('Role: ${userData!['role']}'),
          ],
        ),
      ),
    );
  }
}
