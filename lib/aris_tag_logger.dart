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
import 'package:sprintf/sprintf.dart';

/// @author Aris Hu created at 2020-12-08
/// TagLogger logger = TagLogger();
///
/// logger.dFmt("%s-%s", ["小明", "爱学习"]);    // 小明-爱学习
///
class ArisTagLogger extends Logger {
  ArisTagLogger({
    LogFilter filter,
    LogPrinter printer,
    LogOutput output,
    Level level,
  }) : super(filter: filter, printer: printer, output: output, level: level);

  /// VERBOSE日志格式化输出
  /// @param fmt  C语言风格的格式化字符串
  /// @param args 参数
  void vFmt(String fmt, List<dynamic> args, [dynamic error, StackTrace stackTrace]) {
    String message = _getFormattedMessage(fmt, args);
    super.v(message, error, stackTrace);
  }

  /// DEBUG日志格式化输出
  void dFmt(String fmt, List<dynamic> args, [dynamic error, StackTrace stackTrace]) {
    String message = _getFormattedMessage(fmt, args);
    super.d(message, error, stackTrace);
  }

  /// INFO日志格式化输出
  void iFmt(String fmt, List<dynamic> args, [dynamic error, StackTrace stackTrace]) {
    String message = _getFormattedMessage(fmt, args);
    super.i(message, error, stackTrace);
  }

  /// WARNING日志格式化输出
  void wFmt(String fmt, List<dynamic> args, [dynamic error, StackTrace stackTrace]) {
    String message = _getFormattedMessage(fmt, args);
    super.w(message, error, stackTrace);
  }

  /// ERROR日志格式化输出
  void eFmt(String fmt, List<dynamic> args, [dynamic error, StackTrace stackTrace]) {
    String message = _getFormattedMessage(fmt, args);
    super.e(message, error, stackTrace);
  }

  /// Fatal日志格式化输出
  void wtfFmt(String fmt, List<dynamic> args, [dynamic error, StackTrace stackTrace]) {
    String message = _getFormattedMessage(fmt, args);
    super.wtf(message, error, stackTrace);
  }

  String _getFormattedMessage(String fmt, List args) {
    var _args = args.map((item) {
      if (item is Map) {
        // 如果是Map, 转换成字符串
        StringBuffer buffer = StringBuffer();
        item.entries.forEach((entry) {
          if (entry.value is num) {
            buffer.write('${entry.key}=${entry.value}');
          } else {
            buffer.write('${entry.key}="${entry.value}"');
          }
        });
        return buffer.toString();
      } else if (item is num) {
        return item;
      } else {
        return item.toString();
      }
    }).toList();
    var message = sprintf(fmt, _args);
    return message;
  }
}
