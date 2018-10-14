//
//  GifhyManager.m
//  GifhyTest
//
//  Created by Adi Bonder on 10/11/18.
//  Copyright © 2018 Adi Bonder. All rights reserved.
//

#import "GifhyManager.h"
#import <AFNetworking/AFURLRequestSerialization.h>

#define GIFHY_BASE_URL         @"http://api.giphy.com/v1/gifs"

@interface GifhyManager() {
    NSString *apiKey;
}

@end

@implementation GifhyManager

static GifhyManager *sharedInstance;

+ (instancetype)sharedInstance {
    if (!sharedInstance) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            sharedInstance = [[GifhyManager alloc] initPrivate];
        });
    }
    return sharedInstance;
}

- (instancetype)initPrivate {
    if (self = [super init]) {
        apiKey = @"Zz7XnA0RZzJJetQAQv1e2c7ErivA9F5u";
    }
    return self;
}

- (void)getGifsWithQuery:(NSString *)query offset:(NSUInteger)offset limit:(NSUInteger)limit :(void (^)(NSMutableArray<GifhyObject *>*, NSError *))callback {
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self buildQueryRequestWithQuerry:query offset:offset limit:limit];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            callback(nil, error);
        } else {
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                callback(nil, error);
            } else {
                NSArray *data = results[@"data"];
                NSMutableArray * gifArray = [[NSMutableArray alloc] init];
                [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    GifhyObject *gif = [[GifhyObject alloc] initWithDictionary:obj];
                    [gifArray addObject:gif];
                }];
                callback(gifArray, nil);
            }
        }
    }];
    [task resume];
}

- (void)getTrendingGifsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit :(void (^)(NSMutableArray<GifhyObject *>*, NSError *))callback {
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self buildTrendingRequestWithOffset:offset limit:limit];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            callback(nil, error);
        } else {
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                callback(nil, error);
            } else {
                NSArray *data = results[@"data"];
                NSMutableArray * gifArray = [[NSMutableArray alloc] init];
                [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    GifhyObject *gif = [[GifhyObject alloc] initWithDictionary:obj];
                    [gifArray addObject:gif];
                }];
                callback(gifArray, nil);
            }
        }
    }];
    [task resume];
}

-(NSURLRequest *)buildQueryRequestWithQuerry:(NSString*)query offset:(NSUInteger)offset limit:(NSUInteger)limit {
    return [self buildRequestWithPath:@"/search" params:@{@"q":query, @"offset":@(offset), @"limit":@(limit)}];
}

-(NSURLRequest *)buildTrendingRequestWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {
    return [self buildRequestWithPath:@"/trending" params:@{@"offset":@(offset), @"limit":@(limit)}];
}

-(NSURLRequest*)buildRequestWithPath:(NSString*)path params:(NSDictionary *) params {
    NSString * fullPath = [NSString stringWithFormat:@"%@%@", GIFHY_BASE_URL, path];
    NSError * error;
    
    NSMutableDictionary * fullParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [fullParams setObject:apiKey forKey:@"api_key"];
    
    NSURLRequest * request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:fullPath parameters:fullParams error:&error];
    return request;
}
@end
