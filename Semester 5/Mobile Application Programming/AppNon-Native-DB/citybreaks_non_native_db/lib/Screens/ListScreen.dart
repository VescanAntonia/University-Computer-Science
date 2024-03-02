import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:citybreaks_non_native_db/Screens/AddCityBreakScreen.dart';
import 'package:citybreaks_non_native_db/CityBreak.dart';
import 'package:citybreaks_non_native_db/Screens/UpdateCityBreakScreen.dart';
import 'package:citybreaks_non_native_db/Screens/CityBreakRepository.dart';
import 'package:intl/intl.dart';

import '../Repo/DatabaseRepo.dart';
import 'CityBreaksViewModel.dart'; // Import the ViewModel

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  CityBreaksViewModel viewModel=CityBreaksViewModel.viewModel;
  // DatabaseRepo databaseRepo = DatabaseRepo.dbInstance;
  // late Future<List<CityBreak>> cityBreaks;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   cityBreaks = databaseRepo.getCityBreaks();
  // }


  _showDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("CupertinoAlertDialog"),
        content: const Text("Are you sure you want to delete this item?"),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("Yes"),
            onPressed: () async {
              // await databaseRepo.removeFromList(id);
              await viewModel.deleteCityBreak(id);
              setState(() {
                Navigator.of(context).pop();
              });
            },
          ),
          CupertinoDialogAction(
            child: const Text("No"),
            onPressed: () {
            setState(() {
            Navigator.of(context).pop();
            });}
          ),
        ],
      ),
    );
  }

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
        backgroundColor: Color(0XFFFFECB3),
      ),
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background_photo.jpg"), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
            child: _buildListOfCityBreaks(),
      ),),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            CityBreak cityBreak = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddCityBreakScreen()));
                //await databaseRepo.add(cityBreak);
                await viewModel.addCityBreak(cityBreak);
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Added!"),
              ));
            });
          },
          backgroundColor: Colors.black45,
          child: const Icon(Icons.add)),
    );
  }

  //the future builder waits for the result to be completed and only
  //then it calls the build
  //if it's not ready it returns an empty container
  Widget _buildListOfCityBreaks(){
    return FutureBuilder<List<CityBreak>>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Container(); // Return a loading indicator or placeholder if data is not available yet
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(); // Return a message or placeholder if the data is empty
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return templateCityBreak(snapshot.data![index]);
          },
        );
      },
      // future: databaseRepo.getCityBreaks(),
      future: viewModel.getAllCityBreaks(),
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
                            // await databaseRepo.update(cityBreak2);
                            await viewModel.updateCityBreak(cityBreak2);
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Updated!"),
                              ));
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
