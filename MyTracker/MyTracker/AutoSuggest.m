//
//  AutoSuggest.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 04/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "AutoSuggest.h"

@implementation AutoSuggest

-(void)awakeFromNib {
    self.dataSource = self;
    self.delegate = self;
}

#pragma mark TableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.autoSuggestDelegate labelTouched:[self.data objectAtIndex:indexPath.row]];
}


@end
