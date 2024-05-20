import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:testt2/models/model.dart';
import 'package:testt2/servises/image%20pickerprovider.dart';
import 'package:testt2/servises/studentprovider.dart';

class EditStudentScreen extends StatelessWidget {
  final Person student;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  EditStudentScreen({super.key, required this.student}) {
    _nameController.text = student.name;
    _ageController.text = student.age.toString();
    _placeController.text = student.place;
    _phoneController.text = student.number;
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProvidermodel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Studnet Details'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
        backgroundColor: Color.fromARGB(255, 185, 176, 179),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.black,
                  context: context,
                  builder: (BuildContext builderContext) {
                  
                    return SizedBox(
                      height: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _getImage(context);
                                  },
                                  icon: const Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  )),
                              const Text(
                                "Gallery",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _getImagecamera(context);
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  )),
                              const Text(
                                "Camera",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
           
              },
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[300],
                backgroundImage: imageProvider.image != null
                    ? FileImage(imageProvider.image!)
                    : student.profile.isNotEmpty
                        ? FileImage(File(student.profile))
                        : const AssetImage('assets/default_profile.png')
                            as ImageProvider,
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _placeController,
              decoration: const InputDecoration(labelText: 'Place'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedStudent = Person(
                  name: _nameController.text,
                  age: int.tryParse(_ageController.text) ?? 0,
                  place: _placeController.text,
                  number: _phoneController.text,
                  profile: imageProvider.image != null
                      ? imageProvider.image!.path
                      : student.profile,
                );


                final personProvider =
                    Provider.of<PersonProvider>(context, listen: false);
                personProvider.updatePerson(
                  personProvider.peopleList.indexWhere((p) => p == student),
                  updatedStudent,
                );

            
                Provider.of<ImageProvidermodel>(context, listen: false)
                    .clearImage();

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // ignore: use_build_context_synchronously
      Provider.of<ImageProvidermodel>(context, listen: false)
          .setImage(File(image.path));
    }
  }

  Future<void> _getImagecamera(BuildContext context) async {
    final imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // ignore: use_build_context_synchronously
      Provider.of<ImageProvidermodel>(context, listen: false)
          .setImage(File(image.path));
    }
  }
}
