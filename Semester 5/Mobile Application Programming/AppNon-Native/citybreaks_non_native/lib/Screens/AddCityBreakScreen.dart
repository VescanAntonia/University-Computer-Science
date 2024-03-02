import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../CityBreak.dart';

class AddCityBreakScreen extends StatefulWidget {
  AddCityBreakScreen({super.key});

  @override
  State<StatefulWidget> createState() => AddCityBreakScreenState();
}

class AddCityBreakScreenState extends State<AddCityBreakScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isValidDate(stringToTest) {
    try {
      DateTime.parse(stringToTest);
    } catch (e) {
      return false;
    }

    return true;
  }

  String cityValue = "";
  String countryValue = "";
  String startDateValue = "";
  String endDateValue = "";
  String descriptionValue = "";
  String accommodationValue = "";
  String budgetValue = "";

  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_photo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Add a city break',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SomeFam',
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0), // Adjust as needed
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please add some text";
                            } else if (!isValidDate(value)) {
                              return "Use format: yyyy-MM-dd";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => startDateValue = value,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SomeFam',
                            ),
                            hintText: 'Start Date...',
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please add some text";
                            } else if (!isValidDate(value)) {
                              return "Use format: yyyy-MM-dd";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => endDateValue = value,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SomeFam',
                            ),
                            hintText: 'End Date...',
                          ),
                        ),
                        SizedBox(height: 30), // Adjust as needed
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please fill up all the fields!";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => cityValue = value,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SomeFam',
                            ),
                            hintText: 'City...',
                          ),
                        ),
                        SizedBox(height: 30), // Adjust as needed
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please fill up all the fields!";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => countryValue = value,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SomeFam',
                            ),
                            hintText: 'Country...',
                          ),
                        ),
                        SizedBox(height: 30), // Adjust as needed
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please fill up all the fields!";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => descriptionValue = value,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SomeFam',
                            ),
                            hintText: 'Description...',
                          ),
                        ),
                        SizedBox(height: 30), // Adjust as needed
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please fill up all the fields!";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => accommodationValue = value,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SomeFam',
                            ),
                            hintText: 'Accommodation...',
                          ),
                        ),
                        SizedBox(height: 30), // Adjust as needed
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please fill up all the fields!";
                            } else if (!isNumeric(value)) {
                              return "Please enter a valid number";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) => budgetValue = value,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SomeFam',
                            ),
                            hintText: 'Budget...',
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: SizedBox(
                                width: 130,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.pop(
                                        context,
                                        CityBreak(
                                          cityValue,
                                          countryValue,
                                          DateTime.parse(startDateValue),
                                          DateTime.parse(endDateValue),
                                          descriptionValue,
                                          accommodationValue,
                                          int.parse(budgetValue),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white.withOpacity(0.7),
                                  ),
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 29.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SomeFam',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
                              child: SizedBox(
                                width: 130,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white.withOpacity(0.7),
                                  ),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 29.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SomeFam',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
