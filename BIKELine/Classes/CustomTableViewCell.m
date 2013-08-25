//
//  CustomTableViewCell.m
//  BIKELine
//
//  Created by Christoph Lückler on 25.08.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "CustomTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomTableViewCell
@synthesize leftLabel, headerLabel, bottomLabel;

- (id)initWithBLStyle:(BLTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        if (style == BLTableViewCellStyleCheckin || style == BLTableViewCellStyleTeam) {
            
            circleView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 14.0, 40.0, 41.0)];
            [circleView.layer setCornerRadius:20.5];
            [circleView.layer setMasksToBounds:YES];
            [circleView setBackgroundColor:[UIColor whiteColor]];
            [circleView setAlpha:0.3];
            [self addSubview:circleView];
            
            leftLabel = [[UILabel alloc] initWithFrame:circleView.frame];
            [leftLabel setBackgroundColor:[UIColor clearColor]];
            [leftLabel setTextAlignment:NSTextAlignmentCenter];
            [leftLabel setNumberOfLines:1];
            [self addSubview:leftLabel];
            
            headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(63.0, 15.0, 250.0, 20.0)];
            [headerLabel setBackgroundColor:[UIColor clearColor]];
            [headerLabel setNumberOfLines:1];
            [self addSubview:headerLabel];
            
            bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(63.0, 40.0, 250.0, 15.0)];
            [bottomLabel setBackgroundColor:[UIColor clearColor]];
            [bottomLabel setNumberOfLines:1];
            [self addSubview:bottomLabel];
        } else if (style == BLTableViewCellStylePrice) {
            headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(6.0, 15.0, 314.0, 20.0)];
            [headerLabel setBackgroundColor:[UIColor clearColor]];
            [headerLabel setNumberOfLines:1];
            [self addSubview:headerLabel];
            
            bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(6.0, 40.0, 314.0, 30.0)];
            [bottomLabel setBackgroundColor:[UIColor redColor]];
            [bottomLabel setNumberOfLines:0];
            [self addSubview:bottomLabel];
        }
    }
    return self;
}

@end
