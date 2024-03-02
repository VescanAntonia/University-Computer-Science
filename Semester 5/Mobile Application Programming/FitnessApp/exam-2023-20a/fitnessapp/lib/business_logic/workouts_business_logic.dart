import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fitnessapp/common/constants.dart';
import 'package:fitnessapp/common/exceptions/application_exception.dart';
import 'package:fitnessapp/data_access/dao/workout_dao.dart';
import 'package:fitnessapp/data_access/models/workout.dart';

class WorkoutBusinessLogic {
  final WorkoutDao _workoutDao;

  List<Workout> workouts = [];
  List<String> types = [];
  bool hasNetwork = false;

  WorkoutBusinessLogic(this._workoutDao);

  Future<List<Workout>> getAllMeals() async {
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/all");
        var rawList = serverResponse.data as List;
        workouts = rawList.map((e) => Workout.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the workouts!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the workouts.");
        }
      }
    } else {
      print("Retrieve from local database");
      workouts = await _workoutDao.getAllWorkouts();
    }
    return workouts;
  }

  Future<List<Workout>> getTopTenWorkouts() async {
    List<Workout> sortedWorkouts = List.from(workouts);
    sortedWorkouts.sort((a, b) => b.calories.compareTo(a.calories));
    return sortedWorkouts.take(10).toList();
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

  Future<List<Workout>> getWorkoutsByType(String type) async {
    List<Workout> mealsByType = [];
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse =
        await Dio().get("${AppConstants.apiUrl}/workouts/$type");
        var rawList = serverResponse.data as List;
        mealsByType = rawList.map((e) => Workout.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the wotkouts!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the workouts.");
        }
      }
    }
    return mealsByType;
  }

  Map<String, double> getCaloriesByType() {
    Map<String, double> caloriesByType = {};
    if (hasNetwork) {
      print("Retrieve calories by type");
      for (var meal in workouts) {
        if (caloriesByType.containsKey(meal.type)) {
          caloriesByType[meal.type] =
              caloriesByType[meal.type]! + meal.calories;
        } else {
          caloriesByType[meal.type] = meal.calories;
        }
      }
    }
    return caloriesByType;
  }

  Future<void> addWorkout(String name, String type,double duration, double calories, DateTime date,
      String notes) async {
    var workout = Workout(
        name: name, type: type, duration:duration, calories: calories, date: date, notes: notes);

    if (hasNetwork) {
      try {
        print("Add on server");
        Response serverResponse = await Dio()
            .post("${AppConstants.apiUrl}/workout", data: workout.toJson());
        workout = Workout.fromJson(serverResponse.data);
      } on DioException catch (e) {
        if (e.response != null) {
          print(e.response);
          throw ApplicationException(
              e.response?.data["text"] ?? "Error while adding the workout!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while adding the workout.");
        }
      }
    } else {
      print("Add on local db");
      workout.localId = await _workoutDao.insertWorkout(workout);
    }

    if (workout.id == null || !workouts.map((e) => e.id).contains(workout.id)) {
      workouts.add(workout);
    }
  }

  Workout addRemoteMeal(String remoteMeal) {
    Map<String, dynamic> map;
    try {
      map = Map<String, dynamic>.from(jsonDecode(remoteMeal));
      print(map);
    } catch (e) {
      throw ApplicationException('Error decoding JSON: $remoteMeal');
    }

    var meal = Workout.fromJson(map);
    if (!workouts.map((e) => e.id).contains(meal.id)) {
      workouts.add(meal);
    }

    return meal;
  }

  Future<void> deleteMeal(int index) async {
    var workout = workouts.removeAt(index);
    if (hasNetwork) {
      try {
        print("Delete on server");
        int mealId = workout.id ?? -1;
        await Dio().delete("${AppConstants.apiUrl}/workout/$mealId");
      } on DioException catch (e) {
        if (e.response != null) {
          throw Exception(e.response?.data ?? "Error while deleting the workout!");
        } else {
          throw Exception(
              "An unexpected error appeared while deleting the workout.");
        }
      }
    }
  }

  Future<void> syncLocalDbWithServer() async {
    print("Sync local with server");
    if (hasNetwork) {
      var localMeals = await _workoutDao.getAllWorkouts();
      try {
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/all");
        var rawList = serverResponse.data as List;
        workouts = rawList.map((e) => Workout.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the workouts!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the wotkouts.");
        }
      }

      var locallyAddedMeals = localMeals.where((x) => x.id == null).toList();
      await _serverBulkAddMeals(locallyAddedMeals);
      _workoutDao.clearWorkouts();
    }
  }

  Future<void> saveMeals() async {
    await _workoutDao.insertWorkouts(workouts);
  }

  Future<void> updateMeals() async {
    await _workoutDao.updateWorkouts(workouts);
  }

  Future<void> _serverBulkAddMeals(List<Workout> workouts) async {
    if (hasNetwork && workouts.isNotEmpty) {
      try {
        print("Bulk Add on server");
        workouts.forEach((element) async {
          await Dio()
              .post("${AppConstants.apiUrl}/workout", data: element.toJson());
        });
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data["text"] ?? "Error while bulk adding the Workouts!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while bulk adding the Workouts.");
        }
      }
    }
  }
}