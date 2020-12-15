import 'dart:io';

import 'package:aris_flutter_logger/aris_flutter_logger.dart';
import 'package:aris_flutter_logger/aris_tag_logger.dart';
import 'package:aris_flutter_logger/enums/log_output_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'logger_console_page.dart';

Future main() async {
  await init();

  runApp(MyApp());

  initLogging();
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize logger
  await ArisLogConfig.init(
    printer: ProductionLogPrinter(printTime: true),
    filter: ProductionFilter(),
    logLevel: Level.info,
    logOutputTypes: [LogOutputType.ROTATE_FILE_OUTPUT],
    rotateFileType: RotateFileType.DAY,
  );
}

void initLogging() {
  final ArisTagLogger logger = ArisLogUtils.getTagLogger();
  logger.i('Info Message');
  logger.iFmt('%s %s', ["Info message in ", "initLogging"]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logging Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Logger Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Container(
          alignment: Alignment.topCenter,
          child: FlatButton(
            onPressed: _goLoggerPage,
            child: Text('View Logs'),
            color: Colors.blue,
            textColor: Colors.white,
            height: 50,
            minWidth: MediaQuery.of(context).size.width,
            textTheme: ButtonTextTheme.normal,
          ),
        ),
      ),
    );
  }

  void _goLoggerPage() {
    if (Platform.isIOS) {
      Navigator.push(context, CupertinoPageRoute(builder: (context) => LoggerConsolePage()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoggerConsolePage()));
    }
  }
}
