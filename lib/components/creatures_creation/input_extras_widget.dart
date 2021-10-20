import 'package:creature_creation_station/common_widget/custom_checkbox_widget.dart';
import 'package:creature_creation_station/common_widget/custom_heading_widget.dart';
import 'package:creature_creation_station/controllers/input_monster.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputExtrasWidget extends StatelessWidget {

  const InputExtrasWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: _buildForm(context),
    );
  }

  
  Widget _buildForm(context) {
    InputMonsterController inputController = Provider.of<InputMonsterController>(context);

    int _selectedCount = inputController.availableExtraFeatures.entries.map((e)=>(e.value)?1:0).reduce((value, element) => value+element);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CustomHeadingWidget('extra features', 24.0, Colors.orange),
        const CustomHeadingWidget('choose max 2 options', 18.0, Colors.white60),
        const SizedBox(height: 10),
        Column(
        children: [ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 150),
          child: CustomCheckboxWidget(
            featuresList:inputController.availableExtraFeatures,
            onChanged: (value,key){
                  if(_selectedCount < inputController.maxExtraSelected || inputController.availableExtraFeatures[key] == true){
                    inputController.changeSelectedExtraFeatures(key, value);
                    //extraFeature: inputController.availableExtraFeatures.entries.where((extra) => extra.value == true).map((e) => e.key).toList();
                  }
            },
          )
        )]),
      ],
    );
  }
}
