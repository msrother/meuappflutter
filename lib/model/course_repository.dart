import 'dart:convert';
import 'package:meuapp/core/constantes.dart';
import 'package:meuapp/model/course_model.dart';
import 'package:http/http.dart' as http;

class CourseRepository {
  final Uri url = Uri.parse('$urlBaseApi/courses');

  //busca a lista de todos cursos na api
  Future<List<CourseEntity>> getAll() async {
    List<CourseEntity> coursesList = [];
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //converte de json para uma lista
      final json = jsonDecode(response.body) as List;
      for (var course in json) {
        coursesList.add(CourseEntity.fromJson(course));
      }
    }
    return coursesList;
  }

  deleteCourse(String id) async {
    final url = '$urlBaseApi/courses/$id';
    var response = await http.delete(Uri.parse(url));
    if (response.statusCode != 200) {
      throw 'Problemas ao excluir curso';
    }
  }

  postNewCourse(CourseEntity courseEntity) async {
    final jsonCourse = jsonEncode(CourseEntity.toJson(courseEntity));
    var response = await http.post(url, body: jsonCourse);
    if (response.statusCode != 201) {
      throw 'Problemas ao inserir curso';
    }
  }

  putUpdateCourse(CourseEntity courseEntity) async {
    final url = '$urlBaseApi/courses/${courseEntity.id}';
    final jsonCourse = jsonEncode(CourseEntity.toJson(courseEntity));
    var response = await http.put(Uri.parse(url), body: jsonCourse);
    if (response.statusCode != 200) {
      throw 'Problemas ao atualizar curso';
    }
  }
}
