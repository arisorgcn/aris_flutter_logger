import 'dart:async';
import 'dart:io';

import 'package:aris_flutter_logger/aris_log_utils.dart';
import 'package:aris_flutter_logger/aris_tag_logger.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

///
/// logging console
/// @author Aris Hu created at 2020-12-15
///
class LoggerConsolePage extends StatefulWidget {
  LoggerConsolePage({Key key}) : super(key: key);

  @override
  _LoggerConsolePageState createState() => _LoggerConsolePageState();
}

class _LoggerConsolePageState extends State<LoggerConsolePage> {
  final ArisTagLogger logger = ArisLogUtils.getTagLogger();
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode textFocusNode = FocusNode();

  List<String> logs = [];

  @override
  void initState() {
    super.initState();
    _readLogsFromFile();
  }

  void _readLogsFromFile() {
    var fileName = DateUtil.formatDate(DateTime.now(), format: DateFormats.y_mo_d) + '.log';
    var absolutePath = DirectoryUtil.getAppSupportPath(category: 'logs/main', fileName: fileName);

    File file = File(absolutePath);
    file.readAsLines().then((value) {
      _updateLogs(value);
    });
  }

  FutureOr _updateLogs(List<String> value) {
    if (value.isNotEmpty) {
      logs.clear();
      logs.addAll(value.reversed);
    }
    setState(() {
      textEditingController.text = logs.join('\n');
    });
  }

  void _generateLogRecord() {
    logger.i('Info Message In LoggerConsolePage');
    _readLogsFromFile();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    textFocusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LoggerConsolePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    textFocusNode = FocusNode();
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    _readLogsFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logging Console'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                RaisedButton(
                  child: Text('Add Log'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: _generateLogRecord,
                ),
                SizedBox(
                  width: 0.6,
                  height: 8.0,
                  child: VerticalDivider(),
                ),
                TextField(
                  scrollController: scrollController,
                  scrollPhysics: ScrollPhysics(),
                  controller: textEditingController,
                  focusNode: textFocusNode,
                  readOnly: true,
                  maxLines: 20,
                  style: TextStyle(
                    color: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
