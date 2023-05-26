#import "GlassfyFlutterPlugin.h"
#import "FlutterPaywallListener.h"

@interface GlassfyFlutterPlugin()
@property (nonatomic, strong) FlutterEventSink paywallEventSink;
@property (nonatomic, strong) FlutterEventChannel* paywallEventChannel;
@property (nonatomic, strong) GYPaywallViewController* _Nullable paywallViewController;
@property (nonatomic, strong) FlutterPaywallListener* _Nullable paywallListener;
@end

@implementation GlassfyFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel =
    [FlutterMethodChannel methodChannelWithName:@"glassfy_flutter"
                                binaryMessenger:[registrar messenger]];
    GlassfyFlutterPlugin *instance = [[GlassfyFlutterPlugin alloc] init];
    instance.channel = channel;
    [registrar addMethodCallDelegate:instance channel:channel];
    
    instance.paywallEventChannel = [FlutterEventChannel
                                    eventChannelWithName:@"paywallEvent"
                                    binaryMessenger:[registrar messenger]];
    [instance.paywallEventChannel setStreamHandler:instance];
}

- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    self.paywallEventSink = events;
    return nil;
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
    self.paywallEventSink = nil;
    return nil;
}

NSString *GlassfyDidPurchaseEventFromDelegate = @"gy_did_purchase_product";

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"VER "
                stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"sdkVersion" isEqualToString:call.method]) {
        [GlassfyGlue
         sdkVersionWithCompletion:[self
                                   convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"initialize" isEqualToString:call.method]) {
        NSString* apiKey = arguments[@"apiKey"];
        NSString* version = arguments[@"version"];
        BOOL watcherMode = [arguments[@"watcherMode"] boolValue];
        [GlassfyGlue
         initializeWithApiKey: apiKey
         watcherMode: watcherMode
         crossPlatformSdkFramework: @"flutter"
         crossPlatformSdkVersion: version
         withCompletion: [self convertGlassfyGlueResultToFlutter:result]];
        [GlassfyGlue setPurchaseDelegate:self];
    } else if ([@"setLogLevel" isEqualToString:call.method]) {
        int logLevel = [arguments[@"logLevel"] intValue];
        [GlassfyGlue setLogLevel:logLevel];
    } else if ([@"offerings" isEqualToString:call.method]) {
        [GlassfyGlue offeringsWithCompletion:[self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"purchaseHistory" isEqualToString:call.method]) {
        [GlassfyGlue purchaseHistoryWithCompletion:[self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"skuWithId" isEqualToString:call.method]) {
        NSString *identifier = arguments[@"identifier"];
        [GlassfyGlue skuWithId:identifier
                withCompletion:[self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"skuWithIdAndStore" isEqualToString:call.method]) {
        NSString *identifier = arguments[@"identifier"];
        int store = [arguments[@"store"] intValue];
        [GlassfyGlue skuWithId:identifier
                         store:store
                    completion:[self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"login" isEqualToString:call.method]) {
        NSString *userid = arguments[@"userid"];
        [GlassfyGlue
         connectCustomSubscriber:userid
         completion:[self
                     convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"logout" isEqualToString:call.method]) {
        [GlassfyGlue
         connectCustomSubscriber:nil
         completion:[self
                     convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"permissions" isEqualToString:call.method]) {
        [GlassfyGlue permissionsWithCompletion:
         [self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"purchaseSku" isEqualToString:call.method]) {
        NSDictionary *sku = arguments[@"sku"];
        [GlassfyGlue purchaseSku:sku
                  withCompletion:[self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"restorePurchases" isEqualToString:call.method]) {
        [GlassfyGlue restorePurchasesWithCompletion:
         [self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"setDeviceToken" isEqualToString:call.method]) {
        NSString *token = arguments[@"token"];
        [GlassfyGlue
         setDeviceToken:token
         withCompletion:[self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"setEmailUserProperty" isEqualToString:call.method]) {
        NSString *email = arguments[@"email"];
        [GlassfyGlue
         setEmailUserProperty:email
         withCompletion:[self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"setExtraUserProperty" isEqualToString:call.method]) {
        NSDictionary *extraProp = arguments[@"extraProp"];
        [GlassfyGlue
         setExtraUserProperty:extraProp
         withCompletion:[self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"getExtraUserProperty" isEqualToString:call.method]) {
        [GlassfyGlue getExtraUserPropertyWithCompletion:
         [self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"connectCustomSubscriber" isEqualToString:call.method]) {
        NSString *subscriberId = arguments[@"subscriberId"];
        [GlassfyGlue
         connectCustomSubscriber:subscriberId
         completion:[self
                     convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"connectPaddleLicenseKey" isEqualToString:call.method]) {
        NSString *licenseKey = arguments[@"licenseKey"];
        BOOL force = [arguments[@"force"] boolValue];
        [GlassfyGlue
         connectPaddleLicenseKey:licenseKey
         force:force
         completion:[self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"connectGlassfyUniversalCode" isEqualToString:call.method]) {
        NSString *universalCode = arguments[@"universalCode"];
        BOOL force = [arguments[@"force"] boolValue];
        [GlassfyGlue
         connectGlassfyUniversalCode:universalCode
         force:force
         completion:[self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"setAttribution" isEqualToString:call.method]) {
        NSNumber *type = arguments[@"type"];
        NSString *value = arguments[@"value"];
        [GlassfyGlue setAttributionType:type
                                  value:value
                             completion:[self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"setAttributions" isEqualToString:call.method]) {
        NSArray *items = arguments[@"items"];
        [GlassfyGlue setAttributions:items
                          completion:[self convertGlassfyGlueResultToFlutter:result]];
    } else if ([@"openUrl" isEqualToString:call.method]) {
        NSString *urlString = arguments[@"url"];
        NSURL *url = [NSURL URLWithString:urlString];
        if (url) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
        result(@"");
    } else if ([@"showPaywall" isEqualToString:call.method]) {
        NSString *remoteConfig = arguments[@"remoteConfig"];
        BOOL awaitLoading = arguments[@"awaitLoading"];
        [self showPaywallWithRemoteConfig:remoteConfig awaitLoading:awaitLoading result:result];
    } else if ([@"closePaywall" isEqualToString:call.method]) {
        if (self.paywallViewController != nil) {
            [self.paywallViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)showPaywallWithRemoteConfig:(NSString *)remoteConfig
                       awaitLoading:(BOOL)awaitLoading
                             result:(FlutterResult)result {
    [Glassfy paywallViewControllerWithRemoteConfigurationId:remoteConfig
                                               awaitLoading:awaitLoading
                                                 completion:^(GYPaywallViewController * _Nullable viewController, NSError * _Nullable error) {
        if (error != nil) {
            result(error);
            return;
        }
        self.paywallViewController = viewController;
        
        self.paywallListener = [[FlutterPaywallListener alloc] initWithSendEvent:^(NSString * _Nullable eventName, NSDictionary * _Nullable payload) {
            [self sendEventWithName:eventName payload:payload];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *rootViewController = UIApplication.sharedApplication.delegate.window.rootViewController;
            [rootViewController presentViewController:viewController animated:YES completion:nil];
        });
        
        [viewController setCloseHandler:^(GYTransaction *transaction, NSError *error) {
            [self.paywallListener onCloseWithTransaction:transaction error:error];
        }];
        [viewController setLinkHandler:^(NSURL *link) {
            [self.paywallListener onLinkWithURL:link];
        }];
        [viewController setRestoreHandler:^{
            [self.paywallListener onRestore];
        }];
        [viewController setPurchaseHandler:^(GYSku *sku) {
            [self.paywallListener onPurchaseWithSKU:sku];
        }];
        
        result(@{@"result": @"success"});
    }];
}

- (void (^)(NSDictionary *,
            NSError *))convertGlassfyGlueResultToFlutter:(FlutterResult)result {
    return ^(NSDictionary *_Nullable resultDictionary, NSError *_Nullable error) {
        if (error) {
            FlutterError *ferror = [FlutterError
                                    errorWithCode:[NSString stringWithFormat:@"%ld", (long)error.code]
                                    message:error.localizedDescription
                                    details:error.description];
            result(ferror);
        } else {
            if (resultDictionary == nil) {
                result(nil);
                return;
            }
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:resultDictionary options:0 error:&error];
            if (error) {
                result([FlutterError
                        errorWithCode:[NSString stringWithFormat:@"%ld", (long)error.code]
                        message:error.localizedDescription
                        details:error.description]);
                return;
            }
            
            NSString *jsonString =
            [[NSString alloc] initWithData:jsonData
                                  encoding:NSUTF8StringEncoding];
            result(jsonString);
        }
    };
}

- (void)sendEventWithName:(NSString*)name payload:(NSDictionary*)payload {
    if (self.paywallEventSink) {
        NSMutableDictionary* event = [NSMutableDictionary dictionary];
        event[@"name"] = name;
        event[@"payload"] = payload;
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:event options:NSJSONWritingPrettyPrinted error:&error];
        
        if (jsonData) {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            self.paywallEventSink(jsonString);
        }
    }
}

#pragma mark -
#pragma mark Glassfy Delegate Methods

- (void)didPurchaseProduct:(NSDictionary<NSString *, id> *)transaction {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:transaction
                        options:0 // Pass 0 if you don't care about the readability
                        // of the generated string
                        error:&error];
    if (error) {
        return;
    }
    
    NSString *jsonString =
    [[NSString alloc] initWithData:jsonData
                          encoding:NSUTF8StringEncoding];
    [self.channel invokeMethod:GlassfyDidPurchaseEventFromDelegate
                     arguments:jsonString];
}

- (void)handlePromotedProductId:(NSString *)productid
              withPromotionalId:(NSString *)promoid
                purchaseHandler:(void (^)(GYPaymentTransactionBlock))purchase {
}

@end
