//
//  CustomTableViewCell.h
//  BIKELine
//
//  Created by Christoph Lückler on 25.08.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BLTableViewCellStyle) {
    BLTableViewCellStyleCheckin,
    BLTableViewCellStyleTeam,
    BLTableViewCellStylePrice
};

@interface CustomTableViewCell : UITableViewCell {
    UIView *circleView;
}

@property (nonatomic, retain) UILabel *leftLabel;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UILabel *bottomLabel;

- (id)initWithBLStyle:(BLTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
