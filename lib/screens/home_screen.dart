import 'package:finance/utils/calculate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:finance/screens/create_screen.dart';
import '../main.dart';
import '../models/money.dart';
import 'package:finance/utils/extension.dart';
import 'constant.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static List<Money> moneyList = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MainApp mainapp = const MainApp();
  final TextEditingController textEC = TextEditingController();
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');
  @override
  void initState() {
    MainApp.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(children: [
            headerWidget(),
            Expanded(
              child: HomeScreen.moneyList.isEmpty
                  ? const EmptyWidget()
                  : ListView.builder(
                      itemCount: HomeScreen.moneyList.length,
                      itemBuilder: (context, index) => GestureDetector(
                            child: ListTileTransaction(index: index),
                            //! EDIT
                            onDoubleTap: () {
                              CreateScreen.date =
                                  HomeScreen.moneyList[index].date;
                              // CreateScreen.indexedit = index;
                              CreateScreen.indexedit =
                                  HomeScreen.moneyList[index].id;

                              CreateScreen.isEditing = true;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateScreen())).then((value) {
                                MainApp.getData();
                                setState(() {});
                              });
                              CreateScreen.descriptionTextEditingController
                                  .text = HomeScreen.moneyList[index].title;
                              CreateScreen.priceTextEditingController.text =
                                  HomeScreen.moneyList[index].price;
                              CreateScreen.groupId =
                                  HomeScreen.moneyList[index].isRecived ? 1 : 2;
                            },
                            //! DELETE
                            onLongPress: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                          'آیا از حذف این گزینه مطمئن هستید؟'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('خیر')),
                                        TextButton(
                                            onPressed: () {
                                              hiveBox.deleteAt(index);
                                              MainApp.getData();
                                              setState(() {
                                                // HomeScreen.moneyList.removeAt(index);
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text('بله'))
                                      ],
                                    )),
                          )),
            )
          ]),
        ),
        //! FAB
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            CreateScreen.date = Calculate.toDay();
            CreateScreen.isEditing = false;
            CreateScreen.groupId = 2;
            CreateScreen.descriptionTextEditingController.text = '';
            CreateScreen.priceTextEditingController.text = '';
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateScreen())).then((value) {
              MainApp.getData();
              setState(() {});
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  //!Header
  Widget headerWidget() {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Row(
          children: [
            Expanded(
              child: SearchBarAnimation(
                onCollapseComplete: () {
                  MainApp.getData();
                  textEC.text = '';
                  setState(() {});
                },
                isOriginalAnimation: false,
                textEditingController: textEC,
                buttonWidget: const Icon(Icons.search),
                secondaryButtonWidget: const Icon(Icons.arrow_back),
                trailingWidget: const Icon(Icons.search),
                hintText: '...جستجو کنید',
                buttonElevation: 0,
                buttonBorderColour: Colors.transparent,
                onFieldSubmitted: (String text) {
                  List<Money> result = hiveBox.values
                      .where((element) =>
                          element.title.contains(text) ||
                          element.date.contains(text))
                      .toList();
                  HomeScreen.moneyList.clear();
                  setState(() {
                    for (var element in result) {
                      HomeScreen.moneyList.add(element);
                    }
                  });
                },
              ),
            ),
             Text('تراکنش ها',
                style: TextStyle(
                    fontSize: ScreenSize(context).width() < 990
                        ? 16
                        : ScreenSize(context).width() * 0.015))
          ],
        ));
  }
}

//!ListTileTransaction
class ListTileTransaction extends StatelessWidget {
  final int index;

  const ListTileTransaction({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Text(HomeScreen.moneyList[index].title),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(children: [
                Text(HomeScreen.moneyList[index].toman),
                Text(HomeScreen.moneyList[index].price)
              ]),
              Text(HomeScreen.moneyList[index].date)
            ],
          ),
          const SizedBox(width: 10),
          SizedBox(
              width: 12,
              child: HomeScreen.moneyList[index].isRecived
                  ? const Icon(Icons.add, color: kGreenColor)
                  : const Icon(Icons.remove, color: kRedColor)),
        ],
      ),
    );
  }
}

//!EmptyWidget
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Spacer(),
      SvgPicture.asset(
        'assets/images/empty-page.svg',
        height: 100,
        width: 100,
      ),
      const Text('! تراکنشی موجود نیست'),
      const Spacer(),
    ]);
  }
}
