//
//  ViewController.m
//  Flicks
//
//  Created by Jennifer Beck on 1/23/17.
//  Copyright © 2017 JenniferBeck. All rights reserved.
//

#import "ViewController.h"
#import "MovieCell.h"

@interface ViewController () <UITableViewDataSource>;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.movieTableView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"movieCell"];
    
    MovieCell* cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    
    [cell.titleLabel setText:[NSString stringWithFormat:@"Row %ld", indexPath.row]];
    [cell.overviewLabel setText:[NSString stringWithFormat:@"Overview for row %ld", indexPath.row]];
    [cell.posterImage setImage:[UIImage imageNamed:@"yosemite.JPG"]];

    return cell;
}

- (NSInteger)tableView:(UITableView *)movieTableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

@end
