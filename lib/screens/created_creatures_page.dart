import 'package:creature_creation_station/controllers/input_monster.dart';
import 'package:provider/provider.dart';

import '../components/bottom_navigations.dart';
import 'package:creature_creation_station/database/db.dart';
import 'package:creature_creation_station/model/monster.dart';
import 'package:flutter/material.dart';

class CreatedCreaturesPage extends StatelessWidget {
  const CreatedCreaturesPage({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing Prompts'),
      ),
      body: _savedMonsters(context),
      bottomNavigationBar: const BottomNavigation(1),
    );
  }

  Widget _savedMonsters(context) {
    InputMonsterController inputController = Provider.of<InputMonsterController>(context);
    
    return Center(
      child: FutureBuilder<List<Monster>>(
        future: DatabaseHelper.instance.getMonster(),
        builder: (BuildContext context,AsyncSnapshot<List<Monster>> snapshot){
          if(!snapshot.hasData){
            return const Center(child: Text('Loading ... '));
          }
          
          return snapshot.data!.isEmpty
          ? const Center(child: Text('no created monster yet'))
          : ListView(
            children: snapshot.data!.map((Monster){
              
                return Center(
                  child: Card(
                    color: inputController.selectedId == Monster.id ? Theme.of(context).colorScheme.secondaryVariant : Theme.of(context).scaffoldBackgroundColor,
                    child: ListTile(
                      title: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children: [
                            const TextSpan(text: 'Draw a monster with '),
                            TextSpan(text: Monster.bodyType, style: const TextStyle(color: Colors.cyanAccent,fontWeight: FontWeight.bold)),
                            const TextSpan(text: ' body shape, it has '),
                            TextSpan(text: Monster.eyesCount.toString(), style: const TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.bold)),
                            const TextSpan(text: ' Eyes and '),
                            TextSpan(text: Monster.limbsCount.toString(), style: const TextStyle(color: Colors.yellowAccent,fontWeight: FontWeight.bold)),
                            const TextSpan(text: ' Limbs'),
                            TextSpan(text: (Monster.extraFeature.isNotEmpty) ? ', with ' + Monster.extraFeature.join(' and ') : '', style: const TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold)),
                            const TextSpan(text: ' \nStatus: '),
                            TextSpan(text: (Monster.status == 0) ? 'Incomplete' : 'Complete', style: TextStyle(color: (Monster.status == 0) ? Colors.red : Colors.green[600],fontWeight: FontWeight.bold)),
                          ],
                        )
                      ),
                      onTap:(){
                        if(inputController.selectedId == null || inputController.selectedId != Monster.id){
                          inputController.changeSelectedId(Monster.id);
                          inputController.setStatus(Monster.status);
                        }else{
                          inputController.changeSelectedId(null);
                          inputController.setStatus(0);
                        }
                        
                      },
                    )
                  )
                );
              }
            ).toList(),
          );
        },
      ),
    );
    
  }
}