import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:technical_test_mosofty/models/person.dart';
import 'package:technical_test_mosofty/services/person_service.dart';

class UpdatePersonPage extends StatefulWidget {
  const UpdatePersonPage({super.key});

  @override
  State<UpdatePersonPage> createState() => _UpdatePersonPage();
}

class _UpdatePersonPage extends State<UpdatePersonPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  bool isLoading = false;

  Future<void> _getOnePerson() async {
    setState(() {
      isLoading = true;
    });
    int? id = int.tryParse(idController.text);
    if (id != null) {
      Person? person = await PersonService().getOnePerson(id);
      if (person != null) {
        setState(() {
          firstNameController.text = person.firstName;
          lastNameController.text = person.lastName;
          emailController.text = person.email;
          userNameController.text = person.userName;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Infos récupérés !'),
          ),
        );
        setState(() {
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Employé introuvable! '),
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Entrez un id valide'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updatePerson() async {
    Person modifiedPerson = Person(
        id: int.parse(idController.text),
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        userName: userNameController.text);
    try {
      await PersonService().updatePerson(modifiedPerson);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Modifier un employé'),
      ),
      body: Stack(children: [
        isLoading
            ? Center(
                child: const SizedBox(
                  height: 70,
                  width: 70,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader,
                    colors: [Colors.grey],
                    strokeWidth: 2,
                  ),
                ),
              )
            : Container(),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 16, bottom: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'ID de la personne',
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
                        controller: idController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez un id';
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
                          _getOnePerson();
                        },
                        child: Text("Récupérer la personne")),
                    Column(
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
                              labelText: 'Prénom',
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
                              labelText: 'Nom d\'utilisateur',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Entrez un nom d\'utilisateur';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _updatePerson();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Employé modifié avec succés!'),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Modifier la personne"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
