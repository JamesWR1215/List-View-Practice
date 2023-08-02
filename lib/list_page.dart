import 'package:flutter/material.dart';
import 'package:more_list_views/data/student_data.dart';
import 'package:more_list_views/model/student_model.dart';
import 'package:more_list_views/widget/search_widget.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late List<Student> students; //list of students
  late List<Student> chargers; // list of students currently borrowing a charger
  String query = '';

  @override
  void initState() {
    super.initState();

    //lists initialized
    students = allStudents;
    chargers = allStudents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search Lists'),
          backgroundColor: Colors.deepPurpleAccent[200],
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSearch(),
            studentList(),
            Container(
              height: 30,
              color: Colors.deepPurpleAccent[200],
              child: const Center(
                child: Text(
                  'Chargers',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            chargerList(),
          ],
        ));
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Name or ID#',
        onChanged: searchStudent,
      );

  Widget buildStudent(Student student) => ListTile(
        //creates list tile wiith student object
        title: Center(child: Text(student.name)),
        subtitle: Center(child: Text(student.id.toString())),
        trailing: student.charger
            //if student is not borrowing a charger return a red +
            //else return a blue -
            ? IconButton(
                icon: const Icon(Icons.minimize),
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    student.charger = !student.charger;
                  });
                },
              )
            : IconButton(
                icon: const Icon(Icons.add),
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    student.charger = !student.charger;
                  });
                },
              ),
      );

  Expanded studentList() {
    // list of student objects
    return Expanded(
      child: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return buildStudent(student);
        },
      ),
    );
  }

  Expanded chargerList() {
    // list of students borrowing chargers
    return Expanded(
      child: ListView.builder(
        itemCount: chargers.length,
        itemBuilder: (context, index) {
          final student = students[index];
          if (student.charger) {
            return buildStudent(student);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void searchStudent(String query) {
    // seearch list of student objects
    final students = allStudents.where((student) {
      final nameLower = student.name.toLowerCase();
      final id = student.id.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) || id.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.students = students;
    });
  }
}
