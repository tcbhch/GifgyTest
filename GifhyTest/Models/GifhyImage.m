//
//  GifhyImage.m
//  GifhyTest
//
//  Created by Adi Bonder on 10/11/18.
//  Copyright © 2018 Adi Bonder. All rights reserved.
//
#import "GifhyImage.h"

@implementation GifhyImage
@synthesize url;
@synthesize width;
@synthesize height;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    url = [NSURL URLWithString:dictionary[@"url"]];
    width = [dictionary[@"width"] floatValue];
    height = [dictionary[@"height"] floatValue];
    
    return self;
}

@end
