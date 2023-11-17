import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meuapp/model/course_model.dart';
import 'package:meuapp/view/holiday_page.dart';
import 'package:meuapp/view/home_page.dart';
import 'package:meuapp/view/login_page.dart';
import 'package:meuapp/controller/course_controller.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  late Future<List<CourseEntity>> coursesFuture;
  CourseController controller = CourseController();

  Future<List<CourseEntity>> getCourses() async {
    return await controller.getCourseList();
  }

  @override
  void initState() {
    super.initState();
    coursesFuture = getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
            ),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book_outlined),
            title: const Text('Cursos'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            //se não der certo este onTap abaixo, retornar ao código acima
            // onTap: () async {
            //   setState(() {
            //     coursesFuture = controller.getCourseList();
            //   });
            // },
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Professores'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text('Feriados'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HolidayPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
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
    );
  }
}
