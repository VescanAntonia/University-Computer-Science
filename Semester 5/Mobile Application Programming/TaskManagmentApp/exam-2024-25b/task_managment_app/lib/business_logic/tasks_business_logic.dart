import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:task_managment_app/common/constants.dart';
import 'package:task_managment_app/common/exceptions/application_exception.dart';
import 'package:task_managment_app/data_access/dao/task_dao.dart';
import 'package:task_managment_app/data_access/models/task.dart';

class TaskBusinessLogic {
  final TaskDao _taskDao;

  List<String> tasksDays=[];
  List<Task> tasks =[];
  List<String> types = [];
  bool hasNetwork = false;

  TaskBusinessLogic(this._taskDao);
  Future<void> init() async {
    tasks = await getAllTasks();
  }

  Future<List<String>> getAllTasksDays() async {
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/taskDays");
        var rawList = serverResponse.data as List;
        tasksDays = rawList.cast<String>().toList();
        //tasks = rawList.map((e) => Task.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the tasks!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the tasks.");
        }
      }
    } else {
      print("Retrieve from local database");
      tasksDays = await _taskDao.getAllTasksDays();
    }
    return tasksDays;
  }



  Future<List<Task>> getAllTasks() async {
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/entries");
        var rawList = serverResponse.data as List;
        tasks = rawList.map((e) => Task.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the meals!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the meals.");
        }
      }
    } else {
      print("Retrieve from local database");
      tasks = await _taskDao.getAllTasks();
    }
    return tasks;
  }

  Future<List<List<String>>> getTopThreeCategoriesWithTaskCount() async {
    if (hasNetwork) {
      try {
        // Retrieve tasks from the server
        print("Retrieve from server");
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/entries");
        var rawList = serverResponse.data as List;
        tasks = rawList.map((e) => Task.fromJson(e)).toList();

        // Sort tasks by categories
        tasks.sort((a, b) => a.category.compareTo(b.category));

        Map<String, int> categoryCountMap = {};

        // Count tasks in each category
        for (var task in tasks) {
          categoryCountMap.update(task.category, (value) => value + 1,
              ifAbsent: () => 1);
        }

        // Sort categories by the number of tasks
        List<MapEntry<String, int>> sortedCategories =
        categoryCountMap.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        // Return the top three categories with task count
        List<List<String>> result = sortedCategories
            .take(3)
            .map((entry) => [entry.key, entry.value.toString()])
            .toList();

        return result;
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
  Future<List<Task>> getTasksByDate(String date) async {
    List<Task> tasksByDate = [];
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse =
        await Dio().get("${AppConstants.apiUrl}/details/$date");
        var rawList = serverResponse.data as List;
        tasksByDate = rawList.map((e) => Task.fromJson(e)).toList();
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
    return tasksByDate;
  }

  Future<Map<String, double>> getDurationsByMonth() async{
    Map<int, String> monthNames = {
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December',
    };
    Map<String, double> durationsByMonth = {};
    if (hasNetwork) {
      print("Retrieve duration by month");
      Response serverResponse = await Dio().get("${AppConstants.apiUrl}/entries");
      var rawList = serverResponse.data as List;
      tasks = rawList.map((e) => Task.fromJson(e)).toList();
      if(tasks.isNotEmpty){
      for (var task in tasks) {
        String monthName = monthNames[task.date.month] ?? 'Unknown';
        if (durationsByMonth.containsKey(monthName)) {
          durationsByMonth[monthName] =
              durationsByMonth[monthName]! + task.duration;
        } else {
          durationsByMonth[monthName] = task.duration;
        }}
      }
    }
    return durationsByMonth;
  }

  Future<void> addTask(DateTime date,String type, double duration, String priority,String category,
      String description) async {
    var task = Task(
        date: date, type: type, duration: duration, priority: priority, category: category,description: description);

    if (hasNetwork) {
      try {
        print("Add on server");
        Response serverResponse = await Dio()
            .post("${AppConstants.apiUrl}/task", data: task.toJson());
        task = Task.fromJson(serverResponse.data);
      } on DioException catch (e) {
        if (e.response != null) {
          print(e.response);
          throw ApplicationException(
              e.response?.data["text"] ?? "Error while adding the task!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while adding the task.");
        }
      }
    } else {
      print("Add on local db");
      task.localId = await _taskDao.insertTask(task);
    }

    if (task.id == null || !tasks.map((e) => e.id).contains(task.id)) {
      tasks.add(task);
    }
  }

  Task addRemoteTask(String remoteTask) {
    Map<String, dynamic> map;
    try {
      map = Map<String, dynamic>.from(jsonDecode(remoteTask));
      print(map);
    } catch (e) {
      throw ApplicationException('Error decoding JSON: $remoteTask');
    }

    var task = Task.fromJson(map);
    if (!tasks.map((e) => e.id).contains(task.id)) {
      tasks.add(task);
    }

    return task;
  }

  Future<void> deleteTask(int index) async {
    var task = tasks.removeAt(index);
    if (hasNetwork) {
      try {
        print("Delete on server");
        int mealId = task.id ?? -1;
        await Dio().delete("${AppConstants.apiUrl}/task/$mealId");
      } on DioException catch (e) {
        if (e.response != null) {
          throw Exception(e.response?.data ?? "Error while deleting the meal!");
        } else {
          throw Exception(
              "An unexpected error appeared while deleting the meal.");
        }
      }
    }
  }

  Future<void> syncLocalDbWithServer() async {
    print("Sync local with server");
    if (hasNetwork) {
      var localTasks = await _taskDao.getAllTasksDays();
      try {
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/taskDays");
        var rawList = serverResponse.data as List;
        tasksDays = rawList.cast<String>().toList();
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

      var locallyAddedMeals = localTasks.where((x) => x.isEmpty).toList();
      await _serverBulkAddTasks(locallyAddedMeals);
      _taskDao.clearTasks();
    }
  }

  Future<void> saveTasks() async {
    await _taskDao.insertTasks(tasks);
  }

  Future<void> updateTasks() async {
    await _taskDao.updateTasks(tasks);
  }

  Future<void> _serverBulkAddTasks(List<String> tasks) async {
    if (hasNetwork && tasks.isNotEmpty) {
      try {
        print("Bulk Add on server");
        tasks.forEach((element) async {
          await Dio()
              .post("${AppConstants.apiUrl}/task", data: {'date': element});
        });
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data["text"] ?? "Error while bulk adding the Tasks!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while bulk adding the Tasks.");
        }
      }
    }
  }
}