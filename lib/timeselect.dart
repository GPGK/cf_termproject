import 'package:cf_termproject/main.dart';
import 'package:cf_termproject/user_info.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';
import 'mypage.dart';
import 'reservepage.dart';


class MyTime{
  static String set_Day = '';


  static String start_Hour = '0';
  static bool select_stHour = false;

  static String end_Hour = '0';
  static bool select_edHour = false;

  static String start_Min = '0';
  static bool select_stMin = false;

  static String end_Min = '0';
  static bool select_edMin = false;

}



///////////////////////////////////////////////////

void main() => runApp(TimeSelect());

class TimeSelect extends StatefulWidget {
  const TimeSelect({Key? key}) : super(key: key);

  @override
  State<TimeSelect> createState() => _TimeSelectState();
}


class _TimeSelectState extends State<TimeSelect> {

  var info;

  ////////////////////////////////////////////////

  final GlobalKey<AnimatedListState> _animatedlistKey = GlobalKey<AnimatedListState>();
  List<String> _items = [
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
  ];

  ////////////////////////////////////////////////////

  final List<String> _valueList_Hour = [
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12',
    '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'];

  final List<String> _valueList_Minute = [
    '0', '10', '20', '30', '40', '50', '60'
  ];
  String _selectedValue_Hour_S = '0';
  String _selectedValue_Minute_S = '0';

  String _selectedValue_Hour_E = '0';
  String _selectedValue_Minute_E = '0';


  ////////////////////////////////////////////////

  String result = '';
  bool dDay_0 = true;
  bool dDay_1 = false;
  bool dDay_2 = false;
  late List<bool> isSelected;

  MyTime myTime = MyTime();

  void initState(){
    isSelected = [dDay_0, dDay_1, dDay_2];
    super.initState();
  }

  void selectToggle(value) {
    if (value == 0) {
      MyTime.set_Day = getToday(DaySelect: value);

      dDay_0 = true;
      dDay_1 = false;
      dDay_2 = false;
    }
    else if (value == 1) {
      MyTime.set_Day = getToday(DaySelect: value);

      dDay_0 = false;
      dDay_1 = true;
      dDay_2 = false;
    }
    else if (value == 2) {
      MyTime.set_Day = getToday(DaySelect: value);

      dDay_0 = false;
      dDay_1 = false;
      dDay_2 = true;
    }
    setState(() {
      isSelected = [dDay_0, dDay_1, dDay_2];
    });
  }

  ////////////////////////////////////////////////

  String calculateTimeDiffer(
      {required String S_H, required String S_M,
        required String E_H, required String E_M}) {

    int s_h = int.parse(S_H);
    int s_m = int.parse(S_M);
    int e_h = int.parse(E_H);
    int e_m = int.parse(E_M);

    int diff = (e_h * 60 + e_m * 1) - (s_h * 60 + s_m * 1);
    int diff_hr = diff ~/ 60;
    int diff_min = diff % 60;

    if(MyTime.select_edHour == true || MyTime.select_edMin == true) {
      if(diff <= 0){
        return '시간을 다시 설정해주세요.';
      }

    }

    else {
      return '시간 계산중 . . . ';
    }


   // if(S_H == '0' && S_M == '0' && E_H == '0' && E_M == '0' ) {
   //   return '시간 계산중 . . . ';
   // }


    return '총 예약시간:    ${diff_hr}시간  ${diff_min}분';
  }
  
  //int daySelect = 0;

  String getToday({required int DaySelect}) {
    var now = DateTime.now();
    DateTime day = DateTime(now.year, now.month, now.day + DaySelect);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(day);
    return strToday;
  }

  String getMName({required int index}) {
    if(index == 0)
      return '[세탁기 1]';
    if(index == 1)
      return '[세탁기 2]';
    if(index == 2)
      return '[세탁기 3]';
    if(index == 3)
      return '[세탁기 4]';
    if(index == 4)
      return '[건조기 1]';
    else
      return '[건조기 2]';
  }

  String getComplete ({required String day, required String S_H, required String S_M,
    required String E_H, required String E_M}) {


    return
  }


  ///////////////////////////////////////////////


  @override
  Widget build(BuildContext context) {

    info = Provider.of<UserInfo>(context, listen: true);

    MyTime.set_Day = getToday(DaySelect: 0);


    return Scaffold(
      appBar: AppBar(
        title: Text('${info.getDormitory()}동 ${getMName(index: info.getMacNumber())} 시간 예약 페이지'),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("TestName"),
              accountEmail: const Text("TestAccount@kumoh.ac.kr"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: null,
              ),
              decoration: BoxDecoration(
                color: Colors.blue[300],
              ),
            ),
            ListTile(
              title: const Text("HOME"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => new HomePage())
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: const Text("마이페이지"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => new MyPage())
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: const Text("문의/건의"),
              onTap: () {
                print("");
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '< 예약시 주의사항 >\n\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        TextSpan(
                          text: '한번에 최대 3시간까지만 예약 가능합니다.\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        TextSpan(
                          text: '하루에 한번만 예약이 가능합니다.\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      isSelected: isSelected,
                      onPressed: selectToggle,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Day\n(${getToday(DaySelect: 0)})',
                            //style: TextStyle(fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Day +1\n(${getToday(DaySelect: 1)})',
                            //style: TextStyle(fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Day +2\n(${getToday(DaySelect: 2)})',
                            //style: TextStyle(fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            Flexible(
              flex: 8,
              fit: FlexFit.tight,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("예약시작 시간:         ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: DropdownButton(
                              isExpanded: true,
                              value: _selectedValue_Hour_S,
                              items: _valueList_Hour.map(
                                    (value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? value){
                                setState(() {
                                  _selectedValue_Hour_S = value!;
                                  MyTime.select_stHour = true;
                                  MyTime.start_Hour = value;
                                });
                              },
                            ),
                          ),

                          const Text("h  :          ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: DropdownButton(
                              isExpanded: true,
                              value: _selectedValue_Minute_S,
                              items: _valueList_Minute.map(
                                    (value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? value){
                                setState(() {
                                  _selectedValue_Minute_S = value!;
                                  MyTime.select_stMin = true;
                                  MyTime.start_Min = value;
                                });
                              },
                            ),
                          ),
                          const Text("min",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),
                    const Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text('   ~',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          const Text("예약종료 시간:         ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: DropdownButton(
                              isExpanded: true,
                              value: _selectedValue_Hour_E,
                              items: _valueList_Hour.map(
                                    (value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? value){
                                setState(() {
                                  _selectedValue_Hour_E = value!;
                                  MyTime.select_edHour = true;
                                  MyTime.end_Hour = value;
                                });
                              },
                            ),
                          ),

                          const Text("h  :          ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: DropdownButton(
                              isExpanded: true,
                              value: _selectedValue_Minute_E,
                              items: _valueList_Minute.map(
                                    (value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? value){
                                setState(() {
                                  _selectedValue_Minute_E = value!;
                                  MyTime.select_edMin = true;
                                  MyTime.end_Min = value;
                                });
                              },
                            ),
                          ),
                          const Text("min",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Flexible(
                      flex:2,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(calculateTimeDiffer(
                              S_H: _selectedValue_Hour_S, S_M: _selectedValue_Minute_S,
                              E_H: _selectedValue_Hour_E, E_M: _selectedValue_Minute_E))
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: (){

                              },
                              child: const Text('예약하기')),
                          const Text('    '),
                          ElevatedButton(
                              onPressed: (){},
                              child: const Text('예약취소')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text('<   예약 현황    >',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.black),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),

              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: (){},
                        child: const Text('새로고침')),
                    const Text('         '),
                  ],
                ),
              ),
              ],
            ),

            Flexible(
              flex: 10,
              fit: FlexFit.tight,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: AnimatedList(
                  key: _animatedlistKey,
                  initialItemCount: _items.length,
                  itemBuilder: (context, index, animation) {
                    return _buildItem(_items[index], animation, index);
                    },
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildItem(String item, Animation<double> animation, int index) {
    return SlideTransition(
      position: animation.drive(Tween(begin: const Offset(-1.0,0.0), end: const Offset(0.0,0.0))),
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(
            item,
            style: const TextStyle(
              fontWeight: FontWeight.w600
            ),
          ),
          subtitle: const Text('lorem ipsum dolor...'),
          leading: const CircleAvatar(backgroundColor: Colors.amber,),
        ),
      ),
    );
  }
}
