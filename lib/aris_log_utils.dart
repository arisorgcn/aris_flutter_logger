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

import 'config/aris_log_config.dart';
import 'aris_logger_exception.dart';
import 'enums/log_output_type.dart';
import 'outputs/rotate_file_output.dart';
import 'aris_tag_logger.dart';

///
/// Log工具类
/// @author Aris Hu created at 2020-12-07
///
class ArisLogUtils {
  /// 获取TagLogger实例对象
  static ArisTagLogger getTagLogger({String moduleName = "main"}) {
    List<LogOutput> outputs = [ConsoleOutput()];

    if (moduleName.isNotEmpty) {
      if (ArisLogConfig.logOutputTypes.contains(LogOutputType.ROTATE_FILE_OUTPUT)) {
        if (ArisLogConfig.rotateFileType == null) {
          throw LoggerConfigException("please provide `rotateFileType` property");
        }
        outputs.add(RotateFileOutput(moduleName, rotateFileType: ArisLogConfig.rotateFileType));
      }
    }

    return ArisTagLogger(
      filter: ArisLogConfig.filter,
      printer: ArisLogConfig.printer,
      output: MultiOutput(outputs),
    );
  }

  /// 获取Logger实例对象
  static Logger getLogger({String moduleName = "main"}) {
    List<LogOutput> outputs = [ConsoleOutput()];

    if (moduleName.isNotEmpty) {
      if (ArisLogConfig.logOutputTypes.contains(LogOutputType.ROTATE_FILE_OUTPUT)) {
        if (ArisLogConfig.rotateFileType == null) {
          throw LoggerConfigException("please provide `rotateFileType` property");
        }
        outputs.add(RotateFileOutput(moduleName, rotateFileType: ArisLogConfig.rotateFileType));
      }
    }

    return Logger(
      filter: ArisLogConfig.filter,
      printer: ArisLogConfig.printer,
      output: MultiOutput(outputs),
    );
  }
}
