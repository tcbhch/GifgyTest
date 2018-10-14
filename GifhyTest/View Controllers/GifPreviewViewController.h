//
//  GifPreviewViewController.h
//  GifhyTest
//
//  Created by Adi Bonder on 10/11/18.
//  Copyright © 2018 Adi Bonder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GifhyObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface GifPreviewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) GifhyObject *gif;
@end

NS_ASSUME_NONNULL_END
