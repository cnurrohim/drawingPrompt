import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckboxWidget extends StatelessWidget{
  
  final Map<String,bool> featuresList;
  final Function onChanged;
  
  // ignore: use_key_in_widget_constructors
  const CustomCheckboxWidget(
    {
      required this.featuresList,
      required this.onChanged
    }
  );

  @override
  Widget build(BuildContext context) {
     return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: featuresList.keys.map((key)=>Column(
        children: [Column(
          children:[
            CheckboxListTile(
              title: Text(key),
              checkColor: Theme.of(context).colorScheme.secondary,
              activeColor: Theme.of(context).scaffoldBackgroundColor,
              value: featuresList[key],
              onChanged: (newValue){
                onChanged(newValue,key);
              },
            ),
          ],
        )]
      )).toList(),
    );
  }
}