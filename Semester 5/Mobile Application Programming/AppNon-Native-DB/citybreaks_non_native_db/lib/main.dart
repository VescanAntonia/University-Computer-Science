import 'package:flutter/material.dart';
import 'package:citybreaks_non_native_db/Screens/ListScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: MyMainScreen(),
  ));
}

class MyMainScreen extends StatefulWidget {
  const MyMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => MyMainScreenState();
}

class MyMainScreenState extends State<MyMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_photo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(0, 250, 0, 0),
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListScreen()),
                  )
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade200,
                ),
                child: const Text(
                  "Explore the world!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SomeFam',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
