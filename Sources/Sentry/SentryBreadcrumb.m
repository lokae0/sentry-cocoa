//
//  SentryBreadcrumb.m
//  Sentry
//
//  Created by Daniel Griesser on 22/05/2017.
//  Copyright © 2017 Sentry. All rights reserved.
//

#if __has_include(<Sentry/Sentry.h>)

#import <Sentry/SentryBreadcrumb.h>
#import <Sentry/NSDate+Extras.h>
#import <Sentry/NSDictionary+Sanitize.h>

#else
#import "SentryBreadcrumb.h"
#import "NSDate+Extras.h"
#import "NSDictionary+Sanitize.h"
#endif


@implementation SentryBreadcrumb

- (instancetype)initWithLevel:(enum SentrySeverity)level category:(NSString *)category {
    self = [super init];
    if (self) {
        self.level = level;
        self.category = category;
        self.timestamp = [NSDate date];
    }
    return self;
}

- (NSDictionary<NSString *, id> *)serialize {
    NSMutableDictionary *serializedData = [NSMutableDictionary new];

    [serializedData setValue:SentrySeverityNames[self.level] forKey:@"level"];
    [serializedData setValue:[self.timestamp toIso8601String] forKey:@"timestamp"];
    [serializedData setValue:self.category forKey:@"category"];
    [serializedData setValue:self.type forKey:@"type"];
    [serializedData setValue:self.message forKey:@"message"];
    [serializedData setValue:[self.data sanitize] forKey:@"data"];

    return serializedData;
}

@end
