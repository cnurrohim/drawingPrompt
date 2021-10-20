import 'package:creature_creation_station/controllers/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/input_monster.dart';
import 'screens/created_creatures_page.dart';
import 'screens/creature_creation.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<NavigationController>(
          create: (_) => NavigationController(),
        ),
        ListenableProvider<InputMonsterController>(
          create: (_) => InputMonsterController(),
        ),
      ],
      child: const CreatureCreationStation(),
    )
  );
}

class CreatureCreationStation extends StatelessWidget {
  const CreatureCreationStation({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationController navigation = Provider.of<NavigationController>(context);
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColorDark: Colors.red,
        primaryColor: Colors.blue,
        colorScheme: const ColorScheme.dark().copyWith(
          secondary: Colors.pink,
          secondaryVariant: Colors.pink[600]
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.black54,
          actionTextColor: Colors.pinkAccent,
          contentTextStyle: TextStyle(color: Colors.pink),
        ),
      ),
      home: Navigator(
        pages: [
          if(navigation.screenName == '/')
            const MaterialPage(child: CreatureCreation()),
          if(navigation.screenName == '/list')
            const MaterialPage(child: CreatedCreaturesPage()),
        ],
        onPopPage: (route,result){
          bool popStatus = route.didPop(result);
          if(popStatus == true){
            Provider.of<NavigationController>(context, listen: false).changeSceen('/');
          }
          return popStatus;
        }
      )
    );
  }
}