//
//  BikerMO.h
//  BIKELine
//
//  Created by Christoph Lückler on 21.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BikerMO : NSObject {
    UIImage *cachedAvatar;
}

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSNumber *sex;
@property (nonatomic, retain) UIImage *avatar;
@property (nonatomic, retain) NSNumber *userId;
@property (nonatomic, retain) NSNumber *teamId;
@property (nonatomic, retain) NSString *eMail;
@property (nonatomic, retain) NSNumber *pin;


typedef enum {
    kBikerSexMale,
    kBikerSexFemale
} kBikerSex;


- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionary;

@end
