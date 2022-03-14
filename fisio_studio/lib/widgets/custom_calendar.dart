import 'package:fisio_studio/controllers/gerarCoresTipoConsulta.dart';
import 'package:fisio_studio/controllers/getConsultas.dart';
import 'package:fisio_studio/controllers/getPalleteColorsTipoConsulta.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomCalendar extends StatefulWidget {
  final dynamic changePage;
  const CustomCalendar({Key? key, this.changePage}) : super(key: key);

  @override
  CustomCalendarState createState() => CustomCalendarState();
}

class CustomCalendarState extends State<CustomCalendar> {
  final CalendarController _calendarController = CalendarController();
  List<Meeting> meetings = <Meeting>[];
  bool isfreeze = true;

  void buildCalendarMarks() async {
    try {
      List<dynamic> scheduledAppointments =
          await getConsultas(url: 'getConsultas', ano: 2022);

      Map<String, String> palleteColors = await getPalleteColorsTipoConsulta();
      for (int i = 0; i < scheduledAppointments.length; i++) {
        DateTime dateTimeStart =
            DateTime.parse(scheduledAppointments[i]['inicio']);
        DateTime dateTimeEnd = DateTime.parse(scheduledAppointments[i]['fim']);

        if (!palleteColors.containsKey(scheduledAppointments[i]['tipo'])) {
          palleteColors = await getPalleteColorsTipoConsulta(
              tipoConsulta: scheduledAppointments[i]['tipo']);
        }

        setState(() {
          meetings.add(Meeting(
              scheduledAppointments[i]['funcionario']['nome'],
              dateTimeStart,
              dateTimeEnd,
              buildColor(palleteColors[scheduledAppointments[i]['tipo']] ??
                  '255,0,0,0'),
              false,
              cpfFuncionario: scheduledAppointments[i]['funcionario']['CPF'],
              nomeFuncionario: scheduledAppointments[i]['funcionario']['nome'],
              cpfPaciente: scheduledAppointments[i]['paciente']['CPF'],
              nomePaciente: scheduledAppointments[i]['paciente']['nome'],
              tipoConsulta: scheduledAppointments[i]['tipo'],
              id: scheduledAppointments[i]['id'],
              inicio: scheduledAppointments[i]['inicio'],
              fim: scheduledAppointments[i]['fim']));
        });
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() => isfreeze = false);
    }
  }

  // List<Meeting> _getDataSource() {
  //   final List<Meeting> meetings = <Meeting>[];
  //   final DateTime today = DateTime.now();
  //   final DateTime startTime =
  //       DateTime(today.year, today.month, today.day, 9, 0, 0);
  //   final DateTime endTime = startTime.add(const Duration(hours: 2));
  //   meetings.add(Meeting(
  //       'Conference', startTime, endTime, const Color(0xFF0F8644), false));
  //   return meetings;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    buildCalendarMarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: isfreeze,
      child: SfCalendar(
        view: CalendarView.month,
        timeSlotViewSettings: TimeSlotViewSettings(
          allDayPanelColor: Colors.blue.shade900,
          timeTextStyle: const TextStyle(fontSize: 15, color: Colors.grey),
        ),
        blackoutDates: <DateTime>[
          DateTime.now().add(const Duration(days: 2)),
          DateTime.now().add(const Duration(days: 3)),
          DateTime.now().add(const Duration(days: 6)),
          DateTime.now().add(const Duration(days: 7)),
        ],
        allowedViews: const [
          CalendarView.day,
          CalendarView.week,
          CalendarView.month,
          CalendarView.schedule
        ],
        //backgroundColor: Colors.black87,
        controller: _calendarController,
        onTap: (CalendarTapDetails details) {
          DateTime date = details.date!;
          dynamic appointments = details.appointments;
          CalendarElement view = details.targetElement;
          bool isAppointments = details.targetElement.name == 'appointment';

          print(
              'Selected: ${date}\nAppointments: ${appointments}\nview: ${view}');

          print('É um evento? ${isAppointments}');

          if (isAppointments) {
            print('Appointments');

            widget.changePage(7, kwd: {
              'cpfFuncionario': appointments![0].cpfFuncionario,
              'nomeFuncionario': appointments![0].nomeFuncionario,
              'nomePaciente': appointments![0].nomePaciente,
              'cpfPaciente': appointments![0].cpfPaciente,
              'tipoConsulta': appointments![0].tipoConsulta,
              'id': appointments![0].id,
              'inicio': appointments![0].inicio,
              'fim': appointments![0].fim
              // 'descConsulta': appointments,
              // 'descPaciente': appointments,
            });
          }

          if (_calendarController.view!.index != 0)
            _calendarController.view = CalendarView.day;
          else {
            print('Escolher horário!');
            widget.changePage(6, kwd: {'dateTime': date});
          }
        },
        cellBorderColor: Colors.white,
        blackoutDatesTextStyle: TextStyle(color: Colors.red),
        dataSource: MeetingDataSource(meetings),
        specialRegions: _getTimeRegions(),
        //backgroundColor: Colors.black87,
        viewHeaderStyle: ViewHeaderStyle(
            backgroundColor: Colors.blue.shade900,
            dayTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            dateTextStyle: const TextStyle(color: Colors.white, fontSize: 25)),

        headerStyle: CalendarHeaderStyle(
            textStyle: const TextStyle(color: Colors.white, fontSize: 26),
            textAlign: TextAlign.center,
            backgroundColor: Colors.blue.shade900),
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
    ));
  }

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];
    final DateTime today = DateTime.now();
    regions.add(TimeRegion(
      startTime: DateTime(2022, 1, 1, 00, 0, 0),
      endTime: DateTime(2022, 3, 1, 0, 0, 0),
      recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=SAT,SUN',
      color: const Color(0xffbD3D3D3),
    ));

    return regions;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,
      {this.cpfFuncionario = '',
      this.cpfPaciente = '',
      this.descConsulta = '',
      this.descPaciente = '',
      this.nomeFuncionario = '',
      this.nomePaciente = '',
      this.tipoConsulta = '',
      this.id = -1,
      this.inicio = '',
      this.fim = ''});

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

  String cpfFuncionario;
  String cpfPaciente;
  String descConsulta;
  String descPaciente;
  String tipoConsulta;
  String nomeFuncionario;
  String nomePaciente;
  String inicio;
  String fim;
  int id;
}
