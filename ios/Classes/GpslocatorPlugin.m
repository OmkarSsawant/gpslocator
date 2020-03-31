#import "GpslocatorPlugin.h"
#if __has_include(<gpslocator/gpslocator-Swift.h>)
#import <gpslocator/gpslocator-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "gpslocator-Swift.h"
#endif

@implementation GpslocatorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGpslocatorPlugin registerWithRegistrar:registrar];
}
@end
