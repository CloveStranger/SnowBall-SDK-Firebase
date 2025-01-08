import 'package:logger/logger.dart';

class SnowballLogger {
  static final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printEmojis: false,
    ),
  );
}
