import 'package:flutter/material.dart';
import 'package:meuapp/controller/course_controller.dart';
import 'package:meuapp/model/course_model.dart';

class FormNewCoursePage extends StatefulWidget {
  FormNewCoursePage({super.key, this.courseEdit});

  CourseEntity? courseEdit;

  @override
  State<FormNewCoursePage> createState() => _FormNewCoursePageState();
}

class _FormNewCoursePageState extends State<FormNewCoursePage> {
  CourseController controller = CourseController();
  final _formKey = GlobalKey<FormState>();

  String id = '';
  TextEditingController textNameController = TextEditingController();
  TextEditingController textDescriptionController = TextEditingController();
  TextEditingController textStartAtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.courseEdit != null) {
      textNameController.text = widget.courseEdit?.name ?? '';
      textDescriptionController.text = widget.courseEdit?.description ?? '';
      textStartAtController.text =
          controller.dateTimeToDateBR(widget.courseEdit!.start_at) ?? '';
      id = widget.courseEdit?.id ?? '';
    }
  }

  putUpdateCourse() async {
    try {
      await controller.postNewCourse(
        CourseEntity(
          id: id,
          name: textNameController.text,
          description: textDescriptionController.text,
          start_at: controller.dateBRToDateApi(textStartAtController.text),
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

  postNewCourse() async {
    try {
      await controller.postNewCourse(
        CourseEntity(
          name: textNameController.text,
          description: textDescriptionController.text,
          start_at: controller.dateBRToDateApi(textStartAtController.text),
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
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 15),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
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
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
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
                        return 'Por favor, insira a descrição..';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    onTap: () {
                      //showDatePicker class
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                primaryColor: Colors.deepOrangeAccent,
                                hintColor: Colors.deepOrange,
                                colorScheme: ColorScheme.light(
                                    primary: Colors.deepOrange),
                                buttonTheme: ButtonThemeData(
                                    textTheme: ButtonTextTheme.primary),
                              ),
                              child: child!,
                            );
                          }).then(
                        (value) {
                          //import 'package:intl/intl.dart';
                          //Date Format
                          if (value != null) {
                            setState(
                              () {
                                textStartAtController.text = controller
                                    .dateTimeToDateBR(value.toString());
                                //  DateFormat('dd/MM/yyyy').format(value);
                              },
                            );
                          }
                        },
                      );
                    },
                    controller: textStartAtController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 17),
                      filled: true,
                      hintText: 'Informe a data de início',
                      suffixIcon: Icon(
                        Icons.calendar_today,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 45,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      backgroundColor: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        //aqui enviar para api os dados
                        if (widget.courseEdit != null) {
                          putUpdateCourse();
                        } else {
                          postNewCourse();
                        }
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
      ),
    );
  }
}
