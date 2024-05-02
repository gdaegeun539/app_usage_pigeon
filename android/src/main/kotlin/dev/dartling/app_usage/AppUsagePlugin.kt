package dev.dartling.app_usage

import io.flutter.embedding.engine.plugins.FlutterPlugin

class AppUsagePlugin : FlutterPlugin, AppUsageApi {
    val usedApps: MutableList<UsedApp> =
        mutableListOf(
            usedApp("com.reddit.app", "Reddit", 75),
            usedApp("dev.hashnode.app", "Hashnode", 37),
            usedApp("link.timelog.app", "Timelog", 25),
        )

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        AppUsageApi.setUp(flutterPluginBinding.binaryMessenger, this)
    }

    override fun getPlatformVersion(callback: (Result<String?>) -> Unit) {
        callback(Result.success("Android ${android.os.Build.VERSION.RELEASE}"))
    }

    override fun getApps(callback: (Result<List<UsedApp>>) -> Unit) {
        callback(Result.success(usedApps))
    }

    override fun setAppTimeLimit(
        appId: String,
        durationInMinutes: Long,
        callback: (Result<TimeLimitResult>) -> Unit
    ) {
        val stateResult =
            TimeLimitResult(
                ResultState.SUCCESS, "Timer of $durationInMinutes minutes set for app ID $appId")
        callback(Result.success(stateResult))
    }

    private fun usedApp(id: String, name: String, minutesUsed: Long): UsedApp {
        return UsedApp(id, name, minutesUsed)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        AppUsageApi.setUp(binding.binaryMessenger, null)
    }
}
