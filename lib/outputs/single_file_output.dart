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

import 'package:aris_flutter_logger/utils/file_utils.dart';

import 'file_output.dart';

///
/// Print all logs to local single file
/// @author Aris Hu created at 2020-12-07
///
class SingleFileOutput extends FileOutput {
  /// 文件名称, 不包含后缀名
  String _fileName;

  SingleFileOutput(String moduleName, String fileName) : super(moduleName) {
    var suffix = FileUtils.getFileSuffix(fileName);
    // 如果带有后缀名
    if (suffix.isNotEmpty) {
      // 取出后缀名, 改写文件名(不带有后缀)
      fileSuffix = '.' + suffix;
      this._fileName = fileName.substring(0, fileName.lastIndexOf(FileUtils.regFileSuffix) - 1);
    } else {
      this._fileName = fileName;
    }
  }

  @override
  String getLogFilePath() {
    StringBuffer buffer = StringBuffer();
    buffer.writeAll([outputPath, fileSeparator, _fileName, fileSuffix]);
    return buffer.toString();
  }
}
