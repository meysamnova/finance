import 'dart:math';
import 'package:finance/main.dart';
import 'package:flutter/material.dart';
import 'package:finance/screens/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/money.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});
  static TextEditingController descriptionTextEditingController =
      TextEditingController();
  static TextEditingController priceTextEditingController =
      TextEditingController();
  static int groupId = 0;
  static int indexedit = 0;
  static bool isEditing = false;
  static String date = 'تاریخ';

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          const Header(),
          CreateTextField(
            hintText: 'توضیحات',
            controller: CreateScreen.descriptionTextEditingController,
          ),
          CreateTextField(
            hintText: 'مبلغ',
            type: TextInputType.number,
            controller: CreateScreen.priceTextEditingController,
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Spacer(),
              CreateRadioBottom(
                value: 1,
                title: 'دریافتی',
                groupValue: CreateScreen.groupId,
                onChanged: (value) {
                  setState(() {
                    CreateScreen.groupId = value!;
                  });
                },
              ),
              const Spacer(),
              CreateRadioBottom(
                value: 2,
                title: 'پرداختی',
                groupValue: CreateScreen.groupId,
                onChanged: (value) {
                  setState(() {
                    CreateScreen.groupId = value!;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                  onPressed: () async {
                    var pickedData = await showPersianDatePicker(
                        context: context,
                        initialDate: Jalali.now(),
                        firstDate: Jalali(1402),
                        lastDate: Jalali(1500));
                    setState(() {
                      String day = pickedData!.day.toString().length ==1?'0${pickedData.day.toString()}': pickedData.day  .toString();
                      String month = pickedData.month.toString().length ==1?'0${pickedData.month.toString()}': pickedData.month.toString();
                      String year = pickedData.year.toString();
                     
                      CreateScreen.date ='$year/$month/$day';
                    });
                  },
                  child: Text(CreateScreen.date)),
              const SizedBox(width: 15)
            ],
          ),
          Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
              child: ElevatedButton(
                  onPressed: () {
                    Money item = Money(
                        id: Random().nextInt(999),
                        toman:
                            CreateScreen.priceTextEditingController.text == ''
                                ? '---'
                                : 'تومان ',
                        title:
                            CreateScreen.descriptionTextEditingController.text,
                        date: CreateScreen.date,
                        price: CreateScreen.priceTextEditingController.text,
                        isRecived: CreateScreen.groupId == 1 ? true : false);
                      if (CreateScreen.descriptionTextEditingController.text ==
                              '' &&
                          CreateScreen.priceTextEditingController.text == '') {
                    } else if (CreateScreen.isEditing) {
                      // HomeScreen.moneyList[CreateScreen.indexedit] = item;
                      // hiveBox.putAt(CreateScreen.indexedit, item);
                      int findex = 0;
                      MainApp.getData();
                      for (int i = 0; i < hiveBox.values.length; i++) {
                        if (hiveBox.values.elementAt(i).id ==
                            CreateScreen.indexedit) {
                          findex = i;
                        }
                      }
                      hiveBox.putAt(findex, item);
                    } else {
                      // HomeScreen.moneyList.add(item);
                      hiveBox.add(item);
                    }
                    Navigator.pop(context);
                  },
                  child: CreateScreen.isEditing
                      ? const Text('ویرایش')
                      : const Text('اضافه کردن')))
        ]),
      ),
    )));
  }
}

//! Header
class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back)),
      const Spacer(),
      CreateScreen.isEditing
          ? const Text('ویرایش تراکنش')
          : const Text('تراکنش جدید'),
      const SizedBox(width: 8),
    ]);
  }
}

//! RadioBottom
class CreateRadioBottom extends StatelessWidget {
  final String title;
  final int value;
  final int groupValue;
  final Function(int?) onChanged;
  const CreateRadioBottom({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 00),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(value: value, groupValue: groupValue, onChanged: onChanged),
          Text(title)
        ],
      ),
    );
  }
}

//! TextField
class CreateTextField extends StatelessWidget {
  final String hintText;
  final TextInputType type;
  final TextEditingController controller;
  const CreateTextField(
      {Key? key,
      required this.hintText,
      this.type = TextInputType.text,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextField(
        controller: controller,
        keyboardType: type,
        cursorColor: kpurplecolor,
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kpurplecolor)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kpurplecolor)),
            hintText: hintText,
            hintTextDirection: TextDirection.rtl),
      ),
    );
  }
}
