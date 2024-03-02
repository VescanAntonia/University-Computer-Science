import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:library_managment_app/common/constants.dart';
import 'package:library_managment_app/common/exceptions/application_exception.dart';
import 'package:library_managment_app/data_access/dao/book_dao.dart';
import 'package:library_managment_app/data_access/models/book.dart';

class BookBusinessLogic {
  final BookDao _bookDao;

  List<Book> books = [];
  List<String> types = [];
  bool hasNetwork = false;

  BookBusinessLogic(this._bookDao);

  Future<List<Book>> getAllBooks() async {
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/books");
        var rawList = serverResponse.data as List;
        books = rawList.map((e) => Book.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the books!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the books.");
        }
      }
    } else {
      print("Retrieve from local database");
      books = await _bookDao.getAllBooks();
    }
    return books;
  }

  Future<List<Book>> getReservedBooks() async {
    if (hasNetwork) {
      try {
        print("Retrieve from server");
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/reserved");
        var rawList = serverResponse.data as List;
        books = rawList.map((e) => Book.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the books!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the books.");
        }
      }
    } else {
      print("Retrieve from local database");
      books = await _bookDao.getAllBooks();
    }
    return books;
  }

  Future<List<Book>> getSortedBooks() async {
    try {
      List<Book> sortedBooks = List.from(books);

      sortedBooks.sort((a, b) => a.genre.compareTo(b.genre));
      sortedBooks.sort((a, b) => a.quantity.compareTo(b.quantity));

      // books.sort((a, b) {
      //   int quantityComparison = a.quantity.compareTo(b.quantity);
      //   if (quantityComparison != 0) {
      //     return quantityComparison;
      //   }
      //   return a.genre.compareTo(b.genre);
      // });

      return sortedBooks.toList();
    } catch (e) {
      print("Error in getSortedBooks: $e");
      return [];
    }
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

  // Future<List<Meal>> getMealsByType(String type) async {
  //   List<Meal> mealsByType = [];
  //   if (hasNetwork) {
  //     try {
  //       print("Retrieve from server");
  //       Response serverResponse =
  //       await Dio().get("${AppConstants.apiUrl}/meals/$type");
  //       var rawList = serverResponse.data as List;
  //       mealsByType = rawList.map((e) => Meal.fromJson(e)).toList();
  //     } on DioException catch (e) {
  //       if (e.response != null) {
  //         throw ApplicationException(
  //             e.response?.data ?? "Error while requesting the meals!");
  //       } else {
  //         throw ApplicationException(
  //             "An unexpected error appeared while requesting the meals.");
  //       }
  //     }
  //   }
  //   return mealsByType;
  // }
  //
  // Map<String, double> getCaloriesByType() {
  //   Map<String, double> caloriesByType = {};
  //   if (hasNetwork) {
  //     print("Retrieve calories by type");
  //     for (var meal in books) {
  //       if (caloriesByType.containsKey(meal.type)) {
  //         caloriesByType[meal.type] =
  //             caloriesByType[meal.type]! + meal.calories;
  //       } else {
  //         caloriesByType[meal.type] = meal.calories;
  //       }
  //     }
  //   }
  //   return caloriesByType;
  // }
  //
  Future<void> addBook(String title, String author, String genre, int quantity,
      int reserved) async {
    var book = Book(title:title, author:author, genre:genre, quantity:quantity,reserved: reserved);

    if (hasNetwork) {
      try {
        print("Add on server");
        Response serverResponse = await Dio()
            .post("${AppConstants.apiUrl}/book", data: book.toJson());
        book = Book.fromJson(serverResponse.data);
      } on DioException catch (e) {
        if (e.response != null) {
          print(e.response);
          throw ApplicationException(
              e.response?.data["text"] ?? "Error while adding the book!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while adding the book.");
        }
      }
    } else {
      print("Add on local db");
      book.localId = await _bookDao.insertBook(book);
    }

    if (book.id == null || !books.map((e) => e.id).contains(book.id)) {
      books.add(book);
    }
  }

  Book addRemoteBook(String remoteBook) {
    Map<String, dynamic> map;
    try {
      map = Map<String, dynamic>.from(jsonDecode(remoteBook));
      print(map);
    } catch (e) {
      throw ApplicationException('Error decoding JSON: $remoteBook');
    }

    var book = Book.fromJson(map);
    if (!books.map((e) => e.id).contains(book.id)) {
      books.add(book);
    }

    return book;
  }

  // Future<void> deleteMeal(int index) async {
  //   var meal = books.removeAt(index);
  //   if (hasNetwork) {
  //     try {
  //       print("Delete on server");
  //       int mealId = meal.id ?? -1;
  //       await Dio().delete("${AppConstants.apiUrl}/meal/$mealId");
  //     } on DioException catch (e) {
  //       if (e.response != null) {
  //         throw Exception(e.response?.data ?? "Error while deleting the meal!");
  //       } else {
  //         throw Exception(
  //             "An unexpected error appeared while deleting the meal.");
  //       }
  //     }
  //   }
  // }

  Future<void> syncLocalDbWithServer() async {
    print("Sync local with server");
    if (hasNetwork) {
      var localMeals = await _bookDao.getAllBooks();
      try {
        Response serverResponse = await Dio().get("${AppConstants.apiUrl}/books");
        var rawList = serverResponse.data as List;
        books = rawList.map((e) => Book.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data ?? "Error while requesting the books!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while requesting the books.");
        }
      }

      var locallyAddedMeals = localMeals.where((x) => x.id == null).toList();
      await _serverBulkAddMeals(locallyAddedMeals);
      _bookDao.clearBooks();
    }
  }

  Future<void> saveMeals() async {
    await _bookDao.insertBooks(books);
  }

  Future<void> updateMeals() async {
    await _bookDao.updateBooks(books);
  }

  Future<void> _serverBulkAddMeals(List<Book> books) async {
    if (hasNetwork && books.isNotEmpty) {
      try {
        print("Bulk Add on server");
        books.forEach((element) async {
          await Dio()
              .post("${AppConstants.apiUrl}/book", data: element.toJson());
        });
      } on DioException catch (e) {
        if (e.response != null) {
          throw ApplicationException(
              e.response?.data["text"] ?? "Error while bulk adding the Books!");
        } else {
          throw ApplicationException(
              "An unexpected error appeared while bulk adding the Books.");
        }
      }
    }
  }
}