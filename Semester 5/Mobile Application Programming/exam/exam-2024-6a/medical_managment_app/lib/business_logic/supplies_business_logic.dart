import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:medical_managment_app/common/constants.dart';
import 'package:medical_managment_app/common/exceptions/application_exception.dart';
import 'package:medical_managment_app/data_access/dao/supply_dao.dart';
import 'package:medical_managment_app/data_access/models/supply.dart';

class SupplyBusinessLogic {
  final SupplyDao _supplyDao;

  //List<String> tasksDays=[];
  List<Supply> supplies =[];
  List<String> types = [];
  bool hasNetwork = false;

  SupplyBusinessLogic(this._supplyDao);
  // Future<void> init() async {
  //   tasks = await getAllTasks();
  // }

  //



  Future<List<Supply>> getAllSupplies() async {
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/medicalsupplies");
        var rawList = serverResponse.data as List;
        supplies = rawList.map((e) => Supply.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the supplies!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the supplies.");
        }
      }
    } else {
      print("Retrieve from local database");
      supplies = await _supplyDao.getAllSupplies();
    }
    return supplies;
  }

  Future<List<Supply>> getOrderedSupplies() async {
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/supplyorders");
        var rawList = serverResponse.data as List;
        supplies = rawList.map((e) => Supply.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the supplies!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the supplies.");
        }
      }
    } else {
      print("Retrieve from local database");
      supplies = await _supplyDao.getAllSupplies();
    }
    return supplies;
  }
  Future<Map<String, List<int>>> getSupplyByType() async {
    Map<String, List<int>> suppliesByTypeMap = {};

    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse =
        await Dio().get("${AppConstants.apiUrl}/suppliestypes");
        var rawList = serverResponse.data as List;

        rawList.forEach((e) {
          Supply supply = Supply.fromJson(e);
          String supplyType = supply.type;

          if (!suppliesByTypeMap.containsKey(supplyType)) {
            suppliesByTypeMap[supplyType] = [];
          }

          suppliesByTypeMap[supplyType]?.add(supply.quantity);
        });
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the supplies!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the supplies.");
        }
      }
    }

    // Now suppliesByTypeMap contains a mapping of types to lists of supplies
    print("Map of types to supplies: $suppliesByTypeMap");

    // Calculate the sum of quantities for each type
    Map<String, int> sumOfQuantitiesMap = calculateSumOfQuantities(suppliesByTypeMap);

    print("Sum of quantities for each type: $sumOfQuantitiesMap");

    return suppliesByTypeMap;
  }

// Method to calculate the sum of quantities for each type
  Map<String, int> calculateSumOfQuantities(Map<String, List<int>> suppliesByTypeMap) {
    Map<String, int> sumOfQuantitiesMap = {};

    suppliesByTypeMap.forEach((type, quantities) {
      int sum = quantities.fold(0, (acc, quantity) => acc + quantity);
      sumOfQuantitiesMap[type] = sum;
    });

    return sumOfQuantitiesMap;
  }


  Future<List<String>> getAllTypes() async {
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse =
        await Dio().get("${AppConstants.apiUrl}/types");
        var rawList = serverResponse.data as List;
        types = rawList.map((e) => e.toString()).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the types!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the types.");
        }
      }
    }
    return types;
  }
  // Future<List<Event>> getTopFiveEventsByParticipantsAndStatus() async {
  //   List<Event> sortedEvents = [];
  //   if (hasNetwork) {
  //     try {
  //       print("Retrieve from server");
  //       Response serverResponse =
  //       await Dio().get("${AppConstants.apiUrl}/allEvents");
  //       var rawList = serverResponse.data as List;
  //       sortedEvents = rawList.map((e) => Event.fromJson(e)).toList();
  //
  //       // Sort events by status in ascending order and participants in descending order
  //       sortedEvents.sort((a, b) {
  //         int statusComparison = a.status.compareTo(b.status);
  //         if (statusComparison != 0) {
  //           return statusComparison; // Sort by status in ascending order
  //         } else {
  //           // If status is the same, sort by participants in descending order
  //           return b.participants.compareTo(a.participants);
  //         }
  //       });
  //
  //       // Return the top five sorted events
  //       return sortedEvents.take(5).toList();
  //     } on DioException catch (e) {
  //       if (e.response != null) {
  //         throw ApplicationException(
  //             e.response?.data ?? "Error while requesting the tasks!");
  //       } else {
  //         throw ApplicationException(
  //             "An unexpected error appeared while requesting the tasks.");
  //       }
  //     }
  //   }
  //
  //   return [];
  // }




  // Future<List<String>> getAllTypes() async {
  //   if (hasNetwork) {
  //     try {
  //       print("Retrieve from server");
  //       Response serverResponse =
  //       await Dio().get("${AppConstants.apiUrl}/types");
  //       var rawList = serverResponse.data as List;
  //       types = rawList.map((e) => e.toString()).toList();
  //     } on DioException catch (e) {
  //       if (e.response != null) {
  //         throw ApplicationException(
  //             e.response?.data ?? "Error while requesting the types!");
  //       } else {
  //         throw ApplicationException(
  //             "An unexpected error appeared while requesting the types.");
  //       }
  //     }
  //   }
  //   return types;
  // }
  //
  Future<List<Supply>> getDetailsBySupply(String id) async {
    List<Supply> suppliesSelected = [];
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse =
        await Dio().get("${AppConstants.apiUrl}/medicalsupply/$id");
        var rawEvent = serverResponse.data ;
        //tasksByDate = rawList.map((e) => Event.fromJson(e)).toList();
        if (rawEvent != null) {
          suppliesSelected.add(Supply.fromJson(rawEvent));
        }
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the supply details!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the supply details.");
        }
      }
    }
    return suppliesSelected;
  }
  //
  // Future<Map<String, double>> getDurationsByMonth() async{
  //   Map<int, String> monthNames = {
  //     1: 'January',
  //     2: 'February',
  //     3: 'March',
  //     4: 'April',
  //     5: 'May',
  //     6: 'June',
  //     7: 'July',
  //     8: 'August',
  //     9: 'September',
  //     10: 'October',
  //     11: 'November',
  //     12: 'December',
  //   };
  //   Map<String, double> durationsByMonth = {};
  //   if (hasNetwork) {
  //     print("Retrieve duration by month");
  //     Response serverResponse = await Dio().get("${AppConstants.apiUrl}/entries");
  //     var rawList = serverResponse.data as List;
  //     tasks = rawList.map((e) => Task.fromJson(e)).toList();
  //     if(tasks.isNotEmpty){
  //       for (var task in tasks) {
  //         String monthName = monthNames[task.date.month] ?? 'Unknown';
  //         if (durationsByMonth.containsKey(monthName)) {
  //           durationsByMonth[monthName] =
  //               durationsByMonth[monthName]! + task.duration;
  //         } else {
  //           durationsByMonth[monthName] = task.duration;
  //         }}
  //     }
  //   }
  //   return durationsByMonth;
  // }

  Future<void> addSupply(String name,String supplier, String details, String status,int quantity,
      String type) async {
    var supply = Supply(
        name: name, supplier: supplier, details: details, status: status, quantity: quantity,type: type);

    if (hasNetwork) {
      try {
        print("Add on server");
        Response serverResponse = await Dio()
            .post("${AppConstants.apiUrl}/medicalsupply", data: supply.toJson());
        supply = Supply.fromJson(serverResponse.data);
      } on DioException catch (e) {
        if (e.response != null) {
          print(e.response);
          throw ApplicationException(
              e.response?.data["text"] ?? "Error while adding the supply!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while adding the supply.");
        }
      }
    } else {
      print("Add on local db");
      supply.localId = await _supplyDao.insertSupply(supply);
    }

    if (supply.id == null || !supplies.map((e) => e.id).contains(supply.id)) {
      supplies.add(supply);
    }
  }

  Supply addRemoteSupply(String remoteSupply) {
    Map<String, dynamic> map;
    try {
      map = Map<String, dynamic>.from(jsonDecode(remoteSupply));
      print(map);
    } catch (e) {
      throw ApplicationException('Error decoding JSON: $remoteSupply');
    }

    var supply = Supply.fromJson(map);
    if (!supplies.map((e) => e.id).contains(supply.id)) {
      supplies.add(supply);
    }

    return supply;
  }

  // Future<void> enroll(String eventId) async {
  //   //var event = events[int.parse(index)];
  //   int id=int.parse(eventId);
  //   if (hasNetwork) {
  //     try {
  //       print("Enroll on server");
  //       Event? event = supplies.firstWhere((e) => e.id == id);
  //       //int eventId = event.id ?? -1;
  //       await Dio().put("${AppConstants.apiUrl}/enroll/$eventId");
  //       await _supplyDao.updateEvent(event);
  //     } on DioException catch (e) {
  //       if (e.response != null) {
  //         throw Exception(e.response?.data ?? "Error while enrolling!");
  //       } else {
  //         throw Exception(
  //             "An unexpected error appeared while enrolling.");
  //       }
  //     }
  //   }
  // }

  Future<void> syncLocalDbWithServer() async {
    print("Sync local with server");
    if (hasNetwork) {
      var localEvents = await _supplyDao.getAllSupplies();
      try {
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/medicalsupplies");
        var rawList = serverResponse.data as List;
        supplies = rawList.map((e) => Supply.fromJson(e)).toList();
        // tasks = rawList.map((e) => Task.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the supplies!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the supplies.");
        }
      }

      var locallySupplies = localEvents.where((x) => x.id==null).toList();
      await _serverBulkAddTasks(locallySupplies);
      _supplyDao.clearSupplies();
    }
  }

  Future<void> saveSupplies() async {
    await _supplyDao.insertSupplies(supplies);
  }

  Future<void> updateSupplies() async {
    await _supplyDao.updateSupplies(supplies);
  }

  Future<void> _serverBulkAddTasks(List<Supply> supplies) async {
    if (hasNetwork && supplies.isNotEmpty) {
      try {
        print("Bulk Add on server");
        supplies.forEach((element) async {
          await Dio()
              .post("${AppConstants.apiUrl}/medicalsupply", data: element.toJson());
        });
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data["text"] ?? "Error while bulk adding the Supplies!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while bulk adding the Supplies.");
        }
      }
    }
  }
}