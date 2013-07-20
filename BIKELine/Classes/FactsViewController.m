//
//  FactsViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "FactsViewController.h"

@implementation FactsViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


#pragma mark
#pragma mark - Actions

- (IBAction)segmentControlChangedValue:(id)sender {
    switch (segmentControl.selectedSegmentIndex) {
        case 0: {
            checkinsView.hidden = YES;
            factsView.hidden = NO;
            break;
        }
        
        case 1: {
            checkinsView.hidden = NO;
            factsView.hidden = YES;
            break;
        }
           
        default: {
            break;
        }
    }
}


#pragma mark
#pragma mark - UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

@end
