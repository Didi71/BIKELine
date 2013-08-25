//
//  JoinTeamSelectTableViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 28.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BLJoinTeamViewType) {
    BLJoinTeamViewTypeProvince,
    BLJoinTeamViewTypeOrganisation,
    BLJoinTeamViewTypeTeam
};

@protocol JoinTeamSelectorDelegate;
@interface JoinTeamSelectTableViewController : UITableViewController {
    
}

- (id)initWithElements:(NSArray *)e andType:(NSInteger)i;

@property (nonatomic, assign) id <JoinTeamSelectorDelegate, NSObject> delegate;
@property (nonatomic, retain) NSArray *elements;
@property (nonatomic, assign) BLJoinTeamViewType type;

@end


@protocol JoinTeamSelectorDelegate
@optional
- (void)joinTeamSelectTableView:(JoinTeamSelectTableViewController *)table selectElement:(id)element;
@end