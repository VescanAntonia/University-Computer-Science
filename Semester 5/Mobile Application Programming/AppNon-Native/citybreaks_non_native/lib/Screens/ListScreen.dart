import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:citybreaks_non_native/Screens/AddCityBreakScreen.dart';
import '../CityBreak.dart';
import 'UpdateCityBreakScreen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  final List<CityBreak> cityBreaks = CityBreak.init();

  CityBreak? getCityBreakById(int id) {
    for (CityBreak s in cityBreaks) {
      if (s.id == id) return s;
    }
  }

  void update(CityBreak newCityBreak){
    for(int i = 0; i < cityBreaks.length; i++){
      if(cityBreaks[i].id == newCityBreak.id) {
        cityBreaks[i] = newCityBreak;
      }
    }
  }

  void removeFromList(int id) {
    cityBreaks.removeWhere((element) => element.id == id);
  }

  _showDialog(BuildContext context, int id) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text("CupertinoAlertDialog"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("Yes"),
              onPressed: () {
                setState(() {
                  removeFromList(id);
                  Navigator.of(context).pop();
                });
              },
            ),
            CupertinoDialogAction(
              child: const Text("No"),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "City Breaks",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.7),
      ),
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background_photo.jpg"), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
            child: ListView.builder(
                itemCount: cityBreaks.length,
                itemBuilder: (context, index) {
                  return templateCityBreak(cityBreaks[index]);
                })),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            CityBreak cityBreak = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddCityBreakScreen()));
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Added!"),
              ));
              cityBreaks.add(cityBreak);
            });
          },
          backgroundColor: Colors.black45,
          child: const Icon(Icons.add)),
    );
  }

  Widget templateCityBreak(cityBreak) {
    return Card(
        elevation: 0,
        // margin: EdgeInsets.zero,
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        child: Container(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7), // Set the opacity value as needed
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text(
                      "${cityBreak.city}    ${cityBreak.country}      ${cityBreak.accommodation}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                      child: IconButton(
                          onPressed: () => {_showDialog(context, cityBreak.id)},
                          icon: const Icon(
                            CupertinoIcons.delete,
                            size: 18,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: IconButton(
                          onPressed: ()  async {
                            CityBreak cityBreak2 = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) => UpdateCityBreakScreen(cityBreak: cityBreak!)));
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Updated!"),
                              ));
                              update(cityBreak2);
                            });
                          },
                          icon: const Icon(
                            CupertinoIcons.pen,
                            size: 25,
                          )),
                    )
                  ])
                ],
              ),
            )));
  }
}