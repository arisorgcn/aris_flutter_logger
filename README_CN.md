# aris_flutter_logger

简单使用、可以集成到项目中的日志工具类, 支持将日志打印到控制台和文件(单文件输出、分模块rotate输出),
支持分环境配置(开发环境或生产环境)

## 使用方式

### Step1 添加以下依赖到pubspec.yaml, 然后运行 `pub get` 命令

    aris_flutter_logger: ^1.0.0

### Step2 添加以下方法

- 开发环境
```dart
Future init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize logger
  await ArisLogConfig.init(
    printer: DevelopmentLogPrinter(methodCount: 0, errorMethodCount: 0, colors: false, printEmojis: false, printTime: true),
    filter: DevelopmentFilter(),
    logLevel: Level.debug,
    logOutputTypes: [LogOutputType.CONSOLE_OUTPUT, LogOutputType.ROTATE_FILE_OUTPUT],
    rotateFileType: RotateFileType.DAY,
  );
}
```

- 生产环境

```dart
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
```

### Step3 在 main()方法的 `runApp(MyApp())` 之前添加`await init();`
```dart
Future main() async {
  await init();

  runApp(MyApp());
}
```

### Step4 在页面中这样使用

```dart
void initLogging() {
  final ArisTagLogger logger = ArisLogUtils.getTagLogger();
  final Logger logger = ArisLogUtils.getLogger();
  logger.i('Info Message');
  logger.iFmt('%s %s', ["Info message in ", "initLogging"]);
}
```