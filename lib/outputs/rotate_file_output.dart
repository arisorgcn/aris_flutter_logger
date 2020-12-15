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

import 'package:aris_flutter_logger/utils/log_format.dart';
import 'package:flustars/flustars.dart';
import 'package:aris_flutter_logger/enums/aris_log_enums.dart';

import 'file_output.dart';

///
/// Rotate文件输出
/// @author Aris Hu created at 2020-12-07
///
class RotateFileOutput extends FileOutput {
  /// 日志文件名称格式
  RotateFileType _rotateFileType;

  RotateFileOutput(String moduleName, {RotateFileType rotateFileType = RotateFileType.DAY}) : super(moduleName) {
    this._rotateFileType = rotateFileType;
  }

  /// 获取日志文件的绝对路径
  @override
  String getLogFilePath() {
    String fileName;
    switch (_rotateFileType) {
      case RotateFileType.MINUTE:
        fileName = DateUtil.formatDate(DateTime.now().toLocal(), format: LogDateFormats.y_mo_d_h_m_dash);
        break;
      case RotateFileType.HOUR:
        fileName = DateUtil.formatDate(DateTime.now().toLocal(), format: LogDateFormats.y_mo_d_h_dash);
        break;
      default:
        fileName = DateUtil.formatDate(DateTime.now().toLocal(), format: LogDateFormats.y_mo_d_dash);
        break;
    }
    StringBuffer buffer = StringBuffer();
    buffer.writeAll([outputPath, fileSeparator, fileName, fileSuffix]);
    return buffer.toString();
  }
}
