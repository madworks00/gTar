//
//  GtarDotMatrix.m
//  DotMatrix
//
//  Created by Michael Donahue on 5/30/13.
//  Copyright (c) 2013 Michael Donahue. All rights reserved.
//
 
#import "GtarDotMatrix.h"
#import "GtarController.h"

@interface GtarDotMatrix ()

@end

@implementation GtarDotMatrix

GtarController *m_pGtarController;

// This draws a row on the currentFret.  This is where we light up the LEDs
- (void) drawRow:(int)currentFret
{
    for (int currentString = 0; currentString < GtarStringCount; currentString++) {
        if (currentFret & (1 << currentString))
        {
            _feedSet[currentString] = _onColor;
            [m_pGtarController turnOnLedAtPosition:GtarPositionMake(currentFret, currentString) withColor:GtarLedColorMake(GtarMaxLedIntensity, GtarMaxLedIntensity, GtarMaxLedIntensity)];

        }
        else
        {
            _feedSet[currentString] = _offColor;
            [m_pGtarController turnOnLedAtPosition:GtarPositionMake(currentFret, currentString) withColor:GtarLedColorMake(0,0,0)];
        }
    }
}

// Used to add a word from whatever app
- (void) addWord: (NSString *) myWord
{
    
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[myWord length]];
    for (int i=0; i < [myWord length]; i++) {
        NSString *ichar  = [[NSString stringWithFormat:@"%c", [myWord characterAtIndex:i]] capitalizedString];
        [characters addObject:ichar];
    }
    
    for (NSString* letter in characters)
    {
        NSString * dotMatrix = [_lexicon objectForKey:letter];
        NSArray * lines = [dotMatrix componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        for (NSString* line in lines) {
            int target = strtol([line UTF8String], NULL, 2);
            [_dataSet addObject:[NSValue value:&target withObjCType: @encode(int)]];
        }
        // Insert a space between letters..
        int target = 0;
        [_dataSet addObject:[NSValue value:&target withObjCType: @encode(int)]];
    }
}

// This controles the speed or the scroll by controlling how ofter we write a fret out 
- (void) heartbeat:(NSTimer *)theTimer
{
    [self willChangeValueForKey:@"feedSet"];
    for (int x = GtarLedCount; x >= 0 ; x--) {
        if (x < GtarStringCount) { _feedSet[x] = _offColor; } else { _feedSet[x] = _feedSet[x - GtarStringCount]; }
    }
    if (_linesFed < _dataSet.count)
    {
        NSValue * currentRow = _dataSet[_linesFed];
        int currentFret;
        [currentRow getValue:&currentFret];
        [self drawRow:currentFret];
        _linesFed ++;
    }
    [self didChangeValueForKey:@"feedSet"];
}

- (void)gtarFretDown:(GtarPosition)position
{
    // Triggers when a user pushes down a given fret
}

- (void)gtarFretUp:(GtarPosition)position
{
    // Triggers when a given fret has been released
}

- (void)gtarNoteOn:(GtarPluck)pluck
{
    // Triggered when a user plays a given note
}

- (void)gtarNoteOff:(GtarPosition)position
{
    // Triggered when a given note is killed
}

- (void)gtarConnected
{
    // Triggered when a gTar connection is detected
}

- (void)gtarDisconnected
{
    // Triggered when an active gTar connection is terminated
}


- (void) loadLexicon
{
    m_pGtarController = [[GtarController alloc] init];
    [m_pGtarController debugSpoofConnected];
    [m_pGtarController turnOffAllLeds];
    
    _onColor = [UIColor whiteColor];
    _offColor = [UIColor blackColor];
    _feedSet = [[NSMutableArray alloc]init];
    for (int x = 0; x < GtarLedCount; x++) {
        [_feedSet addObject:_offColor];
    }
    _linesFed = 0;
    _dataSet = [[NSMutableArray alloc] init];
    _lexicon =
    @{
      @"0" : @"001110,011001,010101,010011,001110",
      @"1" : @"000000,000010,011111,000000,000000",
      @"2" : @"010010,011001,010101,010010,000000",
      @"3" : @"001001,010001,010011,001101,000000",
      @"4" : @"001000,001100,001010,011111,001000",
      @"5" : @"010111,010101,010101,001001,000000",
      @"6" : @"001110,010101,010101,001000,000000",
      @"7" : @"010001,001001,000101,000011,000001",
      @"8" : @"001010,010101,010101,001010,000000",
      @"9" : @"000110,010101,010101,001110,000000",
      @":" : @"001010,000000,001010,000000,000000",
      @";" : @"000000,010000,001010,000000,000000",
      @"<" : @"000000,000100,001010,010001,000000",
      @"=" : @"000000,001100,001100,001100,000000",
      @">" : @"000000,010001,001010,000100,000000",
      @"?" : @"000010,000001,010101,000010,000000",
      @"[" : @"000000,011111,010001,010001,000000",
      @"\\": @"000001,000010,000100,001000,010000",
      @"/" : @"000000,010001,010001,011111,000000",
      @"^" : @"000000,000010,000001,000010,000000",
      @"_" : @"010000,010000,010000,010000,010000",
      @"/" : @"000001,000010,000000,000000,000000",
      @" " : @"000000,000000,000000,000000,000000",
      @"A" : @"011110,000101,000101,000101,011110",
      @"B" : @"011111,010101,010101,010101,001010",
      @"C" : @"001110,010001,010001,010001,001010",
      @"D" : @"011111,010001,010001,010001,001110",
      @"E" : @"011111,010101,010101,010101,010001",
      @"F" : @"011111,000101,000101,000101,000001",
      @"G" : @"001110,010001,010001,010101,001100",
      @"H" : @"011111,000100,000100,000100,011111",
      @"I" : @"010001,010001,011111,010001,010001",
      @"J" : @"001000,010000,010000,010000,001111",
      @"K" : @"011111,000100,000100,001010,010001",
      @"L" : @"011111,010000,010000,010000,010000",
      @"M" : @"011111,000010,000100,000010,011111",
      @"N" : @"011111,000010,000100,001000,011111",
      @"O" : @"001110,010001,010001,010001,001110",
      @"P" : @"011111,000101,000101,000101,000010",
      @"Q" : @"001110,010001,010001,011001,011110",
      @"R" : @"011111,000101,000101,001101,010010",
      @"S" : @"010010,010101,010101,010101,001001",
      @"T" : @"000001,000001,011111,000001,000001",
      @"U" : @"001111,010000,010000,010000,001111",
      @"V" : @"000111,001000,010000,001000,000111",
      @"W" : @"011111,001000,000100,001000,011111",
      @"X" : @"010001,001010,000100,001010,010001",
      @"Y" : @"000001,000010,011100,000010,000001",
      @"Z" : @"010001,011001,010101,010011,010001"
      };
    
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(heartbeat:)
                                   userInfo:nil
                                    repeats:YES];
}

@end
