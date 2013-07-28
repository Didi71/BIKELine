//
//  JoinTeamSelectTableViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 28.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JoinTeamSelectorDelegate;
@interface JoinTeamSelectTableViewController : UITableViewController {
    
}

@property (nonatomic, assign) id <JoinTeamSelectorDelegate, NSObject> delegate;
@property (nonatomic, retain) NSArray *elements;

@end


@protocol JoinTeamSelectorDelegate
@optional
- (void)joinTeamSelectTableView:(UITableView *)table selectElement:(id)element;
@end