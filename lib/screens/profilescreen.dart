import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testt2/screens/editscreen.dart';
import 'package:testt2/servises/studentprovider.dart';


class ProfileSCreen extends StatelessWidget {

  // ignore: prefer_typing_uninitialized_variables
  final student;
  const ProfileSCreen({super.key, this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Profile'),
                titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
        backgroundColor: Color.fromARGB(255, 162, 156, 158),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          
     
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:150),
              child: CircleAvatar(
                radius: 80,
                       backgroundImage: FileImage(File(student.profile)),
              ),
            ),
          const  SizedBox(height: 50),
            Text('Name  : ${student.name}',style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 25 
            ),),
            const  SizedBox(height: 20),
            Text('Place : ${student.place}',style:const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
            ),), // Use lowercase 'place'
            const  SizedBox(height: 10),
            Text('Age   : ${student.age.toString()}',style:const TextStyle(
             fontWeight: FontWeight.w500,
             fontSize:20 
            ),), 
            const  SizedBox(height: 10),
            Text('Number: ${student.number}',style:const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
            ),),
         const   SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                 onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => EditStudentScreen(student: student),));
                 },
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    backgroundColor: Colors.black
                  ),
                  child:const Icon(Icons.edit),
                ),
             const    SizedBox(width: 20), // Add spacing between buttons
               ElevatedButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure you want to delete this profile?"),
         // content: Text("This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                final personProvider = Provider.of<PersonProvider>(context, listen: false);
                personProvider.deletePerson(personProvider.peopleList.indexOf(student));
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  },
  style: ElevatedButton.styleFrom(
    // ignore: deprecated_member_use
    backgroundColor: Colors.red, // Change button color to red
  ),
  child: const Icon(Icons.delete),
),

              ],
            ),
          ],
        ),
      ),
      )
    );
  }
}
