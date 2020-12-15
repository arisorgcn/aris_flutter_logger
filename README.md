# aris_flutter_logger

An easy-to-use logging tool for you to integrate in you project, supporting logging to console, 
file(rotated formatted), supporting configuring according to your environment(development or production)

## Usage

### Step1 add package to your **pubspec.yaml**, then run `pub get`

    aris_flutter_logger: ^1.0.0

### Step2 add below method in main.dart

- development environment
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

- production environment

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

### Step3 in main method before `runApp(MyApp())`, add `await init();`

```dart
Future main() async {
  await init();

  runApp(MyApp());
}
```

### Step4 in page dart file or somewhere else

```dart
void initLogging() {
  final ArisTagLogger logger = ArisLogUtils.getTagLogger();
  final Logger logger = ArisLogUtils.getLogger();
  logger.i('Info Message');
  logger.iFmt('%s %s', ["Info message in ", "initLogging"]);
}
```






