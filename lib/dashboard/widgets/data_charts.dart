import 'dart:math';

import 'package:adminapp/dashboard/widgets/indicator_chart.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DataItem {
  final double number;
  final String name;

  DataItem(this.number, this.name);
}

class BarChartNationality extends StatefulWidget {
  final List users;
  const BarChartNationality({Key? key, required this.users}) : super(key: key);

  @override
  State<BarChartNationality> createState() => _BarChartNationalityState();
}

class _BarChartNationalityState extends State<BarChartNationality> {
  List nationalityUsers = [];
  List<double> numberUser = [];
  // List<String> titles = [];
  // List<double> numberUser = [];

  @override
  Widget build(BuildContext context) {
    for (var element in widget.users) {
      nationalityUsers.add(element.nationality);
    }
    Map<String, dynamic> mapNationality = {};

    for (var element in nationalityUsers) {
      if (!mapNationality.containsKey(element)) {
        mapNationality[element] = 1;
      } else {
        mapNationality[element] += 1;
      }
    }

    List<DataItem> listNationality = [];

    for (var e in mapNationality.entries) {
      listNationality.add(DataItem(e.value, e.key));
    }
    for (var e in listNationality) {
      numberUser.add(e.number);
    }

    Widget getTitles(double values, TitleMeta meta) {
      List<String> titles = [];

      for (var e in listNationality) {
        titles.add(e.name);
      }

      Widget text = Text(titles[values.toInt()],
          style: const TextStyle(
            color: Color(0xff7589a2),
          ));
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: text,
      );
    }

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Users Nationality'),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        backgroundColor: Colors.white,
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(
                            show: true,
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        alignment: BarChartAlignment.spaceAround,
                        // maxY: 5,
                        maxY: numberUser.reduce(max) + 3,
                        // groupsSpace: 12,
                        titlesData: FlTitlesData(
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 40.0,
                                showTitles: true,
                                getTitlesWidget: getTitles,
                              ),
                            )),
                        barGroups: listNationality
                            .sublist(
                                0,
                                listNationality.length < 4
                                    ? listNationality.length
                                    : 4)
                            .map((e) => BarChartGroupData(
                                    x: listNationality.indexOf(e),
                                    barRods: [
                                      BarChartRodData(
                                          borderRadius:
                                              BorderRadius.all(Radius.zero),
                                          toY: e.number,
                                          color: listNationality.indexOf(e) == 0
                                              ? Colors.red
                                              : listNationality.indexOf(e) == 1
                                                  ? Colors.yellow
                                                  : listNationality
                                                              .indexOf(e) ==
                                                          2
                                                      ? Colors.green
                                                      : listNationality
                                                                  .indexOf(e) ==
                                                              3
                                                          ? Colors.blue
                                                          : listNationality
                                                                      .indexOf(
                                                                          e) ==
                                                                  4
                                                              ? Colors.amber
                                                              : Colors
                                                                  .deepPurple)
                                    ]))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartServices extends StatefulWidget {
  final List<ServiceDetails> services;
  const BarChartServices({Key? key, required this.services}) : super(key: key);

  @override
  State<BarChartServices> createState() => _BarChartServicesState();
}

class _BarChartServicesState extends State<BarChartServices> {
  List serviceCompleteList = [];
  List euVisaList = [];
  List businessServiceList = [];
  List<double> numberUser = [];

  @override
  Widget build(BuildContext context) {
    for (var element in widget.services) {
      serviceCompleteList.add(element.serviceName);
    }
    Map<String, dynamic> mapServices = {};

    for (var element in serviceCompleteList) {
      if (!mapServices.containsKey(element)) {
        mapServices[element] = 1;
      } else {
        mapServices[element] += 1;
      }
    }

    List<DataItem> listServices = [];

    for (var e in mapServices.entries) {
      listServices.add(DataItem(e.value, e.key));
    }
    for (var e in listServices) {
      numberUser.add(e.number);
    }

    Widget getTitles(double values, TitleMeta meta) {
      List<String> titles = [];

      for (var e in listServices) {
        titles.add(e.name);
        numberUser.add(e.number);
      }

      Widget text = Text(titles[values.toInt()],
          style: const TextStyle(
            color: Color(0xff7589a2),
          ));
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: text,
      );
    }

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Main Services'),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        backgroundColor: Colors.white,
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(
                            show: true,
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        alignment: BarChartAlignment.spaceAround,
                        // maxY: 5,
                        maxY: numberUser.reduce(max) + 3,
                        // groupsSpace: 12,
                        titlesData: FlTitlesData(
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 40.0,
                                showTitles: true,
                                getTitlesWidget: getTitles,
                              ),
                            )),
                        barGroups: listServices
                            .map((e) => BarChartGroupData(
                                    x: listServices.indexOf(e),
                                    barRods: [
                                      BarChartRodData(
                                        toY: e.number,
                                      )
                                    ]))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PieChartServices extends StatefulWidget {
  final List<ServiceDetails> services;
  const PieChartServices({Key? key, required this.services}) : super(key: key);

  @override
  State<PieChartServices> createState() => _PieChartServicesState();
}

class _PieChartServicesState extends State<PieChartServices> {
  List serviceCompleteList = [];
  List<DataItem> listServices = [];
  int touchedIndex = 0;

  getServiceList() {
    for (var element in widget.services) {
      serviceCompleteList.add(element.serviceName);
    }
    Map<String, dynamic> mapServices = {};

    for (var element in serviceCompleteList) {
      if (!mapServices.containsKey(element)) {
        mapServices[element] = 1;
      } else {
        mapServices[element] += 1;
      }
    }

    for (var e in mapServices.entries) {
      listServices.add(DataItem(e.value, e.key));
    }
  }

  @override
  Widget build(BuildContext context) {
    getServiceList();
    List<PieChartSectionData> getSections(int touchedIndex) {
      return listServices
          .sublist(0, listServices.length)
          .asMap()
          .map<int, PieChartSectionData>((index, data) {
            final value = PieChartSectionData(
                value: data.number,
                color: listServices.indexOf(data) == 0
                    ? Color(0xff0293ee)
                    : listServices.indexOf(data) == 1
                        ? Color(0xfff8b250)
                        : listServices.indexOf(data) == 2
                            ? Color(0xff845bef)
                            : Color(0xff13d38e),
                title: data.number.toString(),
                radius: 50,
                titleStyle: TextStyle(fontSize: 20, color: Colors.white));

            return MapEntry(index, value);
          })
          .values
          .toList();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Top Services requested'),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: getSections(touchedIndex),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible:
                      listServices.isNotEmpty && listServices[0].name.isNotEmpty
                          ? true
                          : false,
                  child: Indicator(
                    color: const Color(0xff0293ee),
                    text: listServices.isNotEmpty &&
                            listServices[0].name.isNotEmpty
                        ? listServices[0].name
                        : '',
                    size: 12,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Visibility(
                  visible:
                      listServices.length > 1 && listServices[1].name.isNotEmpty
                          ? true
                          : false,
                  child: Indicator(
                    color: Color(0xfff8b250),
                    text: listServices.length > 1 &&
                            listServices[1].name.isNotEmpty
                        ? listServices[1].name
                        : '',
                    size: 12,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),

                Visibility(
                  visible:
                      listServices.length > 2 && listServices[2].name.isNotEmpty
                          ? true
                          : false,
                  child: Indicator(
                    color: const Color(0xff845bef),
                    text: listServices.length > 2 &&
                            listServices[2].name.isNotEmpty
                        ? listServices[2].name
                        : '',
                    size: 12,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),

                Visibility(
                  visible:
                      listServices.length > 3 && listServices[3].name.isNotEmpty
                          ? true
                          : false,
                  child: Indicator(
                    color: const Color(0xff845bef),
                    text: listServices.length > 3 &&
                            listServices[3].name.isNotEmpty
                        ? listServices[3].name
                        : '',
                    size: 12,
                  ),
                ),
                // Visibility(
                //   visible: true,
                //   // listServices.length > 2 && listServices[3].name.isNotEmpty,
                //   child: Indicator(
                //     color: const Color(0xff13d38e),
                //     text: listServices[3].name,
                //     size: 12,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
