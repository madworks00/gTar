//
//  ViewController.m
//  DotMatrix
//
//  Created by Michael Donahue on 5/25/13.
//  Copyright (c) 2013 Michael Donahue. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"
#import "Gtar.h"
#import "GtarDotMatrix.h"

@interface ViewController ()

@end

@implementation ViewController

- (NSUInteger) supportedInterfaceOrientations {
    // Return a bitmask of supported orientations. If you need more,
    // use bitwise or (see the commented return).
    return UIInterfaceOrientationMaskPortrait;
    // return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _controller = [[GtarDotMatrix alloc] init];
    [_controller loadLexicon];
    [_controller addWord:@"Hello Incident"];
    [_controller addObserver:self
                      forKeyPath:@"feedSet"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    [[self collectionView] reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *aCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    aCell.backgroundColor =  _controller.feedSet[indexPath.row];
    return aCell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _controller.feedSet.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
