//
//  AutoSuggest.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 04/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AutoSuggestDelegate <NSObject>

-(void)labelTouched:(NSString *)label;

@end

@interface AutoSuggest : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) id<AutoSuggestDelegate> autoSuggestDelegate;

@end
