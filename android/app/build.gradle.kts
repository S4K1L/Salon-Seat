plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.salon.seat"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.salon.seat"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = maxOf(flutter.minSdkVersion, 21)
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        // Required by AndroidManifest `${GOOGLE_MAPS_API_KEY}` — value from `<repo>/.env` (`GOOGLE_API_KEY=`).
        val repoRoot = rootProject.projectDir.parentFile
            ?: error("Invalid layout: expected android/ inside Flutter project root")
        val envFile = repoRoot.resolve(".env")
        val googleMapsApiKey = if (envFile.isFile) {
            envFile.readText()
                .lineSequence()
                .map { line -> line.trim() }
                .filter { line -> line.isNotEmpty() && !line.startsWith("#") }
                .firstOrNull { line -> line.startsWith("GOOGLE_API_KEY=") }
                ?.substringAfter("=", "")
                ?.trim()
                ?.removeSurrounding("\"")
                ?.removeSurrounding("'")
                ?: ""
        } else {
            ""
        }
        manifestPlaceholders["GOOGLE_MAPS_API_KEY"] = googleMapsApiKey
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
