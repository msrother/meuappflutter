import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meuapp/model/holiday_model.dart';

class HolidayRepository {
  Future<List<HolidayEntity>> getHolidays() async {
    final Uri url = Uri.parse('https://brasilapi.com.br/api/feriados/v1/2023');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<HolidayEntity> holidays = jsonData
          .map((data) => HolidayEntity(
                name: data['name'],
                date: DateTime.parse(data['date']),
              ))
          .toList();

      return holidays;
    } else {
      throw Exception('Erro ao carregar feriados: ${response.statusCode}');
    }
  }
}
