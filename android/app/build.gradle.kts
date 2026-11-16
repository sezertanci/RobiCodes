import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Release imza bilgileri repoda tutulmaz: keystore yolu ve alias git dışı `android/key.properties`
// dosyasından, parola ortam değişkeninden okunur. Bilgiler eksikse release debug anahtarıyla imzalanır
// (yerel `flutter run --release` için); böyle bir AAB'yi Google Play kabul etmez.
val releaseSigningName = "release"
val keystorePasswordVariable = "ROBICODES_KEYSTORE_PASSWORD"
val keystoreProperties =
    Properties().apply {
        val file = rootProject.file("key.properties")
        if (file.exists()) {
            file.inputStream().use { load(it) }
        }
    }
val keystoreFile: String? = keystoreProperties.getProperty("storeFile")
val keystoreAlias: String? = keystoreProperties.getProperty("keyAlias")
val keystorePassword: String? = System.getenv(keystorePasswordVariable)
val hasReleaseKey = keystoreFile != null && keystoreAlias != null && !keystorePassword.isNullOrEmpty()

android {
    namespace = "com.sezertanci.robicodes"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.sezertanci.robicodes"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion // in_app_purchase_android (Billing Library 9) en az API 23 ister.
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseKey) {
            create(releaseSigningName) {
                storeFile = file(keystoreFile!!)
                keyAlias = keystoreAlias
                // PKCS12 keystore'da mağaza ve anahtar parolası aynıdır.
                storePassword = keystorePassword
                keyPassword = keystorePassword
            }
        }
    }

    buildTypes {
        debug {
            // Debug sürümü ayrı bir uygulama olarak kurulur; cihazdaki Play sürümüne ve verisine dokunmaz.
            applicationIdSuffix = ".dev"
        }
        release {
            signingConfig =
                if (hasReleaseKey) {
                    signingConfigs.getByName(releaseSigningName)
                } else {
                    logger.warn(
                        "Release imza bilgisi yok (key.properties veya $keystorePasswordVariable); " +
                            "debug anahtarı kullanılıyor.",
                    )
                    signingConfigs.getByName("debug")
                }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
