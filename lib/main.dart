import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:testt2/models/model.dart';
import 'package:testt2/screens/splashscreen.dart';
import 'package:testt2/servises/image%20pickerprovider.dart';
import 'package:testt2/servises/searchprovider.dart';
import 'package:testt2/servises/splashprovider.dart';
import 'package:testt2/servises/studentprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(PersonAdapter()); 
  await Hive.openBox<Person>('people'); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PersonProvider(),),
          ChangeNotifierProvider(create: (context) => SplashScreenProvider(),),
          ChangeNotifierProvider(create: (context) => SearchProvider(),),
          ChangeNotifierProvider(create: (context) => ImageProvidermodel(),)
          
      ],
      child: MaterialApp(
        title: 'CRUD with Hive and Provider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:const Screensplash(),
      ),
    );
  }
}
