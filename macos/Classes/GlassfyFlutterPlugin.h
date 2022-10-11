#import <FlutterMacOS/FlutterMacOS.h>
#import <GlassfyGlue/GlassfyGlue.h>

@interface GlassfyFlutterPlugin : NSObject<FlutterPlugin,GlassfyGluePurchaseDelegate>
@property (nonatomic, retain) FlutterMethodChannel *channel;
@end
