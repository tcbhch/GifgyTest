//
//  GifsViewController.h
//  GifhyTest
//
//  Created by Adi Bonder on 10/11/18.
//  Copyright © 2018 Adi Bonder. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GifsViewController : UIViewController<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarTopConstraint;

@property (nonatomic, assign) BOOL shouldHideSearchBar;

@end

NS_ASSUME_NONNULL_END
