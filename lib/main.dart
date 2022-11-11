import 'package:cf_termproject/user_info.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';
import 'mypage.dart';
import 'reservepage.dart';
import 'timeselect.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserInfo>(
      create: (_) => UserInfo(),
      child: MaterialApp(
        title: 'Washing Machine Clicker',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/homepage',
        routes: {
          '/homepage': (context) => HomePage(),
          '/mypage': (context) => MyPage(),
          '/reservepage': (context) => ReservePage(),
          '/timeselect': (context) => TimeSelect(),
        },
      ),
    );
  }
}
