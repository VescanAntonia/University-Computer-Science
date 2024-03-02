import 'dart:async';

import 'package:flutter/material.dart';
import 'package:library_managment_app/business_logic/connection_status_manager.dart';
import 'package:library_managment_app/business_logic/books_business_logic.dart';
import 'package:library_managment_app/business_logic/web_socket_manager.dart';
import 'package:library_managment_app/widgets/book_info_widget.dart';
//import 'package:library_managment_app/screens/add_book_page.dart';
import 'package:library_managment_app/widgets/book_list_widget.dart';

import '../data_access/models/book.dart';

class ClientPage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final BookBusinessLogic bookBusinessLogic;

  const ClientPage(this.scaffoldMessengerKey, this.bookBusinessLogic,
      {super.key});

  factory ClientPage.create(GlobalKey<ScaffoldMessengerState> key,
      BookBusinessLogic bookBusinessLogic) {
    return ClientPage(key, bookBusinessLogic);
  }

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  ConnectionStatusManager connectionStatus =
  ConnectionStatusManager.getInstance();
  StreamSubscription? _connectionChangeStream;
  // WebSocketManager? _webSocketManager;

  bool _loading = true;
  List<Book> reservedBooks=[];

  @override
  void initState() {
    super.initState();
    ConnectionStatusManager connectionStatus =
    ConnectionStatusManager.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(_connectionChanged);
    fetchData();
  }

  // @override
  // void dispose() {
  //   _webSocketManager?.disconnect();
  //   ConnectionStatusManager.getInstance().dispose();
  //   widget.bookBusinessLogic.updateMeals();
  //   super.dispose();
  // }

  void openSnackbar(String message, int durationInSeconds) {
    widget.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }

  void _connectionChanged(dynamic hasNetwork) {
    if (!widget.bookBusinessLogic.hasNetwork && hasNetwork) {
      openSnackbar(
          "You are connected to internet. Your application has been updated with the server.",
          2);
      // _webSocketManager = WebSocketManager(onMessageReceived: (remoteMeal) {
      //   var meal = widget.mealBusinessLogic.addRemoteMeal(remoteMeal);
      //   var message =
      //       "A new meal was added. Name: ${meal.name}, type: ${meal.type}, calories: ${meal.calories}";
      //   openSnackbar('Notification: $message', 2);
      // });
      widget.bookBusinessLogic.hasNetwork = true;
    } else if (!hasNetwork) {
      openSnackbar(
          "There is no connection to internet! Loaded from local database.", 2);
      // _webSocketManager?.disconnect();
      // _webSocketManager = null;
      widget.bookBusinessLogic.hasNetwork = false;
      widget.bookBusinessLogic.saveMeals();
    }
    fetchData();
  }

  // void addMeal(String name, String type, double calories, DateTime date,
  //     String notes) async {
  //   await widget.bookBusinessLogic
  //       .addMeal(name, type, calories, date, notes)
  //       .then((_) {
  //     setState(() {});
  //   }).catchError((e) {
  //     print('Error adding meal: $e');
  //     openSnackbar("Error adding meal: $e", 2);
  //   });
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        // actions: [
        //   // IconButton(
        //   //   icon: const Icon(Icons.person),
        //   //   onPressed: () {
        //   //     Navigator.pushNamed(context, '/profile');
        //   //   },
        //   // ),
        // ],
      ),
      body: _loading || widget.bookBusinessLogic.books.isEmpty
          ? Center(
          child: Column(children: [
            const CircularProgressIndicator(),
            const Text("Waiting for internet connection"),
            ElevatedButton(
                onPressed: () => connectionStatus.hasNetwork(),
                child: const Text("Retry connection"))
          ]))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 5.0),
              child: Text(
                "All books",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 280.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.bookBusinessLogic.books.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BookInfoWidget(book: widget.bookBusinessLogic.books[index]),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 5.0),
              child: Text(
                "Reserved books",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: reservedBooks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BookInfoWidget(
                      book: reservedBooks[index],
                    ),
                  );
                },
              ),
            ),
            const Divider(),

          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => AddMealPage(onSave: addMeal)),
      //     );
      //   },
      //   child: const Icon(Icons.add),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Client',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drag_handle),
            label: 'Employee',
          ),

        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          switch (index) {
            case 1:
              if (!widget.bookBusinessLogic.hasNetwork) {
                openSnackbar(
                    "You cannot access this section while offline.", 1);
              } else {
                Future pushNamed = Navigator.pushNamed(context, '/employee');
                pushNamed.then((_) => setState(() {}));
              }
              break;

          }
        },
      ),
    );
  }

  fetchData() async {
    await widget.bookBusinessLogic.syncLocalDbWithServer();
    await widget.bookBusinessLogic.getAllBooks();
    reservedBooks = await widget.bookBusinessLogic.getReservedBooks();
    setState(() {
      _loading = false;
    });
  }
}