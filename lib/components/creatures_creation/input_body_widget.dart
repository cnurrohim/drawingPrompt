import 'package:creature_creation_station/common_widget/custom_radio_widget.dart';
import 'package:creature_creation_station/common_widget/custom_heading_widget.dart';
import 'package:creature_creation_station/controllers/input_monster.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class InputBodyWidget extends StatelessWidget {
  const InputBodyWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: _buildForm(context),
    );
  }

  
  Widget _buildForm(BuildContext context) {
    InputMonsterController inputController = Provider.of<InputMonsterController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CustomHeadingWidget('body shape', 24.0, Colors.orange),
        const SizedBox(height: 10),
        CustomRadioWidget(
          featuresList:inputController.availableBodyShapeTypes,
          valueGroup: inputController.selectedBodyFeature,
          onChanged: (value){
                inputController.changeSelectedBodyFeatures(value);
          },
        )
      ],
    );
  }
}
