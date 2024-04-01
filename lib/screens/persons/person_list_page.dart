import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:technical_test_mosofty/models/person.dart';
import 'package:technical_test_mosofty/services/person_service.dart';

class PersonListPage extends StatefulWidget {
  @override
  _PersonListPageState createState() => _PersonListPageState();
}

class _PersonListPageState extends State<PersonListPage> {
  List<Person> persons = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getPersons();
  }

  Future<void> getPersons() async {
    List<Person> fetchedPersons = await PersonService().getPersons();

    setState(() {
      persons = fetchedPersons;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Tous les employés'),
      ),
      body: Stack(
        children: [
          isLoading
              ? const Center(
                  child: SizedBox(
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
          ListView.builder(
            itemCount: persons.length,
            itemBuilder: (context, index) {
              Person person = persons[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(person.firstName + person.lastName),
                    subtitle: Text(person.email),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
