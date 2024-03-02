import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:event_managment_app/common/constants.dart';
import 'package:event_managment_app/common/exceptions/application_exception.dart';
import 'package:event_managment_app/data_access/dao/event_dao.dart';
import 'package:event_managment_app/data_access/models/event.dart';

class EventBusinessLogic {
  final EventDao _eventDao;

  //List<String> tasksDays=[];
  List<Event> events =[];
  List<String> types = [];
  bool hasNetwork = false;

  EventBusinessLogic(this._eventDao);
  // Future<void> init() async {
  //   tasks = await getAllTasks();
  // }

  //



  Future<List<Event>> getAllEvents() async {
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/events");
        var rawList = serverResponse.data as List;
        events = rawList.map((e) => Event.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the events!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the events.");
        }
      }
    } else {
      print("Retrieve from local database");
      events = await _eventDao.getAllEvents();
    }
    return events;
  }
  Future<List<Event>> getAllEventsInProgress() async {
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/inProgress");
        var rawList = serverResponse.data as List;
        events = rawList.map((e) => Event.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the events!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the events.");
        }
      }
    } else {
      print("Retrieve from local database");
      events = await _eventDao.getAllEvents();
    }
    return events;
  }

  Future<List<Event>> getTopFiveEventsByParticipantsAndStatus() async {
    List<Event> sortedEvents = [];
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse =
        await Dio().get("${AppConstants.apiUrl}/allEvents");
        var rawList = serverResponse.data as List;
        sortedEvents = rawList.map((e) => Event.fromJson(e)).toList();

        // Sort events by status in ascending order and participants in descending order
        sortedEvents.sort((a, b) {
          int statusComparison = a.status.compareTo(b.status);
          if (statusComparison != 0) {
            return statusComparison; // Sort by status in ascending order
          } else {
            // If status is the same, sort by participants in descending order
            return b.participants.compareTo(a.participants);
          }
        });

        // Return the top five sorted events
        return sortedEvents.take(5).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the tasks!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the tasks.");
        }
      }
    }

    return [];
  }




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
  Future<List<Event>> getDetailsByEvent(String id) async {
    List<Event> tasksByDate = [];
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse =
        await Dio().get("${AppConstants.apiUrl}/event/$id");
        var rawEvent = serverResponse.data ;
        //tasksByDate = rawList.map((e) => Event.fromJson(e)).toList();
        if (rawEvent != null) {
          tasksByDate.add(Event.fromJson(rawEvent));
        }
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the events!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the events.");
        }
      }
    }
    return tasksByDate;
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

  Future<void> addEvent(String name,String team, String details, String status,int participants,
      String type) async {
    var event = Event(
        name: name, team: team, details: details, status: status, participants: participants,type: type);

    if (hasNetwork) {
      try {
        print("Add on server");
        Response serverResponse = await Dio()
            .post("${AppConstants.apiUrl}/event", data: event.toJson());
        event = Event.fromJson(serverResponse.data);
      } on DioException catch (e) {
        if (e.response != null) {
          print(e.response);
          throw ApplicationException(
              e.response?.data["text"] ?? "Error while adding the event!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while adding the event.");
        }
      }
    } else {
      print("Add on local db");
      event.localId = await _eventDao.insertEvent(event);
    }

    if (event.id == null || !events.map((e) => e.id).contains(event.id)) {
      events.add(event);
    }
  }

  Event addRemoteTask(String remoteTask) {
    Map<String, dynamic> map;
    try {
      map = Map<String, dynamic>.from(jsonDecode(remoteTask));
      print(map);
    } catch (e) {
      throw ApplicationException('Error decoding JSON: $remoteTask');
    }

    var event = Event.fromJson(map);
    if (!events.map((e) => e.id).contains(event.id)) {
      events.add(event);
    }

    return event;
  }

  Future<void> enroll(String eventId) async {
    //var event = events[int.parse(index)];
    int id=int.parse(eventId);
    if (hasNetwork) {
      try {
        print("Enroll on server");
        Event? event = events.firstWhere((e) => e.id == id);
        //int eventId = event.id ?? -1;
        await Dio().put("${AppConstants.apiUrl}/enroll/$eventId");
        await _eventDao.updateEvent(event);
      } on DioException catch (e) {
        if (e.response != null) {
          throw Exception(e.response?.data ?? "Error while enrolling!");
        } else {
          throw Exception(
              "An unexpected error appeared while enrolling.");
        }
      }
    }
  }

  Future<void> syncLocalDbWithServer() async {
    print("Sync local with server");
    if (hasNetwork) {
      var localEvents = await _eventDao.getAllEvents();
      try {
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/events");
        var rawList = serverResponse.data as List;
        events = rawList.map((e) => Event.fromJson(e)).toList();
        // tasks = rawList.map((e) => Task.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the tasks!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the tasks.");
        }
      }

      var locallyAddedEvents = localEvents.where((x) => x.id==null).toList();
      await _serverBulkAddTasks(locallyAddedEvents);
      _eventDao.clearEvents();
    }
  }

  Future<void> saveTasks() async {
    await _eventDao.insertEvents(events);
  }

  Future<void> updateTasks() async {
    await _eventDao.updateEvents(events);
  }

  Future<void> _serverBulkAddTasks(List<Event> tasks) async {
    if (hasNetwork && tasks.isNotEmpty) {
      try {
        print("Bulk Add on server");
        tasks.forEach((element) async {
          await Dio()
              .post("${AppConstants.apiUrl}/event", data: element.toJson());
        });
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data["text"] ?? "Error while bulk adding the Events!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while bulk adding the Events.");
        }
      }
    }
  }
}