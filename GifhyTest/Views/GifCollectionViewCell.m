//
//  GifCollectionViewCell.m
//  GifhyTest
//
//  Created by Adi Bonder on 10/11/18.
//  Copyright © 2018 Adi Bonder. All rights reserved.
//

#import "GifCollectionViewCell.h"

@implementation GifCollectionViewCell
@synthesize imageView;
@synthesize label;

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(NSString *)identifier {
    return NSStringFromClass([self class]);
}

+(UINib *)nib {
    return [UINib nibWithNibName:[self identifier] bundle:nil];
}

@end
