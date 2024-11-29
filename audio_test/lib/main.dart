import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Audio Windows Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AudioPlayerScreen(),
    );
  }
}

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(); // Initialize the audio player
  }

  Future<void> _playSound() async {
    try {
      // Load the audio file from assets
      await _audioPlayer.setAsset('assets/sound.mp3'); // Ensure the path is correct
      _audioPlayer.play(); // Play the audio
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the player when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Just Audio Windows Example"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _playSound, // Trigger audio playback
          child: Text("Play Sound"),
        ),
      ),
    );
  }
}