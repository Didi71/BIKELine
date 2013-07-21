//
//  BikerMO.h
//  BIKELine
//
//  Created by Christoph Lückler on 21.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BikerMO : NSObject

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *street;
@property (nonatomic, retain) NSNumber *postalcode;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *gender;

@property (nonatomic, retain) NSNumber *userId;
@property (nonatomic, retain) NSString *eMail;
@property (nonatomic, retain) NSNumber *pin;

- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionary;

@end
