#import "GlassfyFlutterPlugin.h"

@implementation GlassfyFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:@"glassfy_flutter"
                                  binaryMessenger:[registrar messenger]];
  GlassfyFlutterPlugin *instance = [[GlassfyFlutterPlugin alloc] init];
  instance.channel = channel;
  [registrar addMethodCallDelegate:instance channel:channel];
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
    NSString *apiKey = arguments[@"apiKey"];
    BOOL watcherMode = [arguments[@"watcherMode"] boolValue];
    [GlassfyGlue
        initializeWithApiKey:apiKey
                 watcherMode:watcherMode
              withCompletion:[self convertGlassfyGlueResultToFlutter:result]];
    [GlassfyGlue setPurchaseDelegate:self];
  } else if ([@"setLogLevel" isEqualToString:call.method]) {
    int logLevel = [arguments[@"logLevel"] intValue];
    [GlassfyGlue setLogLevel:logLevel];
  } else if ([@"offerings" isEqualToString:call.method]) {
    [GlassfyGlue
        offeringsWithCompletion:[self
                                    convertGlassfyGlueResultToFlutter:result]];
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
                     completion:[self
                                    convertGlassfyGlueResultToFlutter:result]];
  } else if ([@"setAttribution" isEqualToString:call.method]) {
    NSNumber *type = arguments[@"type"];
    NSString *value = arguments[@"value"];
    [GlassfyGlue setAttributionType:type
                              value:value
                         completion:[self convertGlassfyGlueResultToFlutter:result]];
  } else if ([@"setAttributions" isEqualToString:call.method]) {
    NSString *itemsStr = arguments[@"items"];
    NSArray *items = [NSJSONSerialization JSONObjectWithData:[itemsStr dataUsingEncoding:NSUTF8StringEncoding]
                                                     options:kNilOptions
                                                       error:nil];
    [GlassfyGlue setAttributions:items
                      completion:[self convertGlassfyGlueResultToFlutter:result]];
  }  
  else {
    result(FlutterMethodNotImplemented);
  }
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
      NSData *jsonData = [NSJSONSerialization
          dataWithJSONObject:resultDictionary
                     options:0 // Pass 0 if you don't care about the readability
                               // of the generated string
                       error:&error];
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
