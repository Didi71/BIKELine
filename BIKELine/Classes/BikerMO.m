//
//  BikerMO.m
//  BIKELine
//
//  Created by Christoph Lückler on 21.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BikerMO.h"

@implementation BikerMO
@synthesize firstName, lastName, street, postalcode, city, sex;
@synthesize eMail, pin, userId;


- (id)initWithDictionary:(NSDictionary *)dict {
    if ((self = [super init])) {
        for (NSString *key in dict.allKeys) {
            [self setValue:[dict objectForKey:key] forKey:key];
        }
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@> - %@", NSStringFromClass([self class]), [self dictionary]];
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
    
    if (sex) {
        [dict setObject:sex forKey:@"sex"];
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

- (void)setAvatar:(UIImage *)avatar {
    
}

- (UIImage *)avatar {
    
}


@end
