////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MIT License
//
// Copyright (c) 2020 aris.org.cn
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import 'dart:convert';
import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:logger/logger.dart';
import 'package:synchronized/synchronized.dart';

///
/// abstract class for logging file to file
/// @author Aris Hu created at 2020-12-07
///
abstract class FileOutput extends LogOutput {
  static Lock _lock = Lock();

  /// 分隔符
  String get fileSeparator {
    return "/";
  }

  /// 日志根目录
  final String _rootPath = 'logs';

  /// 日志模块名(子目录)
  String moduleName;

  /// 日志输出目录
  String outputPath;

  /// 日志文件后缀
  String fileSuffix = ".log";

  FileOutput(this.moduleName) {
    StringBuffer buffer = StringBuffer();
    buffer.write(_rootPath);
    if (moduleName.isNotEmpty) {
      buffer.writeAll([fileSeparator, moduleName]);
    }

    outputPath = DirectoryUtil.createAppSupportDirSync(category: buffer.toString()).path;
  }

  @override
  void output(OutputEvent event) async {
    var filePath = getLogFilePath();
    StringBuffer buffer = StringBuffer();
    event.lines.forEach(buffer.writeln);

    _lock.synchronized(() async {
      File logFile = File(filePath);
      IOSink sink = logFile.openWrite(mode: FileMode.append, encoding: Utf8Codec());
      sink.write(buffer.toString());
      await sink.flush();
      await sink.close();
    });
  }

  /// 获取日志文件的绝对路径
  String getLogFilePath();
}
