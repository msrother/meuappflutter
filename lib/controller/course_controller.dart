import 'package:meuapp/model/course_model.dart';
import 'package:meuapp/repository/course_repository.dart';

class CourseController {
  CourseRepository repository = CourseRepository();

// função para pegar a 1 letra da primeira palavra e a 1 letra da última palavra
  String getFirstLetter(String? name) {
    if (name == null || name.isEmpty) {
      return '';
    }

    List<String> nameParts = name.split(' ');
    if (nameParts.length < 2) {
      return nameParts[0][0].toUpperCase();
    }

    String firstNameInitial = nameParts[0][0].toUpperCase();
    String lastNameInitial = nameParts.last[0].toUpperCase();

    return firstNameInitial + lastNameInitial;
  }

  Future<List<CourseEntity>> getCourseList() async {
    List<CourseEntity> coursesList = [];
    coursesList = await repository.getAll();
    return coursesList;
  }

  deleteCourse(String id) async {
    try {
      await repository.deleteCourse(id);
    } catch (e) {
      rethrow;
    }
  }

  postNewCourse(CourseEntity courseEntity) async {
    try {
      await repository.postNewCourse(courseEntity);
    } catch (e) {
      rethrow;
    }
  }
}
