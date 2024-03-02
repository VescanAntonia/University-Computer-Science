import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../CityBreak.dart';

class UpdateCityBreakScreen extends StatefulWidget {
  const UpdateCityBreakScreen({Key? key, required this.cityBreak}) : super(key: key);

  final CityBreak cityBreak;

  @override
  State<StatefulWidget> createState() => UpdateCityBreakScreenState();
}

class UpdateCityBreakScreenState extends State<UpdateCityBreakScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isValidDate(String stringToTest) {
    try {
      DateTime.parse(stringToTest);
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String cityValue = widget.cityBreak.city;
    String countryValue = widget.cityBreak.country;
    String startDateValue = DateFormat("yyyy-MM-dd").format(widget.cityBreak.startDate);
    String endDateValue = DateFormat("yyyy-MM-dd").format(widget.cityBreak.endDate);
    String descriptionValue = widget.cityBreak.description;
    String accommodationValue = widget.cityBreak.accommodation;
    String budgetValue = widget.cityBreak.budget.toString();

    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_photo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                  child: const Text(
                    'Update a city break',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SomeFam',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          initialValue: DateFormat("yyyy-MM-dd").format(widget.cityBreak.startDate),
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
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SomeFam',
                            ),
                            hintText: 'Start Date...',
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextFormField(
                          initialValue: endDateValue,
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
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SomeFam',
                            ),
                            hintText: 'End Date...',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    initialValue: widget.cityBreak.city,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill up all the fields!";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => cityValue = value,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SomeFam',
                      ),
                      hintText: 'City...',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    initialValue: widget.cityBreak.country,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill up all the fields!";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => countryValue = value,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SomeFam',
                      ),
                      hintText: 'Country...',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    initialValue: widget.cityBreak.description,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill up all the fields!";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => descriptionValue = value,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SomeFam',
                      ),
                      hintText: 'Description...',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    initialValue: widget.cityBreak.accommodation,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill up all the fields!";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => accommodationValue = value,
                    keyboardType: TextInputType.multiline,
                    maxLines: null, // Allow unlimited lines
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SomeFam',
                      ),
                      hintText: 'Accommodation...',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    initialValue: budgetValue,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill up all the fields!";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => budgetValue = value,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SomeFam',
                      ),
                      hintText: 'Budget...',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(
                                  context,
                                  CityBreak.fromCityBreak(
                                    widget.cityBreak.id,
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
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SomeFam',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: SizedBox(
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
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SomeFam',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
