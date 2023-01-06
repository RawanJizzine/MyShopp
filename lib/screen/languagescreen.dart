

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  static const routeName = '/language';

  @override
  _LanguageWidgetState createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int ppp = 0;

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 22, 173, 22),
          automaticallyImplyLeading: true,
          actions: <Widget>[
            SizedBox(
              height: 70,
            ),
           
            const SizedBox(width: 20.0 / 2)
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
              child: Text('Language\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20)),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 4,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(width: 150),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 22, 173, 22), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    setState(() async {
                      await context.setLocale(Locale('ar'));
                      ppp = 1;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setInt('num', ppp);
                    });
                  },
                  icon: Icon(
                    Icons.language,
                    size: 24.0,
                  ),
                  label: Text('Arab'),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(width: 150),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 22, 173, 22), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    setState(() async {
                      await context.setLocale(Locale('en'));
                      ppp = 0;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setInt('num', ppp);
                    });
                  },
                  icon: Icon(
                    Icons.language,
                    size: 24.0,
                  ),
                  label: Text('Eng'),
                ),
              ],
            ),
          ],
        )

        /*   SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Container(
                  color: Colors.white,
                  width: 500,
                  height: 50,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {},
                        child: Container(
                          height: 40,
                          width: 400,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(255, 22, 173, 22),
                                width: 4,
                              )),
                          alignment: Alignment.center,
                          child: Text("English"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Container(
                  color: Colors.white,
                  width: 400,
                  height: 50,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {},
                        child: Container(
                          height: 40,
                          width: 400,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(255, 22, 173, 22),
                                width: 4,
                              )),
                          alignment: Alignment.center,
                          child: Text("English"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ), */
        );
  }
}
