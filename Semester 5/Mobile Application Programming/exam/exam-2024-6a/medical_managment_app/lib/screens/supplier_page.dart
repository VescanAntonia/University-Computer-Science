import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_managment_app/business_logic/connection_status_manager.dart';
import 'package:medical_managment_app/business_logic/supplies_business_logic.dart';
import 'package:medical_managment_app/data_access/models/supply.dart';
import 'package:medical_managment_app/widgets/supply_info_main_widget.dart';
//import 'package:medical_managment_app/widgets/event_top_widget.dart';
//import 'package:event_managment_app/widgets/month_duration_widget.dart';

class SupplierPage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final SupplyBusinessLogic supplyBusinessLogic;

  const SupplierPage(this.scaffoldMessengerKey, this.supplyBusinessLogic,
      {super.key});

  factory SupplierPage.create(GlobalKey<ScaffoldMessengerState> key,
      SupplyBusinessLogic supplyBusinessLogic) {
    return SupplierPage(key, supplyBusinessLogic);
  }

  @override
  _SupplierPageState createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  StreamSubscription? _connectionChangeStream;

  bool _loading = true;
  List<Supply> events = [];
  List<Supply> tasksInRange = [];

  @override
  void initState() {
    super.initState();
    ConnectionStatusManager connectionStatus = ConnectionStatusManager.getInstance();
    _connectionChangeStream = connectionStatus.connectionChange.listen(_connectionChanged);
    fetchData();
  }

  void _connectionChanged(dynamic hasNetwork) {
    if (mounted && !hasNetwork) {
      openSnackbar("This page is unavailable due to the absence of an internet connection", 1);
      Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supply Orders'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 5.0),
            child: Text(
              "Supply order placed",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SupplyInfoMainWidget(supply: events[index]),
                );
              },
            ),
          ),
        ],
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
        currentIndex: 2,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              if (!widget.supplyBusinessLogic.hasNetwork) {
                openSnackbar("This page is unavailable due to the absence of an internet connection", 1);
              } else {
                Navigator.popAndPushNamed(context, "/staff");
              }
              break;
            case 2:
              if (!widget.supplyBusinessLogic.hasNetwork) {
                openSnackbar("You cannot access this section while offline.", 1);
                Navigator.pop(context);
              }
              break;
          }
        },
      ),
    );
  }

  fetchData() async {
    events = await widget.supplyBusinessLogic.getOrderedSupplies();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
    });
  }
}
