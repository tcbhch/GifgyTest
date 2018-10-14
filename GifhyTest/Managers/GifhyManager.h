//
//  GifhyManager.h
//  GifhyTest
//
//  Created by Adi Bonder on 10/11/18.
//  Copyright © 2018 Adi Bonder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GifhyObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface GifhyManager : NSObject

+ (instancetype)sharedInstance;

- (void)getGifsWithQuery:(NSString *)query offset:(NSUInteger)offset limit:(NSUInteger)limit :(void (^)(NSMutableArray<GifhyObject *>*, NSError *))callback;
- (void)getTrendingGifsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit :(void (^)(NSMutableArray<GifhyObject *>*, NSError *))callback;

@end

NS_ASSUME_NONNULL_END
