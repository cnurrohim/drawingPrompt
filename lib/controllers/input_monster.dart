import 'dart:math';

import 'package:flutter/material.dart';

class InputMonsterController extends ChangeNotifier{
  
  final Map<String,String> availableBodyShapeTypes = {
    'circle':'circle',
    'square':'square',
    'rectangle':'rectangle',
    'triangle':'triangle',
    'userChoice':'User\'s Choice',
  };

  final Map<int,String> numberOfEyes = {
    1:'one',
    2:'two',
    3:'three',
    4:'four',
    5:'many',
  };
  
  final Map<int,String> numberOfLimbs = {
    1:'one',
    2:'two',
    3:'three',
    4:'four',
    5:'many',
  };
  

  final int maxExtraSelected = 2;
  final Map<String, bool> availableExtraFeatures = {
    'horns':false,
    'spike':false,
    'claws':false,
    'creepy':true,
    'teeth':true,
    'tail':false,
    'furry':false,
    'tentacles':false
  };

  String selectedBodyFeature = 'rectangle';
  int selectedEyesFeature = 1;
  int selectedLimbsFeature = 1;
  int? selectedId;
  int? status;

  Map<String,dynamic> get monsterFeatures{
    List<String> extraFeature = availableExtraFeatures.entries.where((extra) => extra.value == true).map((e) => e.key).toList();
    
    return {
      'bodyType':selectedBodyFeature,
      'eyesCount':selectedEyesFeature,
      'limbsCount':selectedLimbsFeature,
      'extra_feature':extraFeature,
      'status':status
    };
  }

  void setStatus(newStatus){
    status = newStatus;
    notifyListeners();
  }
  
  void changeStatus(){
    status = (status == 0)?1:0;
    notifyListeners();
  }

  void changeSelectedId(newSelectedId){
    selectedId = newSelectedId;
    notifyListeners();
  }

  void changeSelectedBodyFeatures(newSelectedBodyFeatures){
    selectedBodyFeature = newSelectedBodyFeatures;
    notifyListeners();
  }

  void changeSelectedEyesFeatures(newSelectedEyesFeatures){
    selectedEyesFeature = newSelectedEyesFeatures;
    notifyListeners();
  }

  void changeSelectedLimbsFeatures(newSelectedLimbsFeatures){
    selectedLimbsFeature = newSelectedLimbsFeatures;
    notifyListeners();
  }

  void changeSelectedExtraFeatures(key,newSelectedExtraFeatures){
    availableExtraFeatures[key] = newSelectedExtraFeatures;
    notifyListeners();
  }

  void resetAvailableExtraFeatures(){
    availableExtraFeatures.forEach((key, value) {
      availableExtraFeatures[key] = false;
    });
  }

  void randomAllSelected(){
    resetAvailableExtraFeatures();
    var randomKey = Random();

    final List<String> _availableBodyShapeList = availableBodyShapeTypes.entries.map((e) => e.key).toList();
    final List<String> _availableExtraFeatureList = availableExtraFeatures.entries.map((e) => e.key).toList();

    selectedBodyFeature = _availableBodyShapeList[randomKey.nextInt(availableBodyShapeTypes.length)];
    availableExtraFeatures[_availableExtraFeatureList[randomKey.nextInt(availableExtraFeatures.length)]] = true;
    availableExtraFeatures[_availableExtraFeatureList[randomKey.nextInt(availableExtraFeatures.length)]] = true;
    selectedEyesFeature = randomKey.nextInt(numberOfEyes.length) + 1;
    selectedLimbsFeature = randomKey.nextInt(numberOfLimbs.length) + 1;
    status = 0;
    notifyListeners();
  }

}