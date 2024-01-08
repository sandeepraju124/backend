// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAhead extends StatefulWidget {
  const TypeAhead({super.key});

  @override
  State<TypeAhead> createState() => _TypeAheadState();
}

class _TypeAheadState extends State<TypeAhead> {
  TextEditingController _serviceEditingController = TextEditingController();
  String _selectedField = "";

  

  final List<String> services = [
    'Beauty & Spas > Barbers',
    'Beauty & Spas > Cosmetics & Beauty Supply',
    'Beauty & Spas > Acne Treatment',
    'Education > Adult Education',
    'Home Services > Plumbers',
    'Home Services > Electricians',
    'Home Services > Carpenters'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _serviceEditingController,
                decoration: const InputDecoration(
                  contentPadding :EdgeInsets.all(10),
                  labelText: "Select a Service",
                  border: OutlineInputBorder(),
                )
              ),
              suggestionsCallback: (pattern) {
                if (pattern.isEmpty){
                  return List<String>.empty();
          
                }else{
                  return services.where((service) => service.toLowerCase().contains(pattern.toLowerCase()));
                }
                
              },
              itemBuilder: (context,service){
                return ListTile(title: Text(service),);
              },
              onSuggestionSelected: (service) {
                _serviceEditingController.text = service; 
                setState(() {
                  _selectedField = service;
                });
                print("this is $_selectedField");
                // setState(() {
                //   displayServiceField(service);
                // });
                
              },        
            ),
          ),
          InkWell(onTap: (){
            print(_serviceEditingController.text);
          },
            child:const Text("click")),
            _selectedField != null? displayServiceField(_selectedField) : Text("no")
        ],
      )),
    );
  }
}


Widget displayServiceField(String service){
  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController three = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  switch(service){
    case "Beauty & Spas > Barbers":
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
    
        children: [
          
          TextField(
                  controller: one,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(),
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Plumbing issue description',
                  ),
                ),
                const SizedBox(height: 10,),
          TextField(
                  controller: two,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(),
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Cost estimate',
                  ),
                ),
               const SizedBox(height: 10,),
                TextField(
                  controller: three,
                   decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(),
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Contact information',
                  ),
                ),
      ]),
    );
    

    case 'Home Services > Plumbers':
    return Column(children: const [
        Text("this is 4"),
        Text("this is 5"),
    ]);


    default:
    return Text("nothing selected");



  }

}