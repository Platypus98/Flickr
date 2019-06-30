//
//  CustomViewCell.m
//  Flickr
//
//  Created by Ilya on 27/06/2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

#import "CustomViewCell.h"

@interface CustomViewCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CustomViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        _imageView.backgroundColor = UIColor.grayColor;
        [self.contentView addSubview:_imageView];
        [_imageView didMoveToSuperview];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)prepareForReuse
{
    self.imageView.image = nil;
}

@end
