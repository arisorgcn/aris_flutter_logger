import 'package:flustars/flustars.dart';
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
import 'package:logger/logger.dart';

import '../aris_flutter_logger.dart';
import '../enums/log_output_type.dart';

///
/// 日志配置类
/// @author Aris Hu created at 2020-12-07
///
class ArisLogConfig {
  static Future init(
      {LogPrinter printer,
      LogFilter filter,
      LogOutput output,
      Level logLevel,
      List<LogOutputType> logOutputTypes,
      RotateFileType rotateFileType}) async {
    ArisLogConfig.printer = printer ?? PrettyPrinter();
    ArisLogConfig.filter = filter ?? DevelopmentFilter();
    ArisLogConfig.output = output ?? MultiOutput([ConsoleOutput()]);
    ArisLogConfig.logLevel = logLevel ?? Level.nothing;
    ArisLogConfig.logOutputTypes = logOutputTypes ?? [LogOutputType.CONSOLE_OUTPUT];
    ArisLogConfig.rotateFileType = rotateFileType ?? null;

    // 设置日志的级别
    Logger.level = ArisLogConfig.logLevel;

    await _initDirecotyUtil();
  }

  static Future _initDirecotyUtil() async {
    // 初始化目录操作工具类
    await DirectoryUtil.initAppDocDir();
    await DirectoryUtil.initStorageDir();
    await DirectoryUtil.initAppSupportDir();
    await DirectoryUtil.initTempDir();
    await DirectoryUtil.getInstance();
  }

  /// 日志打印
  static LogPrinter printer;

  /// 日志过滤器
  static LogFilter filter;

  /// 日志输出位置
  static LogOutput output;

  /// 日志级别
  static Level logLevel;

  /// 日志输出类型数组
  static List<LogOutputType> logOutputTypes = [LogOutputType.CONSOLE_OUTPUT];

  /// rotate输出类型
  static RotateFileType rotateFileType;

  /// 是否启用日志
  static void enableLog({bool enabled = true}) => enabled ?? enabled == true ? null : logLevel = Level.nothing;

  /// 是否开启verbose以及之上的日志
  static void enableVerbose() => logLevel = Level.verbose;

  /// 是否开启debug以及之上的日志
  static void enableDebug() => logLevel = Level.debug;

  /// 是否开启info以及之上的日志
  static void enableInfo() => logLevel = Level.info;

  /// 是否开启warning以及之上的日志
  static void enableWarning() => logLevel = Level.warning;

  /// 是否开启error以及之上的日志
  static void enableError() => logLevel = Level.error;

  /// 是否开启fatal以及之上的日志
  static void enableFatal() => logLevel = Level.wtf;
}
