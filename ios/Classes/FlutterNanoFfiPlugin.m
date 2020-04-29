#import "FlutterNanoFfiPlugin.h"
#if __has_include(<flutter_nano_ffi/flutter_nano_ffi-Swift.h>)
#import <flutter_nano_ffi/flutter_nano_ffi-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_nano_ffi-Swift.h"
#endif

@implementation FlutterNanoFfiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNanoFfiPlugin registerWithRegistrar:registrar];
}
@end
