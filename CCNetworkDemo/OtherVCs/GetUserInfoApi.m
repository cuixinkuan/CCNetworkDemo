//
//  GetUserInfoApi.m
//  CCNetworkDemo
//
//  Created by admin on 2018/1/11.
//  Copyright © 2018年 cuixinkuan. All rights reserved.
//

#import "GetUserInfoApi.h"

@implementation GetUserInfoApi {
    NSString * _userId;
    
    NSString * _baseUrl;
    NSString * _key1;
    NSString * _key2;
    NSString * _startTime;
    NSString * _endTime;
}

- (id)initWithUserId:(NSString *)userId {
    if (self = [super init]) {
        _userId = userId;
    }
    return self;
}

- (id)initWithParameters:(NSMutableDictionary *)parameters {
    if (self = [super init]) {
        _startTime = [parameters objectForKey:@"startvalue"];
        _endTime = [parameters objectForKey:@"endvalue"];
        
        _key1 = [parameters objectForKey:@"startkey"];
        _key2 = [parameters objectForKey:@"endkey"];
        
        _baseUrl = @"/restserver/index.php/login";//@"/api/4/version/ios/2.3.0";
    }
    return self;
}

#pragma mark - others -
- (NSString *)requestUrl {
//    return @"/iphone/users";
    return _baseUrl;
}

- (id)requestArgument {
//    return @{@"id":_userId};
    return @{
             _key1:_startTime,
             _key2:_endTime
             };
}

- (CCRequestMethod)requestMethod {
    return CCRequestMethodPOST;
}

//- (id)jsonValidator {
//    return @{
//             @"nick":[NSString class],
//             @"level":[NSNumber class]
//             };
//}

- (NSInteger)cacheTimeInSeconds {
    return 60 * 3;
}

- (BOOL)useCDN {
    return NO;
}

@end
