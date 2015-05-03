//
//  SearchResult.m
//  StoreSearch
//
//  Created by WANGJiayi on 28/4/15.
//  Copyright (c) 2015年 JIN. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult

- (NSComparisonResult)compareName:(SearchResult *)other
{
    return [self.name localizedStandardCompare:other.name];
}

@end
