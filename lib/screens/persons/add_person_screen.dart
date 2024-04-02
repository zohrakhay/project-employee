import 'package:flutter/material.dart';
import 'package:technical_test_mosofty/models/person.dart';
import 'package:technical_test_mosofty/services/person_service.dart';
import 'package:email_validator/email_validator.dart';

class AddPersonPage extends StatefulWidget {
  const AddPersonPage({super.key});

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  Future<void> _addPerson() async {
    Person newPerson = Person(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        userName: userNameController.text);

    await PersonService().postPerson(newPerson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Ajouter un employé'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      controller: lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez un nom';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Prénom',
                      ),
                      controller: firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez un prénom';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Email',
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez un email';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Entrez un email valide';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        labelText: 'Nom d\'utilisateur',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez un nom d\'utilisateur';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addPerson();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Employé ajouté avec succés!'),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Ajouter la personne"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
