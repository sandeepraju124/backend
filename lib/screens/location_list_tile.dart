import 'package:flutter/material.dart';

class LocationListTile extends StatelessWidget {
  final VoidCallback press;
  final String location;
  const LocationListTile({
    Key?key,
  required this.location,required this.press}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        onTap: press,
        horizontalTitleGap: 0,
        leading: const Icon(Icons.location_on_rounded),
        title: Text(location,maxLines: 2,overflow: TextOverflow.ellipsis,),

      ),
      Divider(thickness: 2,height: 2,)
    ],);
  }
}
