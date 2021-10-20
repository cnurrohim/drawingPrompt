// ignore_for_file: unnecessary_getters_setters

class Monster{
  int? id;
  String bodyType;
  int eyesCount; 
  int limbsCount;
  List<String?> extraFeature;
  int status = 0;
  
  Monster({
    this.id,
    required this.bodyType,
    required this.eyesCount,
    required this.limbsCount,
    required this.extraFeature,
    this.status = 0
  });
  
  factory Monster.fromMap(Map<String, dynamic> json) {
    List<String> extraFeatures = [];
    if(json['extra_feature'] is String){
        extraFeatures = json['extra_feature'].split(',');
    }else if(json['extra_feature'] == null){
        extraFeatures = [];
    }else{
        extraFeatures = json['extra_feature'];
    }
    
      return Monster(
        id: json['id'],
        bodyType: json['bodyType'],
        eyesCount: json['eyesCount'],
        limbsCount: json['limbsCount'],
        extraFeature: extraFeatures,
        status: json['status'],
    );
  }

  Map<String, dynamic> mainFeaturesMap(){
    return {
      'id':id,
      'bodyType':bodyType,
      'eyesCount':eyesCount,
      'limbsCount':limbsCount,
      'status':status,
    };
  }

  static Map<String, dynamic> changedStatus(status){
    return {
      'status': (status == 0) ? 1 : 0,
    };
  }

  List<Map<String,dynamic>> extraFeaturesMap(){
    List<Map<String,dynamic>> extraFeatureList = [];
    for (var feature in extraFeature) {
      extraFeatureList.add(
        {
          'extra_feature':feature
        }
      );
    }

    return extraFeatureList;
  }

}