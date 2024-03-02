import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_managment_app/business_logic/connection_status_manager.dart';
import 'package:medical_managment_app/business_logic/supplies_business_logic.dart';
import 'package:medical_managment_app/data_access/models/supply.dart';
//import 'package:medical_managment_app/widgets/delete_confirmation_modal.dart';
import 'package:medical_managment_app/widgets/supply_info_widget.dart';
import 'package:medical_managment_app/widgets/type_quantity_widget.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class StaffPage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final SupplyBusinessLogic supplyBusinessLogic;

  const StaffPage(this.scaffoldMessengerKey, this.supplyBusinessLogic,
      {super.key});

  factory StaffPage.create(GlobalKey<ScaffoldMessengerState> key,
      SupplyBusinessLogic supplyBusinessLogic) {
    return StaffPage(key, supplyBusinessLogic);
  }

  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  StreamSubscription? _connectionChangeStream;

  bool _loading = true;
  List<String> types = [];
  List<List<int>> suppliesByType = [];
  List<int> quantitiesByType = [];

  @override
  void initState() {
    super.initState();
    ConnectionStatusManager connectionStatus =
    ConnectionStatusManager.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(_connectionChanged);
    fetchData();
  }

  void _connectionChanged(dynamic hasNetwork) {
    if (mounted && !hasNetwork) {
      openSnackbar(
          "This page is unavailable due to absence of internet connection", 1);
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
        title: const Text('Staff section'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: types.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  types[index],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 100.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, innerIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TypeQuantityWidget(
                        type: types[index],
                        quantity: quantitiesByType[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
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
        currentIndex: 1,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              if (!widget.supplyBusinessLogic.hasNetwork) {
                openSnackbar(
                    "This page is unavailable due to absence of internet connection",
                    1);
                Navigator.pop(context);
              }
              break;
            case 2:
              if (!widget.supplyBusinessLogic.hasNetwork) {
                openSnackbar(
                    "You cannot access this section while offline.", 1);
                Navigator.pop(context);
              } else {
                Navigator.popAndPushNamed(context, "/supplier");
              }
              break;
          }
        },
      ),
    );
  }

  fetchData() async {
    var map = await widget.supplyBusinessLogic.getSupplyByType();
    types = map.keys.toList();
    suppliesByType = map.values.toList();

    // Initialize quantitiesByType based on the suppliesByType data
    quantitiesByType = List<int>.filled(types.length, 0);

    // Iterate through suppliesByType to calculate quantitiesByType
    for (int i = 0; i < types.length; i++) {
      for (int quantity in suppliesByType[i]) {
        quantitiesByType[i] += quantity;
      }
    }

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
    });
  }


// fetchSuppliesForTypes() async {
  //   for (var type in types) {
  //     suppliesByType.add(await widget.supplyBusinessLogic.getSuppliesByType(type));
  //   }
  // }
}