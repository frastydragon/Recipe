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
String name1 = "Chicken Teriyaki";
List<String> item1 = ["5 LB Chicken","1 carrot", '2 bell peppers', 
"1 cup soy sauce ",
"3 Tbsp brown sugar ",
"1 Tbsp water ",
"1 clove garlic, minced ",
"1 tsp grated fresh ginger ",
"2 Tbsp cooking oil, divided "];
List<String> instruction1 = ["Prepare the marinade first.","Stir together the soy sauce, brown sugar, water, garlic, ginger, and 1 Tbsp of the cooking oil in a bowl",
"Let the chicken marinate for 30 minutes to one day", "Cook the chicken" ,"Add vegetables", "Enjoy" ];

String name2 = "Spagetti and Meatballs";
List<String> item2 = ["1 Box of spagetti","3 cans of Tomato Sauce","4 Meatballs"];
List<String> instruction2 = ["Bring a pot of water to a boil","Add the Noodles","Cook however long you want","Drain water from noodles","Cook the meatballs","Add sauce to meatballs",'Add noodles to the meatballs and sauce once done cooking','Enjoy'];

String name3 = "Cheesy Hamburgars";
List<String> item3 = ["1 whole cow","5 Slices of bread"];
List<String> instruction3 = ["Grab your keys",'Get into the car','Look up closest Mcdonolds','Set cow free'];

String name4 = "Hotdogs and potatos";
List<String> item4 = ["1 Hotdog",'4.5 potatos','3 hotdog buns'];
List<String> instruction4 = ["Toss the buns on the stove","Put the potatos in the microwave on high for 3.5 hours",'Boil the hotdog in a pot off oil at 400 degrees F','When finished cooking remove buns from stove',
"Assemble the hotdog",'Hope the potatos are still potatos'];

String name5 = "One Halfsized Large Pizza";
List<String> item5 = ["1 premade oven pizza"];
List<String> instruction5 = ["Remove pizza from box",'Preheat oven to 365 degrees F','Put pizza in the oven when up to temp','Set timer to 30 mins or wait til cheese melts','Remove pizza from oven when cooked and turn oven off'
,'Slice pizza into 7 slices','Enjoy'];

String name6 = "Some pickes and a slice of bread";
List<String> item6 = ["4 Meduim sized pickles","2 Slices of bread","1 Pinch of Salt",'1 Ounce of butter', "4 chocolate sprinkes"];
List<String> instruction6 = ["Lay bread vertically","Install pickles counterclockwise","Put the butter in the middle","Sprinkle the salt and chocolate sprinkles", "Enjoy?"];



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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text (
              style: const TextStyle( fontSize:30, fontWeight: FontWeight.bold),
              
              recipe.title
            ),
            const SizedBox(height: 20.0),
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