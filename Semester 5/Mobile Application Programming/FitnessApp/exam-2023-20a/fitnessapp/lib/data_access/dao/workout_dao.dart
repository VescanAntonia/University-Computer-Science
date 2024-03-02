import 'package:floor/floor.dart';
import 'package:fitnessapp/data_access/models/workout.dart';

@dao
abstract class WorkoutDao {
  @Query('SELECT * FROM Workouts')
  Future<List<Workout>> getAllWorkouts();

  @insert
  Future<int> insertWorkout(Workout workout);

  @insert
  Future<List<int>> insertWorkouts(List<Workout> workout);

  @delete
  Future<void> deleteWorkout(Workout workout);

  @Query('DELETE FROM Workouts')
  Future<void> clearWorkouts();

  @update
  Future<void> updateWorkout(Workout workout);

  @update
  Future<void> updateWorkouts(List<Workout> workouts);
}