//
//  BBApiActivationOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiActivationResponse : Jastor
@property (nonatomic, retain) NSString *status;
@end

@interface BBApiActivationOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiActivationResponse *response;
@end