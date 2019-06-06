//
//  NSError+ALTError.m
//  AltSign
//
//  Created by Riley Testut on 5/10/19.
//  Copyright © 2019 Riley Testut. All rights reserved.
//

#import "NSError+ALTErrors.h"

NSErrorDomain const AltSignErrorDomain = @"com.rileytestut.AltSign";
NSErrorDomain const ALTAppleAPIErrorDomain = @"com.rileytestut.ALTAppleAPI";

@implementation NSError (ALTError)

+ (void)load
{
    [NSError setUserInfoValueProviderForDomain:AltSignErrorDomain provider:^id _Nullable(NSError * _Nonnull error, NSErrorUserInfoKey  _Nonnull userInfoKey) {
        if ([userInfoKey isEqualToString:NSLocalizedFailureReasonErrorKey])
        {
            return [error alt_localizedFailureReason];
        }
        
        return nil;
    }];
    
    [NSError setUserInfoValueProviderForDomain:ALTAppleAPIErrorDomain provider:^id _Nullable(NSError * _Nonnull error, NSErrorUserInfoKey  _Nonnull userInfoKey) {
        if ([userInfoKey isEqualToString:NSLocalizedDescriptionKey])
        {
            return [error alt_appleapi_localizedDescription];
        }
        
        return nil;
    }];
}

- (nullable NSString *)alt_localizedFailureReason
{
    switch ((ALTError)self.code)
    {
        case ALTErrorUnknown:
            return NSLocalizedString(@"An unknown error occured.", @"");
            
        case ALTErrorMissingAppBundle:
            return NSLocalizedString(@"The provided .ipa does not contain an app bundle.", @"");
            
        case ALTErrorMissingInfoPlist:
            return NSLocalizedString(@"The provided app is missing its Info.plist.", @"");
    }
    
    return nil;
}

- (nullable NSString *)alt_appleapi_localizedDescription
{
    switch ((ALTAppleAPIError)self.code)
    {
        case ALTAppleAPIErrorUnknown:
            return NSLocalizedString(@"An unknown error occured.", @"");
            
        case ALTAppleAPIErrorInvalidParameters:
            return NSLocalizedString(@"The provided parameters are invalid.", @"");
            
        case ALTAppleAPIErrorIncorrectCredentials:
            return NSLocalizedString(@"Incorrect Apple ID or password.", @"");
            
        case ALTAppleAPIErrorNoTeams:
            return NSLocalizedString(@"You are not a member of any development teams.", @"");
            
        case ALTAppleAPIErrorAppSpecificPasswordRequired:
            return NSLocalizedString(@"An app-specific password is required. You can create one at appleid.apple.com.", @"");
            
        case ALTAppleAPIErrorInvalidDeviceID:
            return NSLocalizedString(@"This device's UDID is invalid.", @"");
            
        case ALTAppleAPIErrorDeviceAlreadyRegistered:
            return NSLocalizedString(@"This device is already registered with this team.", @"");
            
        case ALTAppleAPIErrorInvalidCertificateRequest:
            return NSLocalizedString(@"The certificate request is invalid.", @"");
            
        case ALTAppleAPIErrorCertificateDoesNotExist:
            return NSLocalizedString(@"There is no certificate with the requested serial number for this team.", @"");
            
        case ALTAppleAPIErrorInvalidAppIDName:
            return NSLocalizedString(@"The name for this app is invalid.", @"");
            
        case ALTAppleAPIErrorInvalidBundleIdentifier:
            return NSLocalizedString(@"The bundle identifier for this app is invalid.", @"");
            
        case ALTAppleAPIErrorBundleIdentifierUnavailable:
            return NSLocalizedString(@"The bundle identifier for this app has already been registered.", @"");
            
        case ALTAppleAPIErrorAppIDDoesNotExist:
            return NSLocalizedString(@"There is no App ID with the requested identifier on this team.", @"");
    }
    
    return nil;
}

@end
