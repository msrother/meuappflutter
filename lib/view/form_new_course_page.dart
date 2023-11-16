import 'package:flutter/material.dart';
import 'package:meuapp/controller/course_controller.dart';
import 'package:meuapp/model/course_model.dart';

class FormNewCoursePage extends StatefulWidget {
  const FormNewCoursePage({super.key});

  @override
  State<FormNewCoursePage> createState() => _FormNewCoursePageState();
}

class _FormNewCoursePageState extends State<FormNewCoursePage> {
  CourseController controller = CourseController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController textNameController = TextEditingController();
  TextEditingController textDescriptionController = TextEditingController();
  TextEditingController textStartAtController = TextEditingController();

  postNewCourse() async {
    try {
      await controller.postNewCourse(
        CourseEntity(
          name: textNameController.text,
          description: textDescriptionController.text,
          start_at: textStartAtController.text,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados salvos!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Curso"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 15),
          child: Column(
            children: [
              TextFormField(
                controller: textNameController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 17),
                  filled: true,
                  hintText: 'Informe o nome',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome..';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: textDescriptionController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 17),
                  filled: true,
                  hintText: 'Informe a descrição',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira a descrição..';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onTap: () {
                  //showDatePicker class
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  ).then(
                    (value) {
                      //import 'package:intl/intl.dart';
                      //Date Format
                      if (value != null) {
                        setState(
                          () {
                            textStartAtController.text = value
                                .toString(); //set output date to TextField value.
                          },
                        );
                      }
                    },
                  );
                },
                controller: textStartAtController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 17),
                  filled: true,
                  hintText: 'Informe a data início',
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                height: 45,
                child: ElevatedButton(
                  //copiar da tela de login
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //aqui enviar para api os dados
                      postNewCourse();
                    }
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
