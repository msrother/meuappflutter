import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meuapp/controller/holiday_controller.dart';
import 'package:meuapp/model/holiday_model.dart';

class HolidayPage extends StatefulWidget {
  HolidayPage({super.key});

  @override
  _HolidayPageState createState() => _HolidayPageState();
}

class _HolidayPageState extends State<HolidayPage> {
  final HolidayController _controller = HolidayController();

  @override
  void initState() {
    super.initState();
    _controller.loadHolidays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feriados 2023'),
      ),
      body: ValueListenableBuilder<List<HolidayEntity>>(
        valueListenable: _controller.holidaysNotifier,
        builder: (context, holidays, _) {
          return holidays.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Row(
                  children: [
                    Expanded(
                      flex:
                          1, //Quantidade de flex para distribuir o espaço entre as colunas
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            0.9 *
                            0.5, // 90% da tela, dividido por 2
                        child: ListView.builder(
                          itemCount: holidays.length ~/
                              2, // Metade dos feriados em uma coluna
                          itemBuilder: (context, index) {
                            final holiday = holidays[index];
                            final formattedDate =
                                DateFormat('dd/MM/yyyy').format(holiday.date);

                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.all(8),
                              child: ListTile(
                                title: Text(
                                  holiday.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(formattedDate),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            0.9 *
                            0.5, // 90% da tela, dividido por 2
                        child: ListView.builder(
                          itemCount: holidays.length ~/
                              2, // Metade dos feriados na outra coluna
                          itemBuilder: (context, index) {
                            final holiday =
                                holidays[index + holidays.length ~/ 2];
                            final formattedDate =
                                DateFormat('dd/MM/yyyy').format(holiday.date);

                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.all(8),
                              child: ListTile(
                                title: Text(
                                  holiday.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(formattedDate),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
