import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRadioWidget extends StatelessWidget{
  
  final Map<dynamic,dynamic> featuresList;
  final dynamic valueGroup;
  final ValueChanged<dynamic> onChanged;
  
  // ignore: use_key_in_widget_constructors
  const CustomRadioWidget(
    {
      required this.featuresList,
      required this.valueGroup,
      required this.onChanged
    }
  );

  @override
  Widget build(BuildContext context) {
     return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: featuresList.keys.map((key)=>Column(
        children: [
          Text(featuresList[key]),
          Radio<dynamic>(
            value: key,
            groupValue: valueGroup,
            activeColor: Theme.of(context).colorScheme.secondary,
            onChanged: (newValue){
              onChanged(newValue);
            }
          )
        ],
      )).toList(),
    );
  }
}