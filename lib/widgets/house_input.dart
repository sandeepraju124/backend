

// import 'package:backendapp/provider/house_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// class HouseUpdate extends StatefulWidget {
//   const HouseUpdate({super.key});

//   @override
//   State<HouseUpdate> createState() => _HouseUpdateState();
// }

// enum HosueType { un, semi, fully }

// enum Bedrooms { single, double, triple }

// class _HouseUpdateState extends State<HouseUpdate> {
//   bool carParking = false;
//   bool twoWheelerParking = false;
//   HosueType? _selectedHouseType;
//   int? _selectedBedroom;
//   DateTime? availableFrom;
//   late int rent;
//   int adv = 0;
//   String? _Preferred;
//   int? _buildingAge;
//   String? _houseFacing;

//   TextEditingController gateClosingTimeController = TextEditingController();
//   TextEditingController availableFromController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     var data = Provider.of<HouseProvider>(context, listen: false);
//     // await data.fetchHouseData("HOMPLUXrrIUyzX6k");
//     _Preferred = data.houseData![0].preferred ?? '';
//     carParking = data.houseData![0].carParking ?? false;
//     _houseFacing = data.houseData![0].houseFacing ?? '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     var data = Provider.of<HouseProvider>(context);
//     Object? adv = data.houseData != null ? data.houseData![0].advance : 0;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update House Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 16),
//               _buildTenantTypeSelection(),
//               SizedBox(height: 16),
//               _buildAvailableNewFromInput(),
//               SizedBox(height: 16),
//               _buildFacingTypeSelection(),
//               SizedBox(height: 16),
//               _buildBuildingAge(),
//               SizedBox(height: 16),
//               Divider(),
//               Column(
//                 children: [
//                   Text("Furniture type",
//                       style: TextStyle(fontWeight: FontWeight.w500)),
//                 ],
//               ),
//               SizedBox(height: 16),
//               furnitureType(),
//               SizedBox(height: 16),
//               bedrooms(),
//               SizedBox(height: 16),
//               CarParking(),
//               TwoWheelerParking(),
//               SizedBox(height: 10),
//               rentAmount(),
//               SizedBox(height: 10),
//               advAmount(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget advAmount() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: TextFormField(
//         decoration: InputDecoration(
//           labelText: 'Advance Amount',
//           labelStyle: TextStyle(
//             color: Colors.teal,
//             fontWeight: FontWeight.bold,
//           ),
//           hintText: 'Enter the Advance amount',
//           hintStyle: TextStyle(color: Colors.grey),
//           prefixIcon: Icon(Icons.currency_rupee, color: Colors.teal),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             borderSide: BorderSide(
//               color: Colors.teal,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             borderSide: BorderSide(
//               color: Colors.teal,
//               width: 2.0,
//             ),
//           ),
//         ),
//         keyboardType: TextInputType.number,
//         inputFormatters: <TextInputFormatter>[
//           FilteringTextInputFormatter.digitsOnly,
//         ],
//         onChanged: (value) {
//           setState(() {
//             rent = int.tryParse(value) ?? 0;
//           });
//         },
//       ),
//     );
//   }

//   Widget rentAmount() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: TextFormField(
//         decoration: InputDecoration(
//           labelText: 'Rent Amount',
//           labelStyle: TextStyle(
//             color: Colors.teal,
//             fontWeight: FontWeight.bold,
//           ),
//           hintText: 'Enter the rent amount',
//           hintStyle: TextStyle(color: Colors.grey),
//           prefixIcon: Icon(Icons.attach_money, color: Colors.green),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             borderSide: BorderSide(
//               color: Colors.teal,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             borderSide: BorderSide(
//               color: Colors.teal,
//               width: 2.0,
//             ),
//           ),
//         ),
//         keyboardType: TextInputType.number,
//         inputFormatters: <TextInputFormatter>[
//           FilteringTextInputFormatter.digitsOnly,
//         ],
//         onChanged: (value) {
//           setState(() {
//             rent = int.tryParse(value) ?? 0;
//           });
//         },
//       ),
//     );
//   }

//   Widget CarParking() {
//     return CheckboxListTile(
//       title: const Text('Car Parking'),
//       value: carParking,
//       onChanged: (bool? value) {
//         setState(() {
//           carParking = value!;
//         });
//       },
//     );
//   }

//   Widget _buildTenantTypeSelection() {
//     return DropdownButtonFormField<String>(
//       value: _Preferred,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: 'Preferred Tenants',
//       ),
//       items: ['Anyone', 'Family'].map((String type) {
//         return DropdownMenuItem<String>(
//           value: type,
//           child: Text(type),
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           _Preferred = value;
//         });
//       },
//     );
//   }

//   Widget TwoWheelerParking() {
//     return CheckboxListTile(
//       title: const Text('Two Wheeler Parking'),
//       value: twoWheelerParking,
//       onChanged: (bool? value) {
//         setState(() {
//           twoWheelerParking = value!;
//         });
//       },
//     );
//   }

//   Widget bedrooms() {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildBedRoomOption(Bedrooms.single, "Single"),
//           _buildBedRoomOption(Bedrooms.double, "Double"),
//           _buildBedRoomOption(Bedrooms.triple, "Triple"),
//         ],
//       ),
//     );
//   }

//   Widget furnitureType() {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildHouseOption(HosueType.un, "Un"),
//           _buildHouseOption(HosueType.semi, "Semi"),
//           _buildHouseOption(HosueType.fully, "Fully")
//         ],
//       ),
//     );
//   }

//   Widget _buildHouseOption(HosueType type, String label) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedHouseType = type;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: Colors.grey,
//             width: 1.0,
//           ),
//           color: _selectedHouseType == type
//               ? Colors.grey[200]
//               : Colors.white,
//         ),
//         child: Column(
//           children: [
//             if (type == HosueType.un)
//               SvgPicture.asset("assets/fullhouse.svg", height: 30),
//             if (type == HosueType.semi)
//               SvgPicture.asset("assets/pg.svg", height: 30),
//             if (type == HosueType.fully)
//               SvgPicture.asset("assets/penthouse.svg", height: 30),
//             Text(label),
//             Text("Furnished"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBedRoomOption(Bedrooms type, String label) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedBedroom = Bedrooms.values.indexOf(type) + 1;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: Colors.grey,
//             width: 1.0,
//           ),
//           color: _selectedBedroom == Bedrooms.values.indexOf(type) + 1
//               ? Colors.grey[200]
//               : Colors.white,
//         ),
//         child: Column(
//           children: [
//             if (type == Bedrooms.single)
//               SvgPicture.asset("assets/fullhouse.svg", height: 30),
//             if (type == Bedrooms.double)
//               SvgPicture.asset("assets/pg.svg", height: 30),
//             if (type == Bedrooms.triple)
//               SvgPicture.asset("assets/penthouse.svg", height: 30),
//             Text(label),
//             Text("Bedroom"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAvailableNewFromInput() {
//     return TextFormField(
//       controller: availableFromController,
//       readOnly: true,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: 'Available From',
//         suffixIcon: GestureDetector(
//           onTap: () async {
//             DateTime? picked = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2101),
//             );
//             if (picked != null && picked != availableFrom) {
//               setState(() {
//                 availableFrom = picked;
//                 availableFromController.text =
//                     "${picked.toLocal()}".split(' ')[0];
//               });
//             }
//           },
//           child: Icon(Icons.calendar_today),
//         ),
//       ),
//     );
//   }

//   Widget _buildFacingTypeSelection() {
//     return DropdownButtonFormField<String>(
//       value: _houseFacing,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: 'Facing',
//       ),
//       items: ['not to Specify', 'East', 'West', 'South', 'North']
//           .map((String type) {
//         return DropdownMenuItem<String>(
//           value: type,
//           child: Text(type),
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           _houseFacing = value;
//         });
//       },
//     );
//   }

//   Widget _buildBuildingAge() {
//     return DropdownButtonFormField<String>(
//       value: _buildingAge != null ? _buildingAge.toString() : null,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: 'Building Age',
//       ),
//       items: ['One', 'Two', 'Three', 'Four', 'Five+'].map((String type) {
//         return DropdownMenuItem<String>(
//           value: type,
//           child: Text(type),
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           if (value == "One") {
//             _buildingAge = 1;
//           } else if (value == "Two") {
//             _buildingAge = 2;
//           } else if (value == "Three") {
//             _buildingAge = 3;
//           } else if (value == "Four") {
//             _buildingAge = 4;
//           } else if (value == "Five+") {
//             _buildingAge = 5;
//           }
//         });
//       },
//     );
//   }
// }





import 'package:backendapp/provider/house_provider.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HouseUpdate extends StatefulWidget {
  const HouseUpdate({super.key});

  @override
  State<HouseUpdate> createState() => _HouseUpdateState();
}

enum HosueType { un, semi, fully }

enum Bedrooms { single, double, triple }

class _HouseUpdateState extends State<HouseUpdate> {
  bool carParking = false;
  bool twoWheelerParking = false;
  HosueType? _selectedHouseType;
  int? _selectedBedroom;
  DateTime? availableFrom;
  late Object rent;
  Object adv = 0;
  String? _Preferred;
  int? _buildingAge;
  String? _houseFacing;

  TextEditingController gateClosingTimeController = TextEditingController();
  TextEditingController availableFromController = TextEditingController();
  TextEditingController advAmountController = TextEditingController();
  TextEditingController rentAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var data = Provider.of<HouseProvider>(context, listen: false);
    _Preferred = data.houseData![0].preferred ?? '';
    carParking = data.houseData![0].carParking ?? false;
    _houseFacing = data.houseData![0].houseFacing ?? '';
    adv = data.houseData != null ? data.houseData![0].advance ?? 0 : 0;
    advAmountController.text = adv.toString();
    rent = data.houseData != null ? data.houseData![0].price ?? 0 : 0;
    rentAmountController.text = rent.toString();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<HouseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update House Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              _buildTenantTypeSelection(),
              SizedBox(height: 16),
              _buildAvailableNewFromInput(),
              SizedBox(height: 16),
              _buildFacingTypeSelection(),
              SizedBox(height: 16),
              _buildBuildingAge(),
              SizedBox(height: 16),
              Divider(),
              Column(
                children: [
                  Text("Furniture type",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
              SizedBox(height: 16),
              furnitureType(),
              SizedBox(height: 16),
              bedrooms(),
              SizedBox(height: 16),
              CarParking(),
              TwoWheelerParking(),
              SizedBox(height: 10),
              rentAmount(),
              SizedBox(height: 10),
              advAmount(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () async {
          SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? businessUid = prefs.getString('businessUid');

          Map<String, dynamic> updatedHouseData = {
                    'business_uid': businessUid,
                    'price': rentAmountController.text,
                    'advance': advAmountController.text,
                    // 'contact_information': phoneNumberController.text,
                    // 'business_email': businessEmailController.text,
                    // 'websiteLink': websiteLinkController.text,
                    // 'menuLinks': menuLinks,
                  };

                  bool response = await Provider.of<HouseProvider>(
                          context,
                          listen: false)
                      .updateHouseData(updatedHouseData);
                  if (response) {
                    showSnackBar(context, "House Details Updated Sucessfully");
                    Navigator.pop(context);
                  }
        },
        child: Container(
          height: 55,
          width: double.infinity,
          color: tgAccentColor,
          child: Center(
              child: 
              data.isLoadingPatch
                    ? CircularProgressIndicator(backgroundColor: Colors.white,)
                  : 
                  Text(
                      "Update",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
        ),
      ),
    );
  }

  Widget advAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: advAmountController,
        decoration: InputDecoration(
          labelText: 'Advance Amount',
          labelStyle: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
          hintText: 'Enter the Advance amount',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.currency_rupee, color: Colors.teal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.teal,
              width: 2.0,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          setState(() {
            adv = int.tryParse(value) ?? 0;
          });
        },
      ),
    );
  }

  Widget rentAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: rentAmountController,
        decoration: InputDecoration(
          labelText: 'Rent Amount',
          labelStyle: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
          hintText: 'Enter the rent amount',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.attach_money, color: Colors.green),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.teal,
              width: 2.0,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          setState(() {
            rent = int.tryParse(value) ?? 0;
          });
        },
      ),
    );
  }

  Widget CarParking() {
    return CheckboxListTile(
      title: const Text('Car Parking'),
      value: carParking,
      onChanged: (bool? value) {
        setState(() {
          carParking = value!;
        });
      },
    );
  }

  Widget _buildTenantTypeSelection() {
    return DropdownButtonFormField<String>(
      value: _Preferred,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Preferred Tenants',
      ),
      items: ['Anyone', 'Family'].map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _Preferred = value;
        });
      },
    );
  }

  Widget TwoWheelerParking() {
    return CheckboxListTile(
      title: const Text('Two Wheeler Parking'),
      value: twoWheelerParking,
      onChanged: (bool? value) {
        setState(() {
          twoWheelerParking = value!;
        });
      },
    );
  }

  Widget bedrooms() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBedRoomOption(Bedrooms.single, "Single"),
          _buildBedRoomOption(Bedrooms.double, "Double"),
          _buildBedRoomOption(Bedrooms.triple, "Triple"),
        ],
      ),
    );
  }

  Widget furnitureType() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildHouseOption(HosueType.un, "Un"),
          _buildHouseOption(HosueType.semi, "Semi"),
          _buildHouseOption(HosueType.fully, "Fully")
        ],
      ),
    );
  }

  Widget _buildHouseOption(HosueType type, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedHouseType = type;
        });
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          color: _selectedHouseType == type
              ? Colors.grey[200]
              : Colors.white,
        ),
        child: Column(
          children: [
            if (type == HosueType.un)
              SvgPicture.asset("assets/fullhouse.svg", height: 30),
            if (type == HosueType.semi)
              SvgPicture.asset("assets/pg.svg", height: 30),
            if (type == HosueType.fully)
              SvgPicture.asset("assets/penthouse.svg", height: 30),
            Text(label),
            Text("Furnished"),
          ],
        ),
      ),
    );
  }

  Widget _buildBedRoomOption(Bedrooms type, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBedroom = Bedrooms.values.indexOf(type) + 1;
        });
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          color: _selectedBedroom == Bedrooms.values.indexOf(type) + 1
              ? Colors.grey[200]
              : Colors.white,
        ),
        child: Column(
          children: [
            if (type == Bedrooms.single)
              SvgPicture.asset("assets/fullhouse.svg", height: 30),
            if (type == Bedrooms.double)
              SvgPicture.asset("assets/pg.svg", height: 30),
            if (type == Bedrooms.triple)
              SvgPicture.asset("assets/penthouse.svg", height: 30),
            Text(label),
            Text("Bedroom"),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableNewFromInput() {
    return TextFormField(
      controller: availableFromController,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Available From',
        suffixIcon: GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: availableFrom ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != availableFrom) {
              setState(() {
                availableFrom = picked;
                availableFromController.text =
                    "${picked.toLocal()}".split(' ')[0];
              });
            }
          },
          child: Icon(Icons.calendar_today),
        ),
      ),
    );
  }

  Widget _buildFacingTypeSelection() {
    return DropdownButtonFormField<String>(
      value: _houseFacing,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Facing',
      ),
      items: ['not to Specify', 'East', 'West', 'South', 'North']
          .map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _houseFacing = value;
        });
      },
    );
  }

  Widget _buildBuildingAge() {
    return DropdownButtonFormField<String>(
      value: _buildingAge != null ? _buildingAge.toString() : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Building Age',
      ),
      items: ['One', 'Two', 'Three', 'Four', 'Five+'].map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          if (value == "One") {
            _buildingAge = 1;
          } else if (value == "Two") {
            _buildingAge = 2;
          } else if (value == "Three") {
            _buildingAge = 3;
          } else if (value == "Four") {
            _buildingAge = 4;
          } else if (value == "Five+") {
            _buildingAge = 5;
          }
        });
      },
    );
  }
}
