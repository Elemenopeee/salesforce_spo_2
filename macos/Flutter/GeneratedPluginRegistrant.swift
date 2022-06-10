//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import azure_ad_authentication
import path_provider_macos
import shared_preferences_macos
import sqflite
import url_launcher_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AzureAdAuthenticationPlugin.register(with: registry.registrar(forPlugin: "AzureAdAuthenticationPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
  UrlLauncherPlugin.register(with: registry.registrar(forPlugin: "UrlLauncherPlugin"))
}
