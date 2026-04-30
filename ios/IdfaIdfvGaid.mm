#import "IdfaIdfvGaid.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <UIKit/UIKit.h>

static NSString *const kZeroUUID = @"00000000-0000-0000-0000-000000000000";

@implementation IdfaIdfvGaid

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(getIDFA:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  if (@available(iOS 14, *)) {
    ATTrackingManagerAuthorizationStatus status =
        [ATTrackingManager trackingAuthorizationStatus];
    if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
      NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
      resolve(idfa ?: kZeroUUID);
    } else {
      resolve(kZeroUUID);
    }
  } else {
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
      NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
      resolve(idfa ?: kZeroUUID);
    } else {
      resolve(kZeroUUID);
    }
  }
}

RCT_EXPORT_METHOD(getIDFV:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    resolve(idfv ?: [NSNull null]);
  });
}

@end
