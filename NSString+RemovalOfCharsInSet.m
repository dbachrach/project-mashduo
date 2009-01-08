//
//  NSString+RemovalOfCharsInSet.m
//  MusicCompare
//
//  Created by Dustin Bachrach on 1/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


@implementation NSString (RemovalOfCharsInSet)
/* Remove all characters from the specified set */
- (NSString *)stringByRemovingCharactersInSet:(NSCharacterSet *)charSet
                                      options:(unsigned)mask
{
	NSRange range;
	NSMutableString *newString = [NSMutableString string];
	unsigned len = [self length];
	
	mask &= ~NSBackwardsSearch;
	range = NSMakeRange (0, len);
	while (range.length) {
		NSRange substringRange;
		unsigned pos = range.location;
		
		range = [self rangeOfCharacterFromSet:charSet options:mask 
										range:range];
		if (range.location == NSNotFound)
			range = NSMakeRange (len, 0);
		
		substringRange = NSMakeRange (pos, range.location - pos);
		[newString appendString:[self substringWithRange:substringRange]];
		
		range.location += range.length;
		range.length = len - range.location;
	}
	
	return newString;
}

/* Remove all characters from the specified set, default options */
- (NSString *)stringByRemovingCharactersInSet:(NSCharacterSet *)charSet
{
	return [self stringByRemovingCharactersInSet:charSet options:0];
}

@end
