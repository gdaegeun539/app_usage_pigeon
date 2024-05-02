import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/app_usage_api.dart',
  kotlinOptions: KotlinOptions(
    package: 'dev.dartling.app_usage',
  ),
  kotlinOut: 'android/src/main/kotlin/dev/dartling/app_usage/AppUsage.kt',
  swiftOut: 'ios/Classes/AppUsage.swift',
))
enum ResultState { success, error }

class TimeLimitResult {
  final ResultState state;
  final String message;

  TimeLimitResult(this.state, this.message);
}

class UsedApp {
  final String id;
  final String name;
  final int minutesUsed;

  UsedApp(this.id, this.name, this.minutesUsed);
}

@HostApi()
abstract class AppUsageApi {
  @async
  String? getPlatformVersion();

  @async
  List<UsedApp> getApps();

  @async
  TimeLimitResult setAppTimeLimit(String appId, int durationInMinutes);
}
