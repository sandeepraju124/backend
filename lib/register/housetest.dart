import 'package:flutter/material.dart';


class PGDetailsForm extends StatefulWidget {
  @override
  _PGDetailsFormState createState() => _PGDetailsFormState();
}

class _PGDetailsFormState extends State<PGDetailsForm> {
  String pgAvailableFor = 'Anyone';
  String preferredTenant = 'Student';
  DateTime? availableFrom;
  bool foodIncluded = false;
  String gateClosingTime = '';
  bool noSmoking = false;
  bool noNonVeg = false;
  bool noGuardian = false;
  bool noDrinking = false;
  String otherRules = '';

  String facing = 'West';
  int buildingAge = 0;
  int rent = 0;
  int bedrooms = 0;
  bool carParking = false;
  int advance = 0;
  String preferred = 'Anyone';
  String furnishingLevel = 'Unfurnished';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          // PG Availability
          Text('PG available for*'),
          Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: const Text('Male'),
                  leading: Radio<String>(
                    value: 'Male',
                    groupValue: pgAvailableFor,
                    onChanged: (value) {
                      setState(() {
                        pgAvailableFor = value!;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Female'),
                  leading: Radio<String>(
                    value: 'Female',
                    groupValue: pgAvailableFor,
                    onChanged: (value) {
                      setState(() {
                        pgAvailableFor = value!;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Anyone'),
                  leading: Radio<String>(
                    value: 'Anyone',
                    groupValue: pgAvailableFor,
                    onChanged: (value) {
                      setState(() {
                        pgAvailableFor = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          // Preferred Tenants
          DropdownButtonFormField<String>(
            value: preferredTenant,
            hint: Text('Select tenant type'),
            onChanged: (value) {
              setState(() {
                preferredTenant = value!;
              });
            },
            items: ['Student', 'Professional', 'Anyone'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          // Available From
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Available From*',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != availableFrom)
                setState(() {
                  availableFrom = picked;
                });
            },
          ),
          // Food Included
          Text('Food Included*'),
          Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: const Text('Yes'),
                  leading: Radio<bool>(
                    value: true,
                    groupValue: foodIncluded,
                    onChanged: (value) {
                      setState(() {
                        foodIncluded = value!;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('No'),
                  leading: Radio<bool>(
                    value: false,
                    groupValue: foodIncluded,
                    onChanged: (value) {
                      setState(() {
                        foodIncluded = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          // PG Rules
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter gate closing time',
            ),
            onChanged: (value) {
              setState(() {
                gateClosingTime = value;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('No Smoking'),
            value: noSmoking,
            onChanged: (bool? value) {
              setState(() {
                noSmoking = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('No Non-veg'),
            value: noNonVeg,
            onChanged: (bool? value) {
              setState(() {
                noNonVeg = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('No Guardian'),
            value: noGuardian,
            onChanged: (bool? value) {
              setState(() {
                noGuardian = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('No Drinking'),
            value: noDrinking,
            onChanged: (bool? value) {
              setState(() {
                noDrinking = value!;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Specify other rules',
            ),
            onChanged: (value) {
              setState(() {
                otherRules = value;
              });
            },
          ),
          Divider(),
          // Additional Details
          DropdownButtonFormField<String>(
            value: facing,
            hint: Text('Select facing direction'),
            onChanged: (value) {
              setState(() {
                facing = value!;
              });
            },
            items: ['West', 'North', 'East', 'South'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Building Age',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                buildingAge = int.parse(value);
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Rent',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                rent = int.parse(value);
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Bedrooms',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                bedrooms = int.parse(value);
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Car Parking'),
            value: carParking,
            onChanged: (bool? value) {
              setState(() {
                carParking = value!;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Advance',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                advance = int.parse(value);
              });
            },
          ),
          DropdownButtonFormField<String>(
            value: preferred,
            hint: Text('Preferred Tenants'),
            onChanged: (value) {
              setState(() {
                preferred = value!;
              });
            },
            items: ['Family', 'Anyone'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButtonFormField<String>(
            value: furnishingLevel,
            hint: Text('Furnishing Level'),
            onChanged: (value) {
              setState(() {
                furnishingLevel = value!;
              });
            },
            items: ['Unfurnished', 'Semi-Furnished', 'Fully Furnished']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle form submission
            },
            child: Text('Save and Continue'),
          ),
        ],
      ),
    );
  }
}
