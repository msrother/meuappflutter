import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meuapp/controller/course_controller.dart';
import 'package:meuapp/model/course_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:meuapp/utils.dart';
import 'dart:math';

import 'package:meuapp/view/login_page.dart';

//gera uma cor aleatória para cada CircleAvatar
Color generateRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
      random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CourseEntity>>? coursesFuture;
  CourseController controller = CourseController();

  Future<List<CourseEntity>> getCourses() async {
    return await controller.getCourseList();
  }

  @override
  void initState() {
    super.initState();
    coursesFuture = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meu app"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Center(
                    child: Text('Menu',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ),
              ListTile(
                leading: Icon(Icons.book_outlined),
                title: Text('Cursos'),
                onTap: () async {
                  setState(() {
                    coursesFuture = controller.getCourseList();
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.calendar_month_outlined),
                title: Text('Feriados'),
                onTap: () {
                  // Lógica
                },
              ),
              ListTile(
                leading: Icon(Icons.school_outlined),
                title: Text('Professores'),
                onTap: () {
                  // Lógica
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Sair'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Sair do Aplicativo'),
                      content: Text('Você tem certeza que deseja sair?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Fecha o diálogo
                          },
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Fecha o aplicativo
                            SystemNavigator.pop(); //só funciona em android
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage(), //será direcionado para a login novamente
                              ),
                            );
                          },
                          child: Text('Sair'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: coursesFuture == null
            ? Center(child: Text('Utilize o menu para carregar os dados.'))
            : FutureBuilder(
                future: coursesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: Slidable(
                            endActionPane:
                                ActionPane(motion: ScrollMotion(), children: [
                              SlidableAction(
                                onPressed: null,
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.black,
                                icon: Icons.edit,
                                label: 'Alterar',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Confirmação"),
                                      content: const Text(
                                          "Deseja realmente excluir esse curso?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("Cancelar")),
                                        TextButton(
                                            onPressed: () async {
                                              await controller.deleteCourse(
                                                  snapshot.data![index].id!);
                                              Navigator.pop(context);
                                              //
                                            },
                                            child: Text("OK"))
                                      ],
                                    ),
                                  ).then((value) async {
                                    coursesFuture = getCourses();
                                    setState(() {});
                                  });
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Excluir',
                              ),
                            ]),
                            child: ListTile(
                              title: Text(snapshot.data![index].name ?? ''),
                              leading: CircleAvatar(
                                child: CircleAvatar(
                                  backgroundColor: generateRandomColor(),
                                  child: Text(
                                    getFirstLetter(snapshot.data![index].name),
                                  ),
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              subtitle:
                                  Text(snapshot.data![index].description ?? ''),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ));
  }
}
