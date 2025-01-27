package com.example.matcron

import android.nfc.NfcAdapter
import android.nfc.Tag
import android.nfc.tech.NfcA
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.matcron.nfc/transceive"
    private var currentTag: Tag? = null // Store the current NFC tag

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Handle NFC transceive operations from Flutter
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "transceive") {
                val arguments = call.arguments as Map<*, *>
                val command = (arguments["command"] as List<*>).map { (it as Int).toByte() }.toByteArray()

                if (currentTag == null) {
                    result.error("TAG_ERROR", "No NFC tag available", null)
                    return@setMethodCallHandler
                }

                val nfcA = NfcA.get(currentTag)
                if (nfcA == null) {
                    result.error("TAG_ERROR", "Tag does not support NfcA", null)
                    return@setMethodCallHandler
                }

                try {
                    nfcA.connect()
                    val response = nfcA.transceive(command)
                    nfcA.close()
                    result.success(response.toList())
                } catch (e: Exception) {
                    result.error("TRANSCEIVE_ERROR", "Failed to transceive NFC command", e.localizedMessage)
                }
            } else {
                result.notImplemented()
            }
        }
    }


}