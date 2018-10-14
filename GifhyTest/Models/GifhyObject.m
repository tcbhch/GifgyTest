//
//  GifhyObject.m
//  GifhyTest
//
//  Created by Adi Bonder on 10/11/18.
//  Copyright © 2018 Adi Bonder. All rights reserved.
//

#import "GifhyObject.h"

@implementation GifhyObject
@synthesize type;
@synthesize gifID;
@synthesize slug;
@synthesize url;
@synthesize bitlyGIFURL;
@synthesize bitlyURL;
@synthesize embedURL;
@synthesize username;
@synthesize source;
@synthesize rating;
@synthesize contentUrl;
@synthesize importDateTime;
@synthesize trendingDateTime;
@synthesize gifhyImageDownsampled;
@synthesize gifhyImageOriginal;
@synthesize title;
- (instancetype) initWithDictionary: (NSDictionary *) dictionary
{
    self = [super init];
    if (!self) {
        return nil;
    }
    type = dictionary[@"type"];
    gifID = dictionary[@"id"];
    slug = dictionary[@"slug"];
    url = [NSURL URLWithString:dictionary[@"url"]];
    bitlyGIFURL = [NSURL URLWithString:dictionary[@"bitly_gif_url"]];
    bitlyURL = [NSURL URLWithString:dictionary[@"bitly_url"]];
    embedURL = [NSURL URLWithString:dictionary[@"embed_url"]];
    username = dictionary[@"username"];
    source = [NSURL URLWithString:dictionary[@"source"]];
    rating = dictionary[@"rating"];
    contentUrl = [NSURL URLWithString:dictionary[@"content_url"]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    importDateTime = [dateFormatter dateFromString:dictionary[@"import_datetime"]];
    trendingDateTime = [dateFormatter dateFromString:dictionary[@"trending_datetime"]];
    
    NSDictionary * images = dictionary[@"images"];
    gifhyImageDownsampled = [[GifhyImage alloc] initWithDictionary:images[@"fixed_width_downsampled"]];
    gifhyImageOriginal = [[GifhyImage alloc] initWithDictionary:images[@"original"]];
    title = dictionary[@"title"];
    return self;
}

@end
