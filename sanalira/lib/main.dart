import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanalira/config/theme.dart';
import 'package:sanalira/provider/bank_list_provider.dart';
import 'package:sanalira/provider/register_provider.dart';
import 'package:sanalira/view/main_view.dart';
import 'package:sanalira/view/register_view.dart';

bool autoLogin = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('Kullanıcı offline!');
      autoLogin = false;
    } else {
      print('Kullanıcı online, Otomatik giriş!');
      autoLogin = true;
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BankListProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sanalira',
        theme: CustomTheme.lightTheme,
        home: autoLogin ? MainView() : RegisterView(),
      ),
    );
  }
}
