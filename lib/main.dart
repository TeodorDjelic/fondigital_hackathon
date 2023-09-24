import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';
import 'Game.dart';
import 'dart:async';

late Game myWidget;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  WidgetsFlutterBinding.ensureInitialized();

  ImageMap _imageMap = ImageMap();

  await _imageMap.load(<String>['assets/apple.png', 'assets/car.png', 'assets/coffe.png', 'assets/chips.png', 'assets/fuel_can.png']);

  myWidget = Game(imageMap: _imageMap);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF083694)),
        useMaterial3: true,
      ),
      home: const HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  var collapsed = true;
  var endGame = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return RawKeyboardListener(
    //   autofocus: true,
    //   focusNode: FocusNode(),
    //
    //   onKey: (e) {
    //     if(e.isKeyPressed(LogicalKeyboardKey(0x00100000009))){
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => TocenjeZavrsenoPage()));
    //     }
    //   },
    //
    //   child:
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (value) => {
        if(value.isKeyPressed(LogicalKeyboardKey.arrowDown)){
          setState(() {
          endGame = false;
          print('AYOOOO');
          print(myWidget.mws.getScore());
          
          }
          
        )}
      },
      child: Scaffold(
        body: Container(
          color: Color(0xFF083694),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Color(0xFF083694),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                          child: Center(
                            child: CircleAvatar(
                              maxRadius: 25,
                              backgroundImage: NetworkImage(
                                  'https://static.vecteezy.com/system/resources/previews/008/014/894/original/fuel-nozzle-icon-gas-station-icon-petroleum-fuel-pump-pump-nozzle-oil-dripping-symbol-vector.jpg'),
                            ),
                          ),
                        ),
                        Text('ZAPOČNI TOČENJE',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: collapsed ? 5 : 4,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child:endGame ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF083694),
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child:  GestureDetector(
                          onPanDown: (e) {
                            const double sredinaEkrana = 100;
    
                            if (e.globalPosition.dx >= sredinaEkrana) {
                              myWidget.mws.igrac.udesno();
                            } else {
                              myWidget.mws.igrac.ulevo();
                            }
                            
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/one_lane_street.png',
                                  ),
                                  fit: BoxFit.cover),
                            ),
                            child: myWidget,
                          )), 
                    ): Placeholder(),
                  ),
                ),
                Expanded(
                  flex: collapsed ? 1 : 3,
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    2.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  collapsed = !collapsed;
                                });
                              },
                              icon: collapsed
                                  ? Icon(Icons.arrow_upward)
                                  : Icon(Icons.arrow_downward)),
                        ),
                        collapsed
                            ? SizedBox(
                                height: 0,
                              )
                            : Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('Benzinska stanica',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('Milentija Popovica 1, Beograd',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )),
                                    ),
                                    Divider(),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('Točiono mesto',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('Točiono mesto 4',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )),
                                    ),
                                    Divider(),
                                  ]),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(2.0,
                                          2.0), // shadow direction: bottom right
                                    )
                                  ],
                                ),
                              ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             TocenjeZavrsenoPage()));
                            },
                            child: Text(
                              'Odustani',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TocenjeZavrsenoPage extends StatefulWidget {
  const TocenjeZavrsenoPage({super.key});

  @override
  State<TocenjeZavrsenoPage> createState() => _TocenjeZavrsenoPageState();
}

class _TocenjeZavrsenoPageState extends State<TocenjeZavrsenoPage> {
  var collapsed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF083694),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Color(0xFF083694),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFff7f1b),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text('TOČENJE ZAVRŠENO',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CENA',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      )),
                                  Text('VRSTA GORIVA',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      )),
                                  Text('KOLIČINA',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      )),
                                  Text('LOKACIJA',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      )),
                                  Text('OSTAVREN POPUST',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('145 RSD/l',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text('G-DRIVE DIESEL',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text('20l',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text('B.S KRAGUJEVAC',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text('0.00 RSD',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'PLATNA KARTICA',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.grey),
                                ),
                                Container(
                                  width: 200,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF083694),
                                    border: Border.all(
                                      color: Color(0xFF083694),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 25),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            height: 45,
                                            child:
                                                Image.asset('assets/visa.png'),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: Text('**** 1234',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'SA NAMA NA PUTU',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 25),
                                          child: SizedBox(
                                            height: 45,
                                            child:
                                                Image.asset('assets/snnp.png'),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('**** 6521',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Text('IZNOS ZA PLAĆANJE: ',
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                                Text('\t\t\t\t2500,00 RSD',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
                        decoration: BoxDecoration(
                          color: Color(0xFFff7f1b),
                          border: Border.all(
                            color: Color(0xFFff7f1b),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Plati',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Odustani',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
