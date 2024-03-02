import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_managment_app/business_logic/connection_status_manager.dart';
import 'package:medical_managment_app/business_logic/supplies_business_logic.dart';
import 'package:medical_managment_app/business_logic/web_socket_manager.dart';
import 'package:medical_managment_app/screens/add_supply_page.dart';
import 'package:medical_managment_app/screens/supply_details_screen.dart';
import 'package:medical_managment_app/widgets/supply_list_main_widget.dart';
import 'package:medical_managment_app/widgets/supply_list_widget.dart';
import '../data_access/models/supply.dart';

class MedicalOragnizerPage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final SupplyBusinessLogic supplyBusinessLogic;

  const MedicalOragnizerPage(this.scaffoldMessengerKey, this.supplyBusinessLogic,
      {super.key});

  factory MedicalOragnizerPage.create(GlobalKey<ScaffoldMessengerState> key,
      SupplyBusinessLogic supplyBusinessLogic) {
    return MedicalOragnizerPage(key, supplyBusinessLogic);
  }

  @override
  _MedicalOragnizerPageState createState() => _MedicalOragnizerPageState();
}

class _MedicalOragnizerPageState extends State<MedicalOragnizerPage> {
  ConnectionStatusManager connectionStatus =
  ConnectionStatusManager.getInstance();
  StreamSubscription? _connectionChangeStream;
  WebSocketManager? _webSocketManager;

  bool _loading = true;
  List<Supply> detailsBySupply=[];

  @override
  void initState() {
    super.initState();

    _connectionChangeStream =
        connectionStatus.connectionChange.listen(_connectionChanged);
    connectionStatus.hasNetwork();
  }

  @override
  void dispose() {
    _webSocketManager?.disconnect();
    ConnectionStatusManager.getInstance().dispose();
    widget.supplyBusinessLogic.updateSupplies();
    super.dispose();
  }

  void openSnackbar(String message, int durationInSeconds) {
    widget.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }

  void _connectionChanged(dynamic hasNetwork) {
    if (!widget.supplyBusinessLogic.hasNetwork && hasNetwork) {
      openSnackbar(
          "You are connected to internet. Your application has been updated with the server.",
          2);
      _webSocketManager = WebSocketManager(onMessageReceived: (remoteSupply) {
        var supply = widget.supplyBusinessLogic.addRemoteSupply(remoteSupply);
        var message =
            "A new supply was added. Name: ${supply.name}, status: ${supply.status}, type: ${supply.type}";
        openSnackbar('Notification: $message', 2);
      });
      widget.supplyBusinessLogic.hasNetwork = true;
    } else if (!hasNetwork) {
      openSnackbar(
          "There is no connection to internet! Loaded from local database.", 2);
      _webSocketManager?.disconnect();
      _webSocketManager = null;
      widget.supplyBusinessLogic.hasNetwork = false;
      widget.supplyBusinessLogic.saveSupplies();
    }
    fetchData();
  }

  void addSupply(String name,String supplier, String details, String status,int quantity,
      String type) async {
    await widget.supplyBusinessLogic
        .addSupply(name, supplier, details, status, quantity,type)
        .then((_) {
      setState(() {});
      widget.supplyBusinessLogic.syncLocalDbWithServer();
    }).catchError((e) {
      print('Error adding supply: $e');
      openSnackbar("Error adding supply: $e", 2);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplies'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.person),
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/profile');
        //     },
        //   ),
        // ],
      ),
      body: _loading || widget.supplyBusinessLogic.supplies.isEmpty
          ? Center(
          child: Column(children: [
            const CircularProgressIndicator(),
            const Text("Waiting for internet connection"),
            ElevatedButton(
                onPressed: () => connectionStatus.hasNetwork(),
                child: const Text("Retry connection"))
          ]))
          : SupplyListMainWidget(supplies: widget.supplyBusinessLogic.supplies,onSupplySelected:(selectedSupply){
        fetchDetailsBySupply(selectedSupply);
        Navigator.push(context,MaterialPageRoute(builder: (context)=>SupplyDetailsScreen(selectedSupply:selectedSupply.name,details:detailsBySupply,supplyBusinessLogic: widget.supplyBusinessLogic),),);
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddSupplyPage(onSave: addSupply)),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drag_handle),
            label: 'Staff',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_exploration),
            label: 'Supplier',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          switch (index) {
            case 1:
              if (!widget.supplyBusinessLogic.hasNetwork) {
                openSnackbar(
                    "You cannot access this section while offline.", 1);
              } else {
                Future pushNamed = Navigator.pushNamed(context, '/staff');
                pushNamed.then((_) => setState(() {}));
              }
              break;
            case 2:
              if (!widget.supplyBusinessLogic.hasNetwork) {
                openSnackbar(
                    "You cannot access this section while offline.", 1);
              } else {
                Navigator.pushNamed(context, '/supplier');
              }
              break;

          }
        },
      ),
    );
  }
  void fetchDetailsBySupply(Supply selectedEvent) async {
    List<Supply> events = await widget.supplyBusinessLogic.getDetailsBySupply(selectedEvent.id.toString());
    setState(() {
      detailsBySupply = events;
    });
  }

  fetchData() async {
    await widget.supplyBusinessLogic.syncLocalDbWithServer();
    await widget.supplyBusinessLogic.getAllSupplies();
    setState(() {
      _loading = false;
    });
  }
}