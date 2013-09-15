//
//  InfoViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 15.09.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "InfoViewController.h"

@implementation InfoViewController

- (id)init {
    self = [super initWithNibName:@"InfoView" bundle:nil];
    if (self) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 0, 30.0, 30.0)];
        [backButton setShowsTouchWhenHighlighted:YES];
        [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:backButton]];
        
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"infoViewTitle", @"");
    
    NSMutableAttributedString *attrStr = [NSMutableAttributedString attributedStringWithString:NSLocalizedString(@"infoViewTeaserText", @"")];
    [attrStr setFont:teaserLabel.font];
    [attrStr setTextColor:teaserLabel.textColor];
    [attrStr setLink: [NSURL URLWithString:NSLocalizedString(@"infoViewTeaserLink", @"")]
               range: [attrStr.string rangeOfString:NSLocalizedString(@"infoViewTeaserLink", @"")]];
    teaserLabel.attributedText = attrStr;
}

- (void)viewWillAppear:(BOOL)animated {
    
}


#pragma mark
#pragma mark - IBAction

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
