import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:technical_test_mosofty/models/project.dart';
import 'package:technical_test_mosofty/services/project_service.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AddProjectPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  List<Marker> markers = [];

  Future<void> _addProject() async {
    Project newProject = Project(
        name: nameController.text,
        description: descriptionController.text,
        longitude: longitudeController.text,
        latitude: latitudeController.text);

    await ProjectService().postProject(newProject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Ajouter un projet'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nom du projet',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez un nom';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez une description';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'longitude',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez une longitude';
                        }
                        return null;
                      },
                      controller: longitudeController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: latitudeController,
                      decoration: InputDecoration(
                        labelText: 'latitude',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez une latitude';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(33.892166, 9.56),
                        onTap: (p, latLng) {
                          setState(() {
                            latitudeController.text = latLng.latitude.toString();
                            longitudeController.text = latLng.longitude.toString();
                            markers.clear();
                            markers.add(Marker(
                              width: 80.0,
                              height: 80.0,
                              point: latLng,
                              child: Container(
                                child: const Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 40.0,
                                ),
                              ),
                            ));
                          });
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(markers: markers),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addProject();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Projet ajouté avec succés!'),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Ajouter le projet"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
