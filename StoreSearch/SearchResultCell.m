//
//  SearchResultCell.m
//  StoreSearch
//
//  Created by JIN on 15/4/30.
//  Copyright (c) 2015年 JIN. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectZero];
    
    selectedView.backgroundColor = [UIColor colorWithRed:20/255.0f green:160/255.0f blue:160/255.0f alpha:0.5f];
    self.selectedBackgroundView = selectedView;
    
    // Initialization code
}


@end
