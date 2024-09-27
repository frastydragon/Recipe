import 'package:flutter/material.dart';

void main() {
  //runApp(const HomeScreen());
  runApp(const MaterialApp(
  title: 'Navigation Basics',
  home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(textAlign: TextAlign.center, 'Recipe Book'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailScreen()),
                );
              },
              child:  const Text('Recipe'),
            ),

            ElevatedButton(
              child: const Text('Favorites'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoriteScreen()),
                );
              },
            ) ,
          ]
        ),             
      )            
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigate back to first route when tapped.
          },
          child: const Text('Return'),
        ),
      ),
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigate back to first route when tapped.
          },
          child: const Text('Return'),
        ),
      ),
    );
  }
}