//
//  BBApiAbstractOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBApiAbstractOperation : NSOperation
@property (nonatomic, retain) NSString *pathUrlString;
@property (nonatomic, retain) NSDictionary *parameters;

- (id)initWithPath:(NSString *)url andParameters:(NSDictionary *)params;

@end
