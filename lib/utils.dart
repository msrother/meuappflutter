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
