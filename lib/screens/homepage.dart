import 'package:flutter/material.dart';
import 'package:testt2/screens/addscreen.dart';
import 'package:testt2/screens/gridscreem.dart';
import 'package:testt2/screens/liststudentscreen.dart';

class Titlebar extends StatelessWidget {


  Titlebar({Key? key}) : super(key: key) {

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
   backgroundColor: Color.fromARGB(255, 163, 169, 179),
        
          title: const Center(child: Text('Students')),
          bottom: const TabBar(
            
            tabs: [
              Tab(text: 'List'),
              Tab(text: 'Grid'),
            ],
           indicatorColor: Color.fromARGB(255, 238, 235, 235),
          ),
        ),
        body: const TabBarView(
          
          children: [
            ListStudentScreen(),
            GridScreen(),
          ],
        ),
           floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) =>  HomePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      ),
    );
  }
}
