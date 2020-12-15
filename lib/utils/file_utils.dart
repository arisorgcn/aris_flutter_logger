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

import 'dart:io';

/// 文件工具类
/// @author Aris Hu created at 2020-12-07
///
class FileUtils {
  /// 文件后缀名正则
  static final RegExp regFileSuffix = RegExp("[^\.]\w*");

  /// 获取文件名的后缀
  static String getFileSuffix(String fileName) {
    Iterable<RegExpMatch> matches = regFileSuffix.allMatches(fileName);
    if (matches.isNotEmpty) {
      return matches.elementAt(matches.length - 1).toString();
    }
    return null;
  }

  /// 判断文件是否存在
  static Future<bool> isFileExists(String filePath) async {
    File file = File(filePath);
    return await file.exists();
  }

  /// 创建文件
  static Future<File> createFile(String filePath) async {
    File file = new File(filePath);
    return file.create();
  }
}
