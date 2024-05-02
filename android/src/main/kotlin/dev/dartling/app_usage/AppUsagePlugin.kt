package dev.dartling.app_usage

import io.flutter.embedding.engine.plugins.FlutterPlugin

/**
 * 피존 메소드 [AppUsageApi]를 상속받아 앱 사용 정보를 반환해줄 수 있는 플러터 플러그인의 안드로이드 파트
 */
class AppUsagePlugin : FlutterPlugin, AppUsageApi {
    // 사용된 앱의 목록을 저장하는 변수입니다.
    val usedApps: MutableList<UsedApp> =
        mutableListOf(
            usedApp("com.reddit.app", "Reddit", 75),
            usedApp("dev.hashnode.app", "Hashnode", 37),
            usedApp("link.timelog.app", "Timelog", 25),
        )

    /**
     * 플러그인이 엔진에 연결될 때 호출되는 메서드입니다.
     *
     * 네이티브-플러터 통신을 위한 바이너리 메신저 설정을 진행합니다.
     */
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        AppUsageApi.setUp(flutterPluginBinding.binaryMessenger, this)
    }

    /**
     * 플랫폼 버전을 가져오는 메서드입니다.
     */
    override fun getPlatformVersion(callback: (Result<String?>) -> Unit) {
        callback(Result.success("Android ${android.os.Build.VERSION.RELEASE}"))
    }

    /**
     * 사용된 앱의 목록을 가져오는 메서드입니다.
     */
    override fun getApps(callback: (Result<List<UsedApp>>) -> Unit) {
        callback(Result.success(usedApps))
    }

    /**
     * 앱의 사용 시간 제한을 설정하는 목업 메서드입니다.
     */
    override fun setAppTimeLimit(
        appId: String,
        durationInMinutes: Long,
        callback: (Result<TimeLimitResult>) -> Unit,
    ) {
        val stateResult =
            TimeLimitResult(
                ResultState.SUCCESS, "Timer of $durationInMinutes minutes set for app ID $appId"
            )
        callback(Result.success(stateResult))
    }

    private fun usedApp(id: String, name: String, minutesUsed: Long): UsedApp {
        return UsedApp(id, name, minutesUsed)
    }

    /**
     * 플러그인이 엔진에서 분리될 때 호출되는 메서드입니다.
     *
     * 네이티브-플러터 통신을 위한 바이너리 메신저 초기화를 진행합니다.
     */
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        AppUsageApi.setUp(binding.binaryMessenger, null)
    }
}