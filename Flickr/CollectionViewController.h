//
//  CollectionViewModel.h
//  Flickr
//
//  Created by Ilya on 27/06/2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UICollectionViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout;
- (void)downloadWillBeginWithSearchString:(NSString *)searchString;

@end

NS_ASSUME_NONNULL_END
