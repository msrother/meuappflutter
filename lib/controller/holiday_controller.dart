import 'package:flutter/material.dart';
import 'package:meuapp/model/holiday_model.dart';
import 'package:meuapp/repository/holiday_repository.dart';

class HolidayController {
  final HolidayRepository _repository = HolidayRepository();
  final holidaysNotifier = ValueNotifier<List<HolidayEntity>>([]);

  Future<void> loadHolidays() async {
    try {
      final holidays = await _repository.getHolidays();
      holidaysNotifier.value = holidays;
    } catch (error) {
      print('Erro ao carregar feriados: $error');
    }
  }
}
