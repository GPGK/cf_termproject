import 'package:cf_termproject/timeselect.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:provider/provider.dart';
import 'mypage.dart';
import 'reservepage.dart';
import 'timeselect.dart';
import 'user_info.dart';

class MyIcons{
  static const IconData local_laundry_service = const IconData(
      0xe398,
      fontFamily: 'MaterialIcons'
  );

  static const IconData brightness = const IconData(
      0xf0575,
      fontFamily: 'MaterialIcons'
  );

  static IconData MuchineIcon({required int Index}) {
    Index = Index + 1;
    IconData muchineIcon =  local_laundry_service;
    if(Index > 4) {
      muchineIcon = brightness;
      return muchineIcon;
    }
    return muchineIcon;
  }
}



String MuchineName({required int Index}) {
  Index = Index + 1;
  String muchineName = '세탁기 ${Index}';
  if(Index > 4) {
    muchineName = '건조기 ${Index - 4}';
    return muchineName;
  }
  return muchineName;
}


////////////////////////////////////////////////////////////////////

//void main() {
//  runApp(const HomePage());
//}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Washing Machine Clicker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'HomePage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var info;


  @override
  Widget build(BuildContext context) {
    final List<String> M_Name = <String>[
      '세탁기 1', '세탁기 2', '세탁기 3', '세탁기 4', '건조기 1', '건조기 2'];
    final List<String> Time_S = <String>[
      '22-11-09 06:00', '22-11-09 08:00', '22-11-09 10:00','22-11-09 12:00', '미사용중', '미사용중'];
    final List<String> Time_E = <String>[
      '22-11-09 08:00', '22-11-09 10:00', '22-11-09 12:00','22-11-09 14:00', '미사용중', '미사용중'];


    info = Provider.of<UserInfo>(context, listen: true);


    // <<<<< 더미 >>>>>>
    info.putDormitory('오름');

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => new HomePage())
                  );
                },
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: const Text("마이페이지"),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
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
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text('< ${info.getDormitory()}동 예약 선택페이지 >', textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
              ),

              Flexible(
                flex: 8,
                fit: FlexFit.tight,
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        //fit: FlexFit.tight,
                        child: Text(' <  기기를 선택해주세요.  >'),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 3,
                                crossAxisSpacing: 3,
                                childAspectRatio: 3/6,
                            ),
                              itemCount: 6,
                              itemBuilder: (BuildContext context, int index){
                                return Card(
                                  margin: const EdgeInsets.all(8),
                                  elevation: 2,
                                  child: GridTile(
                                    //header: GridTileBar(
                                    //  backgroundColor: Colors.black26,
                                    //  title: const Text('header'),
                                    //  subtitle: Text('Top'),
                                    //),
                                    footer: Container(
                                      height: 40,
                                      child: GridTileBar(
                                        backgroundColor: Colors.black38,
                                        title: Text(
                                          MuchineName(Index: index),
                                          overflow: TextOverflow.ellipsis,

                                        ),
                                        //subtitle: Text('bottom'),
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(MyIcons.MuchineIcon(Index: index), size: 50,),
                                      onPressed: (){
                                        info.putMacNumber(index);
                                        print(index);
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => TimeSelect())
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
                  child: Column(
                    children: <Widget>[
                      const Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text('< 기기 정보 >\n',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(2),
                          itemCount: M_Name.length,
                          itemBuilder: (BuildContext context, int index){
                            return _buildItem(M_Name[index],Time_S[index], Time_E[index] ,index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildItem(String m_name, String time_s, String time_e, int index) {

    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(
          m_name,
          style: const TextStyle(
              fontWeight: FontWeight.w600
          ),
        ),
        subtitle: Text('${time_s}   ~   ${time_e}'),
        leading: Icon(
          MyIcons.MuchineIcon(Index: index),
        ),
      ),
    );
  }
}