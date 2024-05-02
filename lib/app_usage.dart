import 'app_usage_api.dart';
import 'app_usage_platform_interface.dart';

/// 플랫폼 버전 정보 제공, 사용된 앱의 목록, 앱의 사용 시간 제한 설정 등의 기능을 별도의 클래스로 래핑해 제공하는 클래스입니다.
class AppUsage {
  Future<String?> getPlatformVersion() {
    return AppUsagePlatform.instance.getPlatformVersion();
  }

  Future<List<UsedApp>> get apps {
    return AppUsagePlatform.instance.apps;
  }

  Future<TimeLimitResult> setAppTimeLimit(String appId, Duration duration) {
    return AppUsagePlatform.instance.setAppTimeLimit(appId, duration);
  }
}
