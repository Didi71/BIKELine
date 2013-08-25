//
//  BLSegmentedControl.m
//  BIKELine
//
//  Created by Christoph Lückler on 25.08.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BLSegmentedControl.h"

@implementation BLSegmentedControl

+ (void)load {
    // Unselected background
    [[UISegmentedControl appearance] setBackgroundImage: [[UIImage imageNamed:@"segcontrol_unselected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                                               forState: UIControlStateNormal
                                             barMetrics: UIBarMetricsDefault];
    
    // Selected background
    [[UISegmentedControl appearance] setBackgroundImage: [[UIImage imageNamed:@"segcontrol_selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                                               forState: UIControlStateSelected
                                             barMetrics: UIBarMetricsDefault];
    
    // Image between two unselected segments
    [[UISegmentedControl appearance] setDividerImage: [[UIImage imageNamed:@"segcontrol_middle-unselected"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 0)]
                                 forLeftSegmentState: UIControlStateNormal
                                   rightSegmentState: UIControlStateNormal
                                          barMetrics: UIBarMetricsDefault];
    
    // Image between segment selected on the left and unselected on the right
    [[UISegmentedControl appearance] setDividerImage: [[UIImage imageNamed:@"segcontrol_middle-left_selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 18)]
                                 forLeftSegmentState: UIControlStateSelected
                                   rightSegmentState: UIControlStateNormal
                                          barMetrics: UIBarMetricsDefault];
    
    // Image between segment selected on the right and unselected on the left
    [[UISegmentedControl appearance] setDividerImage: [[UIImage imageNamed:@"segcontrol_middle-right_selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 0)]
                                 forLeftSegmentState: UIControlStateNormal
                                   rightSegmentState: UIControlStateSelected
                                          barMetrics: UIBarMetricsDefault];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setTitleTextAttributes: @{UITextAttributeFont: [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0],
                                        UITextAttributeTextColor: [UIColor whiteColor],
                                        UITextAttributeTextShadowColor: [UIColor clearColor]}
                            forState: UIControlStateNormal];
        
        [self setTitleTextAttributes: @{UITextAttributeFont: [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0],
                                        UITextAttributeTextColor: [UIColor whiteColor],
                                        UITextAttributeTextShadowColor: [UIColor clearColor]}
                            forState: UIControlStateSelected];
    }
    return self;
}

@end
