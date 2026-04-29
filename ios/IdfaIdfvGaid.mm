#import "IdfaIdfvGaid.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <UIKit/UIKit.h>

@implementation IdfaIdfvGaid

RCT_EXPORT_MODULE();

// Get IDFA - requires ATT permission on iOS 14.5+
RCT_EXPORT_METHOD(getIDFA:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  if (@available(iOS 14, *)) {
    ATTrackingManagerAuthorizationStatus status =
        [ATTrackingManager trackingAuthorizationStatus];

    if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
      NSString *idfa =
          [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
      resolve(idfa);
    } else {
      // Not authorized - return zeros UUID
      resolve(@"00000000-0000-0000-0000-000000000000");
    }
  } else {
    // iOS < 14: ATT not required
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
      NSString *idfa =
          [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
      resolve(idfa);
    } else {
      resolve(@"00000000-0000-0000-0000-000000000000");
    }
  }
}

// Get IDFV - no permission required
RCT_EXPORT_METHOD(getIDFV:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
  if (idfv) {
    resolve(idfv);
  } else {
    resolve([NSNull null]);
  }
}

@end
