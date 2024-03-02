import 'package:floor/floor.dart';
import 'package:task_managment_app/data_access/models/task.dart';

@dao
abstract class TaskDao {
  @Query('SELECT date FROM Tasks')
  Future<List<String>> getAllTasksDays();

  @Query('SELECT * FROM Tasks')
  Future<List<Task>> getAllTasks();


  @insert
  Future<int> insertTask(Task task);


  @insert
  Future<List<int>> insertTasks(List<Task> task);


  @delete
  Future<void> deleteTask(Task task);

  @Query('DELETE FROM Tasks')
  Future<void> clearTasks();

  @update
  Future<void> updateTask(Task task);
  @update
  Future<void> updateTasks(List<Task> tasks);
}