//
//  GifsViewController.m
//  GifhyTest
//
//  Created by Adi Bonder on 10/11/18.
//  Copyright © 2018 Adi Bonder. All rights reserved.
//

#import "GifsViewController.h"
#import "GifhyManager.h"
#import "GifCollectionViewCell.h"
#import <AnimatedGIFImageSerialization/AnimatedGIFImageSerialization.h>
#import "GifPreviewViewController.h"
#import "SVPullToRefresh.h"

@interface GifsViewController () {
    GifhyManager *gifhyManager;
    NSMutableArray<GifhyObject *>* results;
    NSUInteger currentOffset, limit;
}

@end

@implementation GifsViewController
@synthesize searchBarTopConstraint;
@synthesize shouldHideSearchBar;
@synthesize searchBar;
@synthesize collectionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    gifhyManager = [GifhyManager sharedInstance];
    searchBar.delegate = self;
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setDefaultTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Search for Gifs" attributes:@{NSForegroundColorAttributeName: [UIColor orangeColor]}]];
    
    
    limit = 25;
    [self->collectionView registerNib:[GifCollectionViewCell nib] forCellWithReuseIdentifier:[GifCollectionViewCell identifier]];
    if (shouldHideSearchBar) {
        searchBarTopConstraint.constant -= searchBar.frame.size.height;
        [gifhyManager getTrendingGifsWithOffset:currentOffset limit:limit :^(NSMutableArray<GifhyObject *> * gifs, NSError * error) {
            if (error) {
                //TODO handle error
            } else {
                self->results = gifs;
                dispatch_async(dispatch_get_main_queue(), ^{
                    self->currentOffset += self->limit;
                    [self->collectionView reloadData];
                });
            }
        }];
    }
    
    [collectionView addInfiniteScrollingWithActionHandler:^{
        if (self->shouldHideSearchBar) {
            [self->gifhyManager getTrendingGifsWithOffset:self->currentOffset limit:self->limit :^(NSMutableArray<GifhyObject *> * gifs, NSError * error) {
                if (error) {
                    //TODO handle error
                } else {
                    [gifs enumerateObjectsUsingBlock:^(GifhyObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [self->results addObject:obj];
                    }];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self->currentOffset += self->limit;
                        [self->collectionView reloadData];
                        [self->collectionView.infiniteScrollingView stopAnimating];
                    });
                }
            }];
        } else {
            [self->gifhyManager getGifsWithQuery:self->searchBar.text offset:self->currentOffset limit:self->limit :^(NSMutableArray<GifhyObject *> * gifs, NSError * error) {
                if (error) {
                    //TODO handle error
                } else {
                    [gifs enumerateObjectsUsingBlock:^(GifhyObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [self->results addObject:obj];
                    }];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self->currentOffset += self->limit;
                        [self->collectionView reloadData];
                        [self->collectionView.infiniteScrollingView stopAnimating];
                    });
                }
            }];
        }
    }];
}

#pragma mark collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return results.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GifCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GifCollectionViewCell identifier] forIndexPath:indexPath];
    if (cell) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicator setCenter: cell.imageView.center];
        [activityIndicator startAnimating];
        [cell.contentView addSubview:activityIndicator];
        GifhyObject *gif = results[indexPath.item];
        NSURLRequest * request = [NSURLRequest requestWithURL:gif.gifhyImageDownsampled.url];
        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            UIImage * image = [UIImage imageWithData:data];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                cell.imageView.image = image;
                [activityIndicator removeFromSuperview];
            }];
        }] resume];
        cell.label.text = gif.title;
        return cell;
    }
    return [UICollectionViewCell new];
}

#pragma mark collectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GifhyObject *gif = results[indexPath.item];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GifPreviewViewController *vc = [sb instantiateViewControllerWithIdentifier:@"gifpreview"];
    vc.gif = gif;
    [self.navigationController pushViewController:vc animated:YES];
}

//#pragma mark collectionView flowLayout
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    GifhyObject *gif = results[indexPath.item];
//    return CGSizeMake(gif.gifhyImageDownsampled.width, gif.gifhyImageDownsampled.height);
//}


#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [gifhyManager getGifsWithQuery:searchBar.text offset:currentOffset limit:limit :^(NSMutableArray<GifhyObject *> * gifs, NSError * error) {
        if (error) {
            //TODO handle error
        } else {
            self->results = gifs;
            dispatch_async(dispatch_get_main_queue(), ^{
                self->currentOffset += self->limit;
                [self->collectionView reloadData];
            });
        }
    }];
}

@end
