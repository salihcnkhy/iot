import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:iot102/Login%20Screen/loginPageController.dart';
import 'package:iot102/ScreenSize.dart';

class MainPage extends StatelessWidget {
  List<charts.Series> seriesList;
  bool animate;

  Widget generalCap(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.1,
          color: Colors.black54,
        ),
      ),
      height: ScreenSize().screenHeightExcludingToolbar(context, dividedBy: 3),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20),
            height: ScreenSize()
                    .screenHeightExcludingToolbar(context, dividedBy: 3) /
                1.25,
            width: ScreenSize()
                    .screenHeightExcludingToolbar(context, dividedBy: 3) /
                1.25,
            child: CustomPaint(
              painter: StatusPainter(
                  storageLimit: user.storageCapacity,
                  storage: user.currentStorageCapacity),
              child: Center(
                child: Text(
                  user.currentStorageCapacity.toString() +
                      "/" +
                      user.storageCapacity.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(129, 129, 129, 1),
                      fontFamily: 'Arial'),
                ),
              ),
            ),
          ),
          /*  Column(
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height - 183) / 3,
                width: MediaQuery.of(context).size.width / 2,
                child: Container(
                  child: DashPatternLineChart.withSampleData(),
                ),
              ),
            ],
          ) */
        ],
      ),
    );
  }

  Widget currentCap(BuildContext context) {
    bool isSwitched = true;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.1,
          color: Colors.black54,
        ),
      ),
      height: ScreenSize().screenHeightExcludingToolbar(context, dividedBy: 3),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20),
                height: ScreenSize()
                        .screenHeightExcludingToolbar(context, dividedBy: 3) /
                    1.25,
                width: ScreenSize()
                        .screenHeightExcludingToolbar(context, dividedBy: 3) /
                    1.25,
                child: CustomPaint(
                  painter: StatusPainter(
                      storageLimit: user.containerCapacity,
                      storage: user.currentContainerCapacity),
                  child: Center(
                    child: Text(
                      user.currentContainerCapacity.toString() +
                          "/" +
                          user.containerCapacity.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(129, 129, 129, 1),
                          fontFamily: 'Arial'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget chartWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.1,
          color: Colors.black54,
        ),
      ),
      height: ScreenSize().screenHeightExcludingToolbar(context, dividedBy: 3),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: ScreenSize().screenWidth(context) - 20,
              child: charts.LineChart(_createSampleData()),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          generalCap(context),
          currentCap(context),
          chartWidget(context),
        ],
      ),
    );
  }

  static List<charts.Series<EatPerDay, int>> _createSampleData() {
    List<EatPerDay> data = new List();

    print(user.lastSevenDays);
    int count = 6;
    for (var a in user.lastSevenDays.reversed) {
      
      data.add(new EatPerDay(count--, a));
      if(count == -1){
        break;
      }
    }

    return [
      new charts.Series<EatPerDay, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (EatPerDay sales, _) => sales.day,
        measureFn: (EatPerDay sales, _) => sales.eatenFood,
        data: data,
      )
    ];
  }
}

class StatusPainter extends CustomPainter {
  int storageLimit;
  int storage;
  StatusPainter({@required this.storageLimit, @required this.storage}) {
    if (storage == 0) {
      storage = 10;
    }
  }

  final Paint bluePaint = Paint()
    ..color = Colors.blue[100]
    ..strokeWidth = 10
    ..style = PaintingStyle.stroke;

  final Paint arcPaint = Paint()
    ..color = Colors.blue[400]
    ..strokeWidth = 10.0
    ..style = PaintingStyle.stroke;

  final Paint innerArcPaint = Paint()
    ..color = Colors.brown[300]
    ..strokeWidth = 3.5
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    Path circle = Path()..addOval(rect);
    Path arcPath = Path()
      ..arcTo(
          rect.deflate(0), -pi / 2, arcPi(storageLimit, storage) - 0.001, true);
    Path innerArcPath = Path()
      ..arcTo(
          rect.deflate(5), -pi / 2, arcPi(storageLimit, storage) - 0.001, true);

    canvas.drawPath(circle, bluePaint);
    canvas.drawPath(arcPath, arcPaint);
    canvas.drawPath(innerArcPath, innerArcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double arcPi(int limit, int storage) {
    var piPerLim = 2 * pi / limit;

    return storage * piPerLim;
  }
}

class EatPerDay {
  final int day;
  final int eatenFood;
  //final charts.Color color;

  EatPerDay(this.day, this.eatenFood);
}
