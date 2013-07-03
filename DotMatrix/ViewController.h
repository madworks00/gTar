//
//  ViewController.h
//  DotMatrix
//
//  Created by Michael Donahue on 5/25/13.
//  Copyright (c) 2013 Michael Donahue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell.h"
#import "GtarDotMatrix.h"

@interface ViewController : UICollectionViewController

@property (strong, nonatomic) GtarDotMatrix *controller;

@end

