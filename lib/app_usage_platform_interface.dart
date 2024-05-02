import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_usage_api.dart';
import 'app_usage_pigeon.dart';

/// [PlatformInterface]를 확장한 플러그인의 플랫폼 추상 클래스의 정의입니다.
abstract class AppUsagePlatform extends PlatformInterface {
  /// `AppUsagePlatform`의 생성자입니다. 토큰으로 [_token]을 사용합니다.
  AppUsagePlatform() : super(token: _token);

  static final Object _token = Object();

  static AppUsagePlatform _instance = PigeonAppUsage();

  /// 기본적으로 사용되는 `AppUsagePlatform`의 인스턴스입니다.
  ///
  /// 기본값은 [PigeonAppUsage]입니다.
  static AppUsagePlatform get instance => _instance;

  /// 플랫폼별 구현체는 자신을 등록할 때
  /// [AppUsagePlatform]을 확장하는 자신만의 플랫폼별 클래스로 이를 설정해야 합니다.
  static set instance(AppUsagePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// 플랫폼 버전을 가져오는 메서드입니다. 추상 클래스에서는 구현하지 않습니다.
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// 사용된 앱의 목록을 가져오는 메서드입니다. 추상 클래스에서는 구현하지 않습니다.
  Future<List<UsedApp>> get apps async {
    throw UnimplementedError('apps has not been implemented.');
  }

  /// 앱의 시간 제한을 설정하는 메서드입니다. 추상 클래스에서는 구현하지 않습니다.
  Future<TimeLimitResult> setAppTimeLimit(
      String appId, Duration duration) async {
    throw UnimplementedError('setAppTimeLimit() has not been implemented.');
  }
}
