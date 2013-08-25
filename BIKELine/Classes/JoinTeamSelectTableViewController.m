//
//  JoinTeamSelectTableViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 28.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "JoinTeamSelectTableViewController.h"
#import "BBApi.h"

@implementation JoinTeamSelectTableViewController
@synthesize delegate = _delegate;
@synthesize elements, type;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (id)initWithElements:(NSArray *)e andType:(NSInteger)i {
    self = [self initWithStyle:UITableViewStylePlain];
    if (self) {
        self.title = NSLocalizedString(@"joinTeamViewTitle", @"");
        
        // Configure navigation buttons
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpace.width = 5.0;
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 0, 20.0, 44.0)];
        [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItems = @[fixedSpace, [[UIBarButtonItem alloc] initWithCustomView:backButton]];
        
        elements = e;
        type = i;
    }
    return self;
}


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}


#pragma mark
#pragma mark - Actions

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark
#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [elements count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SelectorCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        if ([[elements objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
    }
    
    
    if ([[elements objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        NSString *province = [elements objectAtIndex:indexPath.row];
        cell.textLabel.text = province;
    } else if ([[elements objectAtIndex:indexPath.row] isKindOfClass:[BBOrganisation class]]) {
        BBOrganisation *organisation = [elements objectAtIndex:indexPath.row];
        cell.textLabel.text = organisation.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", organisation.postalCode, organisation.city];
    } else if ([[elements objectAtIndex:indexPath.row] isKindOfClass:[BBOrganisationBiker class]]) {
        BBOrganisationBiker *team = [elements objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", team.firstName, team.lastName];
        cell.detailTextLabel.text = team.city;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(joinTeamSelectTableView:selectElement:)]) {
        [_delegate joinTeamSelectTableView:self selectElement:[elements objectAtIndex:indexPath.row]];
    }
}

@end
