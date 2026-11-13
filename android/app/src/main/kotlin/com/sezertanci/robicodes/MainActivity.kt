package com.sezertanci.robicodes

import android.content.pm.ActivityInfo
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    // Telefonda oyunlar yatayda sıkıştığı için ekran dikeye sabitlenir; tablette iki yön de serbesttir.
    // Kısıt pencere çizilmeden konur, böylece telefon yatay tutulurken açılsa bile önce yatay görünmez.
    override fun onCreate(savedInstanceState: Bundle?) {
        if (resources.configuration.smallestScreenWidthDp < PHONE_MAX_SMALLEST_WIDTH_DP) {
            requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
        }
        super.onCreate(savedInstanceState)
    }

    private companion object {
        // En küçük ekran genişliği bu değerin altında kalan cihazlar telefon sayılır (Android'in tablet sınırı).
        const val PHONE_MAX_SMALLEST_WIDTH_DP = 600
    }
}
