# Diff Details

Date : 2025-11-13 10:41:09

Directory d:\\Arquivos\\UFSM\\App NF\\nf

Total : 76 files,  3128 codes, 295 comments, 476 blanks, all 3899 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [API/config.py](/API/config.py) | Python | -14 | 0 | -6 | -20 |
| [API/controller.py](/API/controller.py) | Python | -15 | -3 | -6 | -24 |
| [API/data.py](/API/data.py) | Python | -143 | -19 | -28 | -190 |
| [API/models/NF.py](/API/models/NF.py) | Python | -437 | -16 | -41 | -494 |
| [API/services/Flask\_service.py](/API/services/Flask_service.py) | Python | -27 | 0 | -10 | -37 |
| [API/services/database.py](/API/services/database.py) | Python | -88 | 0 | -26 | -114 |
| [nf/README.md](/nf/README.md) | Markdown | 10 | 0 | 7 | 17 |
| [nf/analysis\_options.yaml](/nf/analysis_options.yaml) | YAML | 3 | 22 | 4 | 29 |
| [nf/android/app/src/debug/AndroidManifest.xml](/nf/android/app/src/debug/AndroidManifest.xml) | XML | 3 | 4 | 1 | 8 |
| [nf/android/app/src/main/AndroidManifest.xml](/nf/android/app/src/main/AndroidManifest.xml) | XML | 34 | 11 | 1 | 46 |
| [nf/android/app/src/main/res/drawable-v21/launch\_background.xml](/nf/android/app/src/main/res/drawable-v21/launch_background.xml) | XML | 4 | 7 | 2 | 13 |
| [nf/android/app/src/main/res/drawable/launch\_background.xml](/nf/android/app/src/main/res/drawable/launch_background.xml) | XML | 4 | 7 | 2 | 13 |
| [nf/android/app/src/main/res/values-night/styles.xml](/nf/android/app/src/main/res/values-night/styles.xml) | XML | 9 | 9 | 1 | 19 |
| [nf/android/app/src/main/res/values/styles.xml](/nf/android/app/src/main/res/values/styles.xml) | XML | 9 | 9 | 1 | 19 |
| [nf/android/app/src/profile/AndroidManifest.xml](/nf/android/app/src/profile/AndroidManifest.xml) | XML | 3 | 4 | 1 | 8 |
| [nf/android/gradle.properties](/nf/android/gradle.properties) | Properties | 3 | 0 | 1 | 4 |
| [nf/android/gradle/wrapper/gradle-wrapper.properties](/nf/android/gradle/wrapper/gradle-wrapper.properties) | Properties | 5 | 0 | 1 | 6 |
| [nf/ios/RunnerTests/RunnerTests.swift](/nf/ios/RunnerTests/RunnerTests.swift) | Swift | 7 | 2 | 4 | 13 |
| [nf/ios/Runner/AppDelegate.swift](/nf/ios/Runner/AppDelegate.swift) | Swift | 12 | 0 | 2 | 14 |
| [nf/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json](/nf/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json) | JSON | 122 | 0 | 1 | 123 |
| [nf/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json](/nf/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json) | JSON | 23 | 0 | 1 | 24 |
| [nf/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md](/nf/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md) | Markdown | 3 | 0 | 2 | 5 |
| [nf/ios/Runner/Base.lproj/LaunchScreen.storyboard](/nf/ios/Runner/Base.lproj/LaunchScreen.storyboard) | XML | 36 | 1 | 1 | 38 |
| [nf/ios/Runner/Base.lproj/Main.storyboard](/nf/ios/Runner/Base.lproj/Main.storyboard) | XML | 25 | 1 | 1 | 27 |
| [nf/ios/Runner/Runner-Bridging-Header.h](/nf/ios/Runner/Runner-Bridging-Header.h) | C++ | 1 | 0 | 1 | 2 |
| [nf/lib/NF/NF.dart](/nf/lib/NF/NF.dart) | Dart | 233 | 7 | 37 | 277 |
| [nf/lib/NF/invoiceData.dart](/nf/lib/NF/invoiceData.dart) | Dart | 50 | 3 | 10 | 63 |
| [nf/lib/NF/supplierData.dart](/nf/lib/NF/supplierData.dart) | Dart | 55 | 0 | 14 | 69 |
| [nf/lib/NF/taxData.dart](/nf/lib/NF/taxData.dart) | Dart | 86 | 2 | 17 | 105 |
| [nf/lib/NF/transportersData.dart](/nf/lib/NF/transportersData.dart) | Dart | 52 | 0 | 14 | 66 |
| [nf/lib/NF/utils/loading.dart](/nf/lib/NF/utils/loading.dart) | Dart | 39 | 0 | 3 | 42 |
| [nf/lib/NF/utils/suppliers.dart](/nf/lib/NF/utils/suppliers.dart) | Dart | 55 | 0 | 5 | 60 |
| [nf/lib/NF/utils/transporters.dart](/nf/lib/NF/utils/transporters.dart) | Dart | 54 | 0 | 5 | 59 |
| [nf/lib/main.dart](/nf/lib/main.dart) | Dart | 127 | 5 | 16 | 148 |
| [nf/lib/pages/aboutSupplier.dart](/nf/lib/pages/aboutSupplier.dart) | Dart | 91 | 0 | 7 | 98 |
| [nf/lib/pages/aboutTransporter.dart](/nf/lib/pages/aboutTransporter.dart) | Dart | 89 | 0 | 6 | 95 |
| [nf/lib/pages/aboutnf.dart](/nf/lib/pages/aboutnf.dart) | Dart | 325 | 3 | 21 | 349 |
| [nf/lib/pages/invoicePage.dart](/nf/lib/pages/invoicePage.dart) | Dart | 381 | 8 | 20 | 409 |
| [nf/lib/pages/otherPage.dart](/nf/lib/pages/otherPage.dart) | Dart | 73 | 1 | 8 | 82 |
| [nf/lib/pages/taxPage.dart](/nf/lib/pages/taxPage.dart) | Dart | 176 | 0 | 17 | 193 |
| [nf/lib/settings.dart](/nf/lib/settings.dart) | Dart | 31 | 0 | 11 | 42 |
| [nf/lib/src/XMLFile.dart](/nf/lib/src/XMLFile.dart) | Dart | 5 | 0 | 3 | 8 |
| [nf/lib/src/memory.dart](/nf/lib/src/memory.dart) | Dart | 70 | 2 | 18 | 90 |
| [nf/linux/CMakeLists.txt](/nf/linux/CMakeLists.txt) | CMake | 104 | 0 | 25 | 129 |
| [nf/linux/flutter/CMakeLists.txt](/nf/linux/flutter/CMakeLists.txt) | CMake | 79 | 0 | 10 | 89 |
| [nf/linux/flutter/generated\_plugin\_registrant.cc](/nf/linux/flutter/generated_plugin_registrant.cc) | C++ | 3 | 4 | 5 | 12 |
| [nf/linux/flutter/generated\_plugin\_registrant.h](/nf/linux/flutter/generated_plugin_registrant.h) | C++ | 5 | 5 | 6 | 16 |
| [nf/linux/flutter/generated\_plugins.cmake](/nf/linux/flutter/generated_plugins.cmake) | CMake | 18 | 0 | 6 | 24 |
| [nf/linux/runner/CMakeLists.txt](/nf/linux/runner/CMakeLists.txt) | CMake | 21 | 0 | 6 | 27 |
| [nf/linux/runner/main.cc](/nf/linux/runner/main.cc) | C++ | 5 | 0 | 2 | 7 |
| [nf/linux/runner/my\_application.cc](/nf/linux/runner/my_application.cc) | C++ | 91 | 25 | 29 | 145 |
| [nf/linux/runner/my\_application.h](/nf/linux/runner/my_application.h) | C++ | 7 | 7 | 5 | 19 |
| [nf/macos/Flutter/GeneratedPluginRegistrant.swift](/nf/macos/Flutter/GeneratedPluginRegistrant.swift) | Swift | 6 | 3 | 4 | 13 |
| [nf/macos/RunnerTests/RunnerTests.swift](/nf/macos/RunnerTests/RunnerTests.swift) | Swift | 7 | 2 | 4 | 13 |
| [nf/macos/Runner/AppDelegate.swift](/nf/macos/Runner/AppDelegate.swift) | Swift | 11 | 0 | 3 | 14 |
| [nf/macos/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json](/nf/macos/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json) | JSON | 68 | 0 | 1 | 69 |
| [nf/macos/Runner/Base.lproj/MainMenu.xib](/nf/macos/Runner/Base.lproj/MainMenu.xib) | XML | 343 | 0 | 1 | 344 |
| [nf/macos/Runner/MainFlutterWindow.swift](/nf/macos/Runner/MainFlutterWindow.swift) | Swift | 12 | 0 | 4 | 16 |
| [nf/pubspec.yaml](/nf/pubspec.yaml) | YAML | 21 | 60 | 14 | 95 |
| [nf/test/widget\_test.dart](/nf/test/widget_test.dart) | Dart | 14 | 10 | 7 | 31 |
| [nf/web/index.html](/nf/web/index.html) | HTML | 19 | 15 | 5 | 39 |
| [nf/web/manifest.json](/nf/web/manifest.json) | JSON | 35 | 0 | 1 | 36 |
| [nf/windows/CMakeLists.txt](/nf/windows/CMakeLists.txt) | CMake | 89 | 0 | 20 | 109 |
| [nf/windows/flutter/CMakeLists.txt](/nf/windows/flutter/CMakeLists.txt) | CMake | 98 | 0 | 12 | 110 |
| [nf/windows/flutter/generated\_plugin\_registrant.cc](/nf/windows/flutter/generated_plugin_registrant.cc) | C++ | 3 | 4 | 5 | 12 |
| [nf/windows/flutter/generated\_plugin\_registrant.h](/nf/windows/flutter/generated_plugin_registrant.h) | C++ | 5 | 5 | 6 | 16 |
| [nf/windows/flutter/generated\_plugins.cmake](/nf/windows/flutter/generated_plugins.cmake) | CMake | 18 | 0 | 6 | 24 |
| [nf/windows/runner/CMakeLists.txt](/nf/windows/runner/CMakeLists.txt) | CMake | 34 | 0 | 7 | 41 |
| [nf/windows/runner/flutter\_window.cpp](/nf/windows/runner/flutter_window.cpp) | C++ | 49 | 7 | 16 | 72 |
| [nf/windows/runner/flutter\_window.h](/nf/windows/runner/flutter_window.h) | C++ | 20 | 5 | 9 | 34 |
| [nf/windows/runner/main.cpp](/nf/windows/runner/main.cpp) | C++ | 30 | 4 | 10 | 44 |
| [nf/windows/runner/resource.h](/nf/windows/runner/resource.h) | C++ | 9 | 6 | 2 | 17 |
| [nf/windows/runner/utils.cpp](/nf/windows/runner/utils.cpp) | C++ | 54 | 2 | 10 | 66 |
| [nf/windows/runner/utils.h](/nf/windows/runner/utils.h) | C++ | 8 | 6 | 6 | 20 |
| [nf/windows/runner/win32\_window.cpp](/nf/windows/runner/win32_window.cpp) | C++ | 210 | 24 | 55 | 289 |
| [nf/windows/runner/win32\_window.h](/nf/windows/runner/win32_window.h) | C++ | 48 | 31 | 24 | 103 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details