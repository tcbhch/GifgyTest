//
//  GifhyObject.h
//  GifhyTest
//
//  Created by Adi Bonder on 10/11/18.
//  Copyright © 2018 Adi Bonder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GifhyImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface GifhyObject : NSObject
@property (strong, nonatomic) NSString * type;
@property (strong, nonatomic) NSString * gifID;
@property (strong, nonatomic) NSString * slug;
@property (strong, nonatomic) NSURL * url;
@property (strong, nonatomic) NSURL * bitlyGIFURL;
@property (strong, nonatomic) NSURL * bitlyURL;
@property (strong, nonatomic) NSURL * embedURL;
@property (strong, nonatomic) NSString * username;
@property (strong, nonatomic) NSURL * source;
@property (strong, nonatomic) NSString * rating;
@property (strong, nonatomic) NSURL *contentUrl;
@property (strong, nonatomic) NSDate *importDateTime;
@property (strong, nonatomic) NSDate * trendingDateTime;
@property (strong, nonatomic) GifhyImage *gifhyImageDownsampled;
@property (strong, nonatomic) GifhyImage *gifhyImageOriginal;
@property (strong, nonatomic) NSString * title;
- (instancetype) initWithDictionary: (NSDictionary *) dictionary;

@end

NS_ASSUME_NONNULL_END
