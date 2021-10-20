import 'package:creature_creation_station/common_widget/custom_radio_widget.dart';
import 'package:creature_creation_station/common_widget/custom_heading_widget.dart';
import 'package:creature_creation_station/controllers/input_monster.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputLimbsWidget extends StatelessWidget {
  const InputLimbsWidget({ Key? key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: _buildForm(context),
    );
  }

  
  Widget _buildForm(context) {
    InputMonsterController inputController = Provider.of<InputMonsterController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CustomHeadingWidget('limbs', 24.0, Colors.orange),
        const SizedBox(height: 10),
        CustomRadioWidget(
          featuresList: inputController.numberOfLimbs,
          valueGroup: inputController.selectedLimbsFeature,
          onChanged: (value){
              inputController.changeSelectedLimbsFeatures(value);
          },
        )
      ],
    );
  }
}
