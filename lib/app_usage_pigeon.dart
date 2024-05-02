import 'package:app_usage/app_usage_platform_interface.dart';

import 'app_usage_api.dart';

/// Pigeon을 사용하는 [AppUsagePlatform]의 구현체입니다.
class PigeonAppUsage extends AppUsagePlatform {
  /// 피존을 이용한 통신 채널인 [AppUsageApi]의 인스턴스입니다.
  final AppUsageApi _api = AppUsageApi();

  /// 플랫폼 버전을 가져오는 메서드입니다. 이 메서드는 플랫폼 버전을 문자열로 반환합니다.
  @override
  Future<String?> getPlatformVersion() {
    return _api.getPlatformVersion();
  }

  /// 사용된 앱의 목록을 가져오는 메서드입니다. 이 메서드는 UsedApp 객체의 리스트를 반환합니다.
  @override
  Future<List<UsedApp>> get apps {
    return _api
        .getApps()
        .then((apps) => apps.where((e) => e != null).map((e) => e!).toList());
  }

  /// 앱의 사용 시간 제한을 설정하는 메서드입니다. 이 메서드는 앱 ID와 제한 시간을 매개변수로 받아, 해당 앱의 사용 시간을 제한합니다.
  @override
  Future<TimeLimitResult> setAppTimeLimit(
      String appId, Duration duration) async {
    return _api.setAppTimeLimit(appId, duration.inMinutes);
  }
}
