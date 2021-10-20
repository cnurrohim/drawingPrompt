import 'package:creature_creation_station/controllers/input_monster.dart';
import 'package:creature_creation_station/controllers/navigation.dart';
import 'package:creature_creation_station/database/db.dart';
import 'package:creature_creation_station/model/monster.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alert_dialog.dart';

class BottomNavigation extends StatelessWidget {
  final int activeButtonIndex;

  // ignore: use_key_in_widget_constructors
  const BottomNavigation(this.activeButtonIndex);

  @override
  Widget build(BuildContext context) {
    NavigationController navigation = Provider.of<NavigationController>(context);
    InputMonsterController inputController = Provider.of<InputMonsterController>(context);

    List<BottomNavigationBarItem> _listMenuItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.home),label:'home'),
      const BottomNavigationBarItem(icon: Icon(Icons.list),label:'list'),
    ];

    //const IconData _completionIcon = Icons.radio_button_unchecked;
    IconData _completionIcon = (inputController.status == 0) ? Icons.check_circle_outline : Icons.radio_button_unchecked;
    String _completionLabel = (inputController.status == 0) ? 'Completion' : 'Cancel';

    const Color _inactiveColor = Colors.grey;
    Color _randomButtonColor = Colors.greenAccent;
    Color _saveButtonColor = Colors.green;
    
    if(activeButtonIndex == 1){
      _randomButtonColor = _inactiveColor;
      _saveButtonColor = _inactiveColor;
    }

    if(inputController.selectedId != null){
      _listMenuItems.add(BottomNavigationBarItem(
        icon: Icon(_completionIcon,color: Colors.greenAccent),
        label:_completionLabel)
      );
      _listMenuItems.add(const BottomNavigationBarItem(icon: Icon(Icons.delete,color: Colors.red),label:'Delete'));
    }else{
      _listMenuItems.add(BottomNavigationBarItem(icon: Icon(Icons.autorenew,color: _randomButtonColor),label:'random'));
      _listMenuItems.add(BottomNavigationBarItem(icon: Icon(Icons.save,color: _saveButtonColor),label:'Save'));
    }

    

    return BottomNavigationBar(
      currentIndex: activeButtonIndex,
      onTap: (buttonIndex) async {
        switch (buttonIndex) {
          case 0:
            inputController.changeSelectedId(null);
            inputController.setStatus(0);
            navigation.changeSceen('/');
            break;
          case 1:
            navigation.changeSceen('/list');
            break;
          case 2:
            if(inputController.selectedId == null){
              if(activeButtonIndex == 1) break;
              _onTapShowDialog(
                context,
                'Are you sure to randomize selection?',
                'randomize',
                _randomizeSelection,
                'randomized'
              );
            }else{
              _onTapShowDialog(
                context,
                'Are you sure you want to this item\'s status?',
                'change status',
                _changeStatus,
                'status changed'
              );
            }
            break;
          case 3:
            if(inputController.selectedId == null){
              if(activeButtonIndex == 1) break;
              _onTapShowDialog(
                context,
                'Are you sure to save?',
                'Save',
                _saveMonster,
                'Saved'
              );
              
            }else{
              _onTapShowDialog(
              context,
              'Are you sure to delete this entry?',
              'Delete',
              _removeMonster,
              'Item Deleted',
            );
            }

            break;
          default:
            navigation.changeSceen('/');
        }
      },
      type: BottomNavigationBarType.fixed,
      items: _listMenuItems 
    );
  }

  Future _onTapShowDialog(BuildContext context,content,title,Function callback,completedMessage){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowAlertDialog(
          message: content,
          titleMessage: title,
          cancel: true,
          ok:true,
          okCallback: (){
            callback(context);
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(completedMessage),
              duration: const Duration(milliseconds: 400),
            ));
            Navigator.of(context).pop();
          }
        );
      },
    );
  }

  _changeStatus(BuildContext context) async{
    InputMonsterController inputController = Provider.of<InputMonsterController>(context,listen:false);
    await DatabaseHelper.instance.updateStatus(Monster.changedStatus(inputController.status),inputController.selectedId);
    inputController.changeSelectedId(null);
  }

  _saveMonster(BuildContext context) async {
    InputMonsterController inputController = Provider.of<InputMonsterController>(context,listen:false);
    Monster monster = Monster.fromMap(inputController.monsterFeatures);
    await DatabaseHelper.instance.add(monster);
  }

  _removeMonster(BuildContext context) async {
    InputMonsterController inputController = Provider.of<InputMonsterController>(context,listen:false);
    await DatabaseHelper.instance.remove(inputController.selectedId);
    inputController.changeSelectedId(null);
  }

  _randomizeSelection(BuildContext context){
    InputMonsterController inputController = Provider.of<InputMonsterController>(context,listen:false);
    inputController.randomAllSelected();
  }
}