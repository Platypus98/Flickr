//
//  CollectionViewModel.m
//  Flickr
//
//  Created by Ilya on 27/06/2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

#import "CollectionViewController.h"
#import "CustomViewCell.h"
#import "Network Service/NetworkService.h"
#import "Network Service/NetworkServiceProtocol.h"
#import "CellViewController.h"

@interface CollectionViewController() <NetworkServiceOutputProtocol>

@property (nonatomic, copy) NSArray<UIImage *> *data;
@property (nonatomic, strong) NetworkService *networkService;
@property (nonatomic, assign) NSInteger countOfPhotos;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *searchString;

@end

@implementation CollectionViewController

-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self)
    {
        _data = [NSArray new];
        _countOfPhotos = 25;
        _page = 0;
        _searchString = @"";
        
        _networkService = [NetworkService new];
        _networkService.output = self;
        [_networkService configureUrlSessionWithParams:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [self.collectionView registerClass:[CustomViewCell class] forCellWithReuseIdentifier:@"Flikr"];
    self.collectionView.backgroundColor = UIColor.whiteColor;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CustomViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Flikr" forIndexPath:indexPath];
    
    @try {
        [cell setImage:[self.data objectAtIndex:indexPath.row]];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.countOfPhotos;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.data.count > 0)
    {
        CellViewController *cellViewController = [CellViewController new];

        [cellViewController setImage:[self.data objectAtIndex:indexPath.row]];
        
        [UIView  beginAnimations: @"Showinfo"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
        [self.navigationController pushViewController: cellViewController animated:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
    }
    
}

- (void)loadingContinuesWithProgress:(double)progress
{
    
}

- (void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved
{
    UIImage *newImage = [[UIImage alloc] initWithData:dataRecieved];
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:self.data.mutableCopy];
    [newArray addObject:newImage];
    self.data = newArray.copy;
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.data.count-1) inSection:0];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (void)downloadWillBeginWithSearchString:(NSString *)searchString
{
    self.searchString = searchString;
    self.countOfPhotos = 25;
    self.page = 0;
    
    self.data = [NSArray new];
    [self.collectionView reloadData];
    [self startDownload];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //Вызов при прокрутке
    if ([self.searchString isEqualToString:@""])
    {
        return;
    } else
    {
        self.countOfPhotos = self.countOfPhotos + 25;
        [self.collectionView reloadData];
        [self startDownload];
    }
}

- (void)startDownload
{
    self.page = self.page + 1;
    [self.networkService configureUrlSessionWithParams:nil];
    [self.networkService findFlickrPhotoWithSearchString:self.searchString andPage:[NSString stringWithFormat:@"%li", self.page]];
}

@end
