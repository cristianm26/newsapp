import 'package:flutter/material.dart';
import 'package:newsapp/src/screens/tabs_screen.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> NewsService()),
      ],
      child: MaterialApp(
        title: 'Noticias App',
        theme: miTema,
        debugShowCheckedModeBanner: false,
        home: const TabsScreen(),
      ),
    );
  }
}
