import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:testt2/models/model.dart';
import 'package:testt2/screens/homepage.dart';
import 'package:testt2/servises/image%20pickerprovider.dart';
import 'package:testt2/servises/studentprovider.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Student'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.00,
        backgroundColor: Color.fromARGB(255, 162, 162, 162),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            InkWell(
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
                                    _getImagecamara(context);
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
                backgroundColor: Colors.white,
                radius: 80,
                child: ClipOval(
                  child: Consumer<ImageProvidermodel>(
                    builder: (context, imageProvider, child) {
                      return imageProvider.image == null
                          ? Image.network(
                              "https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0=",
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              imageProvider.image!,
                              fit: BoxFit.contain,
                            );
                    },
                  ),
                ),
              ),
            ),
            const Align(
                alignment: Alignment.center,
                child: Text(
                  "Profile",
                  style: TextStyle(
                      fontFamily: AutofillHints.addressCity,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      fontStyle: FontStyle.italic),
                )),
            const SizedBox(height: 50),
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
            const SizedBox(height: 90),
            ElevatedButton(
              onPressed: () async {
                final name = _nameController.text;
                final age = int.tryParse(_ageController.text) ?? 0;
                final place = _placeController.text;
                final phoneNumber = _phoneController.text;

             
                if (name.isEmpty ||
                    age <= 0 ||
                    place.isEmpty ||
                    phoneNumber.isEmpty ||
                    Provider.of<ImageProvidermodel>(context, listen: false)
                            .image ==
                        null) {
   
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields'),
                    ),
                  );
                  return;
                }

            
                if (!name.startsWith(RegExp(r'[A-Z]'))) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Name should start with a capital letter'),
                    ),
                  );
                  return;
                }

                if (phoneNumber.length != 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Phone number should be 10 digits long'),
                    ),
                  );
                  return;
                }

                final personProvider =
                    Provider.of<PersonProvider>(context, listen: false);
                final imageProvider =
                    Provider.of<ImageProvidermodel>(context, listen: false);
                final student = Person(
                  name: name,
                  age: age,
                  place: place,
                  number: phoneNumber,
                  profile: imageProvider.image != null
                      ? imageProvider.image!.path
                      : '',
                );
                personProvider.addPerson(student);
                _nameController.clear();
                _ageController.clear();
                _placeController.clear();
                _phoneController.clear();
                imageProvider.setImage(null);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Titlebar()),
                );
              },
              child: const Text('Add'),
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

  Future<void> _getImagecamara(BuildContext context) async {
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
