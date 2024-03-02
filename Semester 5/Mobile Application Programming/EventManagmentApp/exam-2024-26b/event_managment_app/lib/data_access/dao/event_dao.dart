import 'package:floor/floor.dart';
import 'package:event_managment_app/data_access/models/event.dart';

@dao
abstract class EventDao {

  @Query('SELECT * FROM Events')
  Future<List<Event>> getAllEvents();


  @insert
  Future<int> insertEvent(Event task);


  @insert
  Future<List<int>> insertEvents(List<Event> task);


  @delete
  Future<void> deleteEvent(Event task);

  @Query('DELETE FROM Events')
  Future<void> clearEvents();

  @update
  Future<void> updateEvent(Event task);
  @update
  Future<void> updateEvents(List<Event> tasks);
}