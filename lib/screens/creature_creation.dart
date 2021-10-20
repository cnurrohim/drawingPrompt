import 'package:flutter/material.dart';
import '../common_widget/custom_heading_widget.dart';
import '../components/creatures_creation_input.dart';
import '../components/bottom_navigations.dart';

class CreatureCreation extends StatelessWidget {
  const CreatureCreation({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: _creatureCreationForm(),
        bottomNavigationBar: const BottomNavigation(0),
      )
    );
  }

  Widget _creatureCreationForm(){
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: _buildForm()
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        CustomHeadingWidget('drawing prompt', 44.0, Colors.orange),
        CustomHeadingWidget('Brett\'s Bean Monster Creation Station', 18.0, Colors.white60,fontStyle: FontStyle.italic),
        SizedBox(height: 24,),
        CustomHeadingWidget('let\'s choose some features', 18.0, Colors.white60,fontStyle: FontStyle.italic),
        InputBodyWidget(),
        InputEyesWidget(),
        InputLimbsWidget(),
        InputExtrasWidget()
      ],
    );
  }
}