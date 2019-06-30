//
//  CellViewController.m
//  Flickr
//
//  Created by Ilya on 30/06/2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

#import "CellViewController.h"

@interface CellViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CellViewController

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = UIColor.whiteColor;
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2)];
        _imageView.center = self.view.center;
        [self.view addSubview:_imageView];
        [_imageView didMoveToSuperview];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setImage:(UIImage *)image
{
    [self.imageView setImage:image];
}

@end
