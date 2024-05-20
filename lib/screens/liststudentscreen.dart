import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testt2/screens/editscreen.dart';
import 'package:testt2/screens/profilescreen.dart';
import 'package:testt2/servises/searchprovider.dart';
import 'package:testt2/servises/studentprovider.dart';

class ListStudentScreen extends StatelessWidget {
  const ListStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final personProvider = Provider.of<PersonProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);

    final filteredStudents = personProvider.peopleList
        .where((student) => student.name
            .toLowerCase()
            .contains(searchProvider.searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          TextField(
            onChanged: (value) {
              searchProvider.updateSearchQuery(value);
            },
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          filteredStudents.isEmpty
              ? const Center(
                  child: Text(
                    'No results found.',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileSCreen(student: student)),
                              );
                            },
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[300],
                              backgroundImage:
                                  FileImage(File(student.profile)),
                            ),
                            title: Text(student.name),
                            subtitle: Text(student.place),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditStudentScreen(
                                                  student: student)),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Are you sure you want to delete?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                personProvider
                                                    .deletePerson(index);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider()
                        ],
                      );
                    },
                  ),
                ),
        ],
      ),

    );
  }
}
