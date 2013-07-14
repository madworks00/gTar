//
//  GtarDotMatrix.h
//  DotMatrix
//
//  Created by Michael Donahue on 5/30/13.
//  Copyright (c) 2013 Michael Donahue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gtar.h"
#import "GtarController.h"

@protocol GtarDotMatrix <NSObject>


@end

@interface GtarDotMatrix : NSObject

@property (nonatomic, strong) NSMutableArray * dataSet;
@property (nonatomic, strong) NSMutableArray * feedSet;
@property (nonatomic, assign) int ledRow;
@property (nonatomic, assign) int linesFed;
@property (nonatomic, strong) NSDictionary * lexicon;
@property (nonatomic, strong) UIColor * onColor;
@property (nonatomic, strong) UIColor * offColor;
@property (nonatomic, assign) GtarLedColor onLEDColor;
@property (nonatomic, assign) GtarLedColor offLEDColor;

- (void) drawRow:(int)currentRow;
- (void) loadLexicon;
- (void) addWord: (NSString *) myWord;
- (void)gtarConnected;


@end
