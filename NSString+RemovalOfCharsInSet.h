//
//  NSString+RemovalOfCharsInSet.h
//  MusicCompare
//
//  Created by Dustin Bachrach on 1/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSString (RemovalOfCharsInSet)
/* Remove all characters from the specified set */
- (NSString *)stringByRemovingCharactersInSet:(NSCharacterSet *)charSet
                                      options:(unsigned)mask;

/* Remove all characters from the specified set, default options */
- (NSString *)stringByRemovingCharactersInSet:(NSCharacterSet *)charSet;

/* Remove just the specified character */
- (NSString *)stringByRemovingCharacter:(unichar)character;

@end
