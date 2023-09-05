import 'package:finance/utils/calculate.dart';
import 'package:finance/utils/extension.dart';
import 'package:flutter/material.dart';

import '../widgets/chart_widget.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
                  child: Text('مدیریت تراکنش ها به تومان',
                      style: TextStyle(
                          fontSize: ScreenSize(context).width() < 1000
                              ? 14
                              : ScreenSize(context).width() * 0.02)),
                ),
                MoneyInfoWidget(
                    firsText: ' :پرداختی امروز',
                    firstPrice: Calculate.pToday().toString(),
                    secondPrice: Calculate.dToday().toString(),
                    secondText: ' :دریافتی امروز'),
                MoneyInfoWidget(
                    firsText: ' :پرداختی این ماه',
                    firstPrice: Calculate.pMonth().toString(),
                    secondPrice: Calculate.dMonth().toString(),
                    secondText: ' :دریافتی این ماه'),
                MoneyInfoWidget(
                    firsText: ' :پرداختی امسال',
                    firstPrice: Calculate.pYear().toString(),
                    secondPrice: Calculate.dYear().toString(),
                    secondText: ' :دریافتی امسال'),
                const Spacer(),
                Calculate.dYear() == 0 || Calculate.dYear() == 0
                    ? Container()
                    : Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        height: 200,
                        child: const BarChartWidget()),
                const Spacer()
              ],
            )),
      ),
    );
  }
}

class MoneyInfoWidget extends StatelessWidget {
  final String firsText;
  final String firstPrice;
  final String secondText;
  final String secondPrice;
  const MoneyInfoWidget(
      {super.key,
      required this.firsText,
      required this.secondText,
      required this.firstPrice,
      required this.secondPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        const Spacer(),
        Text(firstPrice,
            style: TextStyle(
                fontSize: ScreenSize(context).width() < 990
                    ? 14
                    : ScreenSize(context).width() * 0.015)),
        Text(firsText,
            style: TextStyle(
                fontSize: ScreenSize(context).width() < 990
                    ? 14
                    : ScreenSize(context).width() * 0.015)),
        const Spacer(),
        Text(secondPrice,
            style: TextStyle(
                fontSize: ScreenSize(context).width() < 990
                    ? 14
                    : ScreenSize(context).width() * 0.015)),
        Text(secondText,
            style: TextStyle(
                fontSize: ScreenSize(context).width() < 990
                    ? 14
                    : ScreenSize(context).width() * 0.015)),
      ]),
    );
  }
}
