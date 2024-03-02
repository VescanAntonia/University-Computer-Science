import 'dart:async';

import 'package:flutter/material.dart';
import 'package:library_managment_app/business_logic/connection_status_manager.dart';
import 'package:library_managment_app/business_logic/books_business_logic.dart';
import 'package:library_managment_app/data_access/models/book.dart';
import 'package:library_managment_app/screens/add_book_page.dart';
import 'package:library_managment_app/widgets/book_info_widget.dart';
import 'package:library_managment_app/widgets/book_list_widget.dart';
import 'package:library_managment_app/widgets/book_sorted_widget.dart';

import '../business_logic/web_socket_manager.dart';
//import 'package:event_managment_app/widgets/month_duration_widget.dart';

class EmployeePage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final BookBusinessLogic bookBusinessLogic;

  const EmployeePage(this.scaffoldMessengerKey, this.bookBusinessLogic,
      {super.key});

  factory EmployeePage.create(GlobalKey<ScaffoldMessengerState> key,
      BookBusinessLogic bookBusinessLogic) {
    return EmployeePage(key, bookBusinessLogic);
  }

  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  ConnectionStatusManager connectionStatus =
  ConnectionStatusManager.getInstance();
  StreamSubscription? _connectionChangeStream;
  WebSocketManager? _webSocketManager;

  bool _loading = true;
  List<Book> books = [];
  List<Book> tasksInRange = [];

  @override
  void initState() {
    super.initState();
    ConnectionStatusManager connectionStatus =
    ConnectionStatusManager.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(_connectionChanged);
    connectionStatus.hasNetwork();
    _webSocketManager = WebSocketManager(onMessageReceived: (remoteMeal) {
      var book = widget.bookBusinessLogic.addRemoteBook(remoteMeal);
      var message =
          "A new event was added. Title: ${book.title}, author: ${book.author}, genre: ${book.genre}";
      openSnackbar('Notification: $message', 2);
    });
    fetchData();
  }
  @override
  void dispose() {
    _webSocketManager?.disconnect();
    ConnectionStatusManager.getInstance().dispose();
    widget.bookBusinessLogic.updateMeals();
    super.dispose();
  }

  void _connectionChanged(dynamic hasNetwork) {
    if (!widget.bookBusinessLogic.hasNetwork && hasNetwork) {
      // openSnackbar(
      //     "You are connected to internet. Your application has been updated with the server.",
      //     2);
      _webSocketManager = WebSocketManager(onMessageReceived: (remoteMeal) {
        var book = widget.bookBusinessLogic.addRemoteBook(remoteMeal);
        var message =
            "A new event was added. Title: ${book.title}, author: ${book.author}, genre: ${book.genre}";
        openSnackbar('Notification: $message', 2);
      });
      widget.bookBusinessLogic.hasNetwork = true;
    } else if (!hasNetwork) {
      openSnackbar("This page is unavailable due to the absence of an internet connection", 1);

      _webSocketManager?.disconnect();
      _webSocketManager = null;
      widget.bookBusinessLogic.hasNetwork = false;
      widget.bookBusinessLogic.saveMeals();
    }
    if (widget.bookBusinessLogic.hasNetwork) {
      fetchData();
    }


  }
  void openSnackbar(String message, int durationInSeconds) {
    widget.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }

  void addBook(String title, String author, String genre, int quantity,
      int reserved) async {
    await widget.bookBusinessLogic
        .addBook(title, author, genre, quantity, reserved)
        .then((_) {
      setState(() {});
    }).catchError((e) {
      print('Error adding book: $e');
      openSnackbar("Error adding book: $e", 2);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee page'),
      ),
      body: _loading || widget.bookBusinessLogic.books.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 5.0),
            child: Text(
              "Sorted books",overflow: TextOverflow.ellipsis,

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BookSortedWidget(book: books[index]),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddBookPage(onSave: addBook)),
          );
        },
        child: const Icon(Icons.add),
      ),
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
        currentIndex: 1,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              if (!widget.bookBusinessLogic.hasNetwork) {
                openSnackbar(
                  "This page is unavailable due to the absence of an internet connection",
                  1,
                );
                Navigator.pop(context);}
              break;
          }
        },
      ),
    );
  }


  fetchData() async {
    await widget.bookBusinessLogic.syncLocalDbWithServer();
    await widget.bookBusinessLogic.getAllBooks();
    books = await widget.bookBusinessLogic.getSortedBooks();
    //await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
    });
  }
}
