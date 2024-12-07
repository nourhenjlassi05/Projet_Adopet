import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'DogService.dart';
import 'models/Dog.dart';

class EditDogScreen extends StatefulWidget {
  final Dog dog;

  EditDogScreen({required this.dog});

  @override
  _EditDogScreenState createState() => _EditDogScreenState();
}

class _EditDogScreenState extends State<EditDogScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController genderController;
  late TextEditingController colorController;
  late TextEditingController weightController;
  late TextEditingController locationController;
  late TextEditingController aboutController;

  File? _selectedImage;
  Uint8List? _webImageBytes;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.dog.name);
    ageController = TextEditingController(text: widget.dog.age.toString());
    genderController = TextEditingController(text: widget.dog.gender);
    colorController = TextEditingController(text: widget.dog.color);
    weightController = TextEditingController(text: widget.dog.weight.toString());
    locationController = TextEditingController(text: widget.dog.location);
    aboutController = TextEditingController(text: widget.dog.about);
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImageBytes = Uint8List.fromList(bytes);
        });
      } else {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final dogData = {
        "name": nameController.text,
        "age": double.tryParse(ageController.text) ?? 0.0,
        "gender": genderController.text,
        "color": colorController.text,
        "weight": double.tryParse(weightController.text) ?? 0.0,
        "location": locationController.text,
        "about": aboutController.text,
      };

      try {

        await DogService.editDog(
          id: widget.dog.id,
          data: dogData,
          imageFile: _selectedImage,
          webImageBytes: _webImageBytes,
        );


        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Dog updated successfully!")),
        );
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update dog: $error")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Dog"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name"),
                  validator: (value) => value!.isEmpty ? "Enter a name" : null,
                ),
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: "Age"),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                  value!.isEmpty ? "Enter the dog's age" : null,
                ),
                TextFormField(
                  controller: genderController,
                  decoration: InputDecoration(labelText: "Gender"),
                  validator: (value) => value!.isEmpty ? "Enter gender" : null,
                ),
                TextFormField(
                  controller: colorController,
                  decoration: InputDecoration(labelText: "Color"),
                  validator: (value) => value!.isEmpty ? "Enter color" : null,
                ),
                TextFormField(
                  controller: weightController,
                  decoration: InputDecoration(labelText: "Weight"),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                  value!.isEmpty ? "Enter weight" : null,
                ),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(labelText: "Location"),
                  validator: (value) =>
                  value!.isEmpty ? "Enter location" : null,
                ),
                TextFormField(
                  controller: aboutController,
                  decoration: InputDecoration(labelText: "About"),
                  maxLines: 4,
                  validator: (value) =>
                  value!.isEmpty ? "Enter details about the dog" : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: Icon(Icons.photo),
                  label: Text("Pick Image"),
                  onPressed: _pickImage,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text("Update Dog"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
