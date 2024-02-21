import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:randomic/add_words.dart';
import 'package:randomic/all_words.dart';
import 'package:randomic/bloc/get_word/get_word_bloc.dart';
import 'package:randomic/bloc/vocabluary/getvocabluary_bloc.dart';
import 'package:randomic/essetianal.dart';
import 'package:randomic/radn_words.dart';
import 'package:randomic/services/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  IsarService().openDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetWordBloc()..add(GetAllEvent()),
        ),
        BlocProvider(
          create: (context) => GetvocabluaryBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colors.transparent,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: ''),
      ),
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
  int index = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    AllWordsScreen(),
    RandomWordsScreen(),
    EssetianalPage(),
    AddWordsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 7, 67, 116),
          title: Center(
            child: Text(widget.title,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20)),
          ),
        ),
        body: _widgetOptions.elementAt(index),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 7, 67, 116),
          selectedLabelStyle: GoogleFonts.poppins(
              color: Colors.red, fontWeight: FontWeight.w400, fontSize: 13),
          unselectedLabelStyle: GoogleFonts.poppins(
              color: Colors.red, fontWeight: FontWeight.w400, fontSize: 12),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 7, 67, 116),
              icon: ImageIcon(
                AssetImage("assets/images/house.png"),
              ),
              label: ("Words"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 7, 67, 116),
              icon: ImageIcon(
                AssetImage("assets/images/grid.png"),
              ),
              label: ("Random"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 7, 67, 116),
              icon: Icon(Icons.book),
              label: ("Essetianal"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 7, 67, 116),
              icon: ImageIcon(
                AssetImage("assets/images/add.png"),
              ),
              label: ("Add"),
            )
          ],
          currentIndex: index,
          onTap: (int i) {
            setState(() {
              index = i;
            });
          },
          unselectedItemColor: Colors.white.withOpacity(0.5),
          fixedColor: Colors.white,
        ),
      ),
    );
  }
}
