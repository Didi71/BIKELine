//
//  BikerMO.m
//  BIKELine
//
//  Created by Christoph Lückler on 21.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BikerMO.h"

@implementation BikerMO
@synthesize firstName, lastName, street, postalcode, city, gender;
@synthesize eMail, pin, userId;

- (id)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        for (NSString *key in dict.allKeys) {
            [self setValue:[dict objectForKey:key] forKey:key];
        }
    }
    return self;
}

- (NSDictionary *)dictionary {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    if (firstName) {
        [dict setObject:firstName forKey:@"firstName"];
    }
    
    if (lastName) {
        [dict setObject:lastName forKey:@"lastName"];
    }
    
    if (street) {
        [dict setObject:street forKey:@"street"];
    }
    
    if (postalcode) {
        [dict setObject:postalcode forKey:@"postalcode"];
    }
    
    if (city) {
        [dict setObject:city forKey:@"city"];
    }
    
    if (gender) {
        [dict setObject:gender forKey:@"gender"];
    }
    
    if (eMail) {
        [dict setObject:eMail forKey:@"eMail"];
    }
    
    if (pin) {
        [dict setObject:pin forKey:@"pin"];
    }

    if (userId) {
        [dict setObject:userId forKey:@"userId"];
    }
    
    return dict;
}

@end
