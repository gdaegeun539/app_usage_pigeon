import Flutter
import UIKit

/// 피존 메소드 `AppUsageApi`를 상속받아 앱 사용 정보를 반환해줄 수 있는 플러터 플러그인의 iOS 파트
public class SwiftAppUsagePlugin: NSObject, FlutterPlugin, AppUsageApi {
    /// 사용된 앱의 목록을 저장하는 변수입니다.
    var usedApps = [
        UsedApp(id: "com.reddit.app", name: "Reddit", minutesUsed: 75),
        UsedApp(id: "dev.hashnode.app", name: "Hashnode", minutesUsed:37),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25)
    ]

    /// 플러그인이 엔진에 연결될 때 호출되는 메서드입니다.
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger : FlutterBinaryMessenger = registrar.messenger()
        let api : AppUsageApi & NSObjectProtocol = SwiftAppUsagePlugin.init()
        AppUsageApiSetup.setUp(binaryMessenger: messenger, api: api)
    }

    /// 플랫폼 버전을 가져오는 메서드입니다.
    func getPlatformVersion(completion: @escaping (Result<String?, Error>) -> Void) {
        let resultString = "iOS " + UIDevice.current.systemVersion
        completion(.success(resultString))
    }

    /// 사용된 앱의 목록을 가져오는 메서드입니다.
    func getApps(completion: @escaping (Result<[UsedApp], Error>) -> Void) {
        completion(.success(usedApps))
    }

    /// 앱의 사용 시간 제한을 설정하는 메서드입니다.
    func setAppTimeLimit(appId: String, durationInMinutes: Int64, completion: @escaping (Result<TimeLimitResult, Error>) -> Void) {
        let timeLimitResult = TimeLimitResult(state: ResultState.success, message: "Timer of \(durationInMinutes) minutes set for app ID \(appId)")
        completion(.success(timeLimitResult))
    }
}
