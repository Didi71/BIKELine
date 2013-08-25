//
//  BikerMO.m
//  BIKELine
//
//  Created by Christoph Lückler on 21.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BikerMO.h"

@implementation BikerMO
@synthesize firstName, lastName, sex;
@synthesize eMail, pin, userId, teamId;


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
    
    if (teamId) {
        [dict setObject:teamId forKey:@"teamId"];
    }
    
    return dict;
}

- (void)setAvatar:(UIImage *)avatar {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"Avatar.jpeg"];
    
    [UIImageJPEGRepresentation(avatar, 1.0) writeToFile:filePath atomically:YES];
}

- (UIImage *)avatar {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"Avatar.jpeg"];
    
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
}

@end
