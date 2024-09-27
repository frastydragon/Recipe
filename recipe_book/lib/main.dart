import 'package:flutter/material.dart';

class Recipes {
  final String title;
  final List<String> ingredients;
  final List<String> instructions;

  const Recipes(this.title, this.ingredients, this.instructions);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(   
      ),
      home:const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String name1 = "Chicken Teryyaki";
List<String> item1 = ["one","two"];
List<String> instruction1 = ["one","two"];

String name2 = "Chicken Teryyaki";
List<String> item2 = ["one","two"];
List<String> instruction2 = ["one","two"];

String name3 = "Chicken Teryyaki";
List<String> item3 = ["one","two"];
List<String> instruction3 = ["one","two"];

String name4 = "Chicken Teryyaki";
List<String> item4 = ["one","two"];
List<String> instruction4 = ["one","two"];

String name5 = "Chicken Teryyaki";
List<String> item5 = ["one","two"];
List<String> instruction5 = ["one","two"];

String name6 = "Chicken Teryyaki";
List<String> item6 = ["one","two"];
List<String> instruction6 = ["one","two"];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text(textAlign: TextAlign.center, 'Recipe Book'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen(recipe: Recipes(name1, item1, instruction1),)),
                    );
                  },
                  child: Text(name1),
                ),

                ElevatedButton(
                  child: Text(name2),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailScreen(recipe: Recipes(name2, item2, instruction2),)),
                    );
                  },
                ) ,
              ]
            ),
            const SizedBox(height: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen(recipe: Recipes(name3, item3, instruction3),)),
                    );
                  },
                  child:  Text(name3),
                ),
                ElevatedButton(
                  child: Text(name4),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailScreen(recipe: Recipes(name4, item4, instruction4),)),
                    );
                  },
                ) ,
              ]
            ),
            const SizedBox(height: 1.0),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen(recipe: Recipes(name5, item5, instruction5),)),);
                  },
                  child:  Text(name5),
                ),
                ElevatedButton(
                  child: Text(name6),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailScreen(recipe: Recipes(name6, item6, instruction6),)),);
                  },
                ) ,
              ]
            ),
            const SizedBox(height: 10.0),
          ],
        ), 
                    
      )            
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.recipe});
  final Recipes recipe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                  recipe.ingredients.join(" \n"),
                  style: const TextStyle(fontSize: 15.0),
                  )       ,
                const SizedBox(height: 16.0),

            Text(
                recipe.instructions.join(" \n"),
                  style: const TextStyle(fontSize: 15.0),
                  )       ,
                const SizedBox(height: 16.0),


            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Return'),
            )
          ]
        ),
      ),
    );
  }
}