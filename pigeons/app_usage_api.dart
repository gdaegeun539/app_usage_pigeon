import 'package:pigeon/pigeon.dart';

/// Pigeon을 설정합니다. 이 설정은 다트, 코틀린, 스위프트 코드를 생성합니다.
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/app_usage_api.dart', // 다트 코드 출력 경로
  kotlinOptions: KotlinOptions(
    package: 'dev.dartling.app_usage', // 코틀린 패키지 이름
  ),
  kotlinOut:
      'android/src/main/kotlin/dev/dartling/app_usage/AppUsage.kt', // 코틀린 코드 출력 경로
  swiftOut: 'ios/Classes/AppUsage.swift', // 스위프트 코드 출력 경로
))

/// 결과 상태를 나타내는 열거형
enum ResultState { success, error }

/// 앱 사용 시간 제한 결과를 나타내는 클래스
class TimeLimitResult {
  /// 결과 상태
  final ResultState state;

  /// 메시지
  final String message;

  /// 생성자
  TimeLimitResult(this.state, this.message);
}

/// 사용된 앱을 나타내는 클래스
class UsedApp {
  /// 앱 ID
  final String id;

  /// 앱 이름
  final String name;

  /// 사용된 시간(분)
  final int minutesUsed;

  /// 생성자
  UsedApp(this.id, this.name, this.minutesUsed);
}

/// 앱 사용량 API를 나타내는 추상 클래스
@HostApi()
abstract class AppUsageApi {
  /// 플랫폼 버전을 가져오는 비동기 메서드
  @async
  String? getPlatformVersion();

  /// 사용된 앱 목록을 가져오는 비동기 메서드
  @async
  List<UsedApp> getApps();

  /// 앱 사용 시간 제한을 설정하는 비동기 메서드
  @async
  TimeLimitResult setAppTimeLimit(String appId, int durationInMinutes);
}
