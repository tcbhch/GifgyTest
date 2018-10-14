//
//  GifhyImage.h
//  GifhyTest
//
//  Created by Adi Bonder on 10/11/18.
//  Copyright © 2018 Adi Bonder. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface GifhyImage : NSObject
@property (strong, nonatomic) NSURL * url;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;

- (instancetype) initWithDictionary:(NSDictionary *) dictionary;
@end

NS_ASSUME_NONNULL_END
