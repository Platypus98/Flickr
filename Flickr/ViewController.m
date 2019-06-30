//
//  ViewController.m
//  Flickr
//
//  Created by Ilya on 24/06/2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"

@interface ViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) CollectionViewController *collectionViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Flickr";
    [self setupSearchBar];
    [self setupCollectionViewController];
}

- (void)setupSearchBar
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + UIApplication.sharedApplication.keyWindow.safeAreaInsets.top, self.view.frame.size.width, 50)];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    [self.view addSubview:self.searchBar];
}

- (void)setupCollectionViewController
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(180, 220);
    
    self.collectionViewController = [[CollectionViewController alloc] initWithCollectionViewLayout:layout];
    self.collectionViewController.view.frame = CGRectMake(0, self.searchBar.frame.origin.y + self.searchBar.frame.size.height, self.view.frame.size.width, CGRectGetMaxY(self.view.frame)-10);
    [self addChildViewController:self.collectionViewController];
    [self.view addSubview:self.collectionViewController.view];
    [self.collectionViewController didMoveToParentViewController:self];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"%@", searchBar.text);
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    [self.collectionViewController downloadWillBeginWithSearchString:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@", searchBar.text);
    [self.view endEditing:YES];
    [self.collectionViewController downloadWillBeginWithSearchString:searchBar.text];
}

@end
