//
//  Controller.m
//  MusicCompare
//
//  Created by Dustin Bachrach on 1/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Controller.h"
#import "NSString+RemovalOfCharsInSet.h"
//#include <time.h> 

@implementation Controller

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	NSLog(@"start");
	NSString *path1 = [@"~/Music/iTunes/iTunes Music Library.dustin.xml" stringByExpandingTildeInPath];
	NSString *path2 = [@"~/Music/iTunes/iTunes Music Library.erin.xml" stringByExpandingTildeInPath];

	//unMatchedSongs1 = [[NSMutableArray alloc] init];
	//unMatchedSongs2 = [[NSMutableArray alloc] init];
	
	
	int numUnFound = [self compareLibrary:path1 withLibrary:path2];

	
	//[leftTable reloadData];
	//[rightTable reloadData];
	
	/*
	NSLog(@"Songs Dustin Has but erin doesn't:");
	NSLog(@"----------------------------------");
	NSLog(@"%@",unMatchedSongs1);
	
	NSLog(@"Songs Erin Has but Dustin doesn't:");
	NSLog(@"----------------------------------");
	NSLog(@"%@",unMatchedSongs2);
	*/
	
	
	NSSortDescriptor *descriptors = [[NSSortDescriptor alloc] initWithKey:@"Artist" ascending:YES];
	[unMatchedSongs1 setSortDescriptors:[NSArray arrayWithObject:descriptors]];
	[unMatchedSongs2 setSortDescriptors:[NSArray arrayWithObject:descriptors]];
	[descriptors release];
	
	
	
	NSLog(@"end");
}
-(int)compareLibrary:(NSString*)path1 withLibrary:(NSString*)path2 {
	NSDictionary *library1 = [NSDictionary dictionaryWithContentsOfFile:path1];
	NSDictionary *library2 = [NSDictionary dictionaryWithContentsOfFile:path2];
	
	NSMutableArray *tracks1 = [[NSMutableArray alloc] init];
	[tracks1 addObjectsFromArray:[[library1 objectForKey:@"Tracks"] allValues]];
	NSMutableArray *tracks2 = [[NSMutableArray alloc] init];
	[tracks2 addObjectsFromArray:[[library2 objectForKey:@"Tracks"] allValues]];
	
	id trackA;
	int i;
	int numUnFound = 0;
	
	//NSMutableArray *removeIndexesI = [[NSMutableArray alloc] init];
	//NSMutableArray *removeIndexesJ = [[NSMutableArray alloc] init];
	
	/*
	NSMutableCharacterSet *charSet = [[NSMutableCharacterSet alloc] init];
	[charSet addCharactersInString:@" "];
	[charSet formUnionWithCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
	*/
	
	NSLog(@"replace start");
	for(i = 0; i < [tracks1 count]; i++) {
		id trackA = [tracks1 objectAtIndex:i];
		NSString *titleA = [trackA objectForKey:@"Name"];
		NSString *artistA = [trackA objectForKey:@"Artist"];
		
		titleA = [self removeParenthesisFromString:titleA];
		artistA = [self removeParenthesisFromString:artistA];
		
		
		titleA = [titleA stringByRemovingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
		artistA = [artistA stringByRemovingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
		
		
		
		if([titleA compare:@"The " options:NSCaseInsensitiveSearch range:NSMakeRange(0,4)]==NSOrderedSame) {
			NSLog(@"here: %@",titleA);
			titleA = [titleA substringFromIndex:4];
		}
		if([titleA compare:@"A " options:NSCaseInsensitiveSearch range:NSMakeRange(0,2)]==NSOrderedSame) {
			NSLog(@"here2: %@",titleA);
			titleA = [titleA substringFromIndex:2];
		}
		
		if([artistA compare:@"The " options:NSCaseInsensitiveSearch range:NSMakeRange(0,4)]==NSOrderedSame) {
			NSLog(@"here3: %@",artistA);
			artistA = [artistA substringFromIndex:4];
		}
		if([artistA compare:@"A " options:NSCaseInsensitiveSearch range:NSMakeRange(0,2)]==NSOrderedSame) {
			NSLog(@"here4: %@",artistA);
			artistA = [artistA substringFromIndex:2];
		}
		
		if(titleA)
			[trackA setObject:titleA forKey:@"Name"];
		if(artistA)
			[trackA setObject:artistA forKey:@"Artist"];
		[tracks1 replaceObjectAtIndex:i withObject:trackA];
	}
	NSLog(@"replace end");
	
	NSLog(@"replace 2 start");
	int j;
	for(j = 0; j < [tracks2 count]; j++) {
		id trackB = [tracks2 objectAtIndex:j];
		NSString *titleB = [[trackB objectForKey:@"Name"] stringByRemovingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
		NSString *artistB = [[trackB objectForKey:@"Artist"] stringByRemovingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
		
		if([titleB compare:@"The " options:NSCaseInsensitiveSearch range:NSMakeRange(0,4)]==NSOrderedSame) {
			NSLog(@"here: %@",titleB);
			titleB = [titleB substringFromIndex:4];
		}
		if([titleB compare:@"A " options:NSCaseInsensitiveSearch range:NSMakeRange(0,2)]==NSOrderedSame) {
			NSLog(@"here2: %@",titleB);
			titleB = [titleB substringFromIndex:2];
		}
		
		if([artistB compare:@"The " options:NSCaseInsensitiveSearch range:NSMakeRange(0,4)]==NSOrderedSame) {
			NSLog(@"here3: %@",artistB);
			artistB = [artistB substringFromIndex:4];
		}
		if([artistB compare:@"A " options:NSCaseInsensitiveSearch range:NSMakeRange(0,2)]==NSOrderedSame) {
			NSLog(@"here4: %@",artistB);
			artistB = [artistB substringFromIndex:2];
		}
		
		
		
		//NSLog(@"%@ by %@ found", titleB,artistB);
		if(titleB)
			[trackB setObject:titleB forKey:@"Name"];
		if(artistB)
			[trackB setObject:artistB forKey:@"Artist"];
		[tracks2 replaceObjectAtIndex:j withObject:trackB];
	}
	NSLog(@"replace 2 end");
	
	
	
	
	for(i = 0; i < [tracks1 count]; i++) {
		trackA = [tracks1 objectAtIndex:i];
		NSString *titleA = [trackA objectForKey:@"Name"];
		NSString *artistA = [trackA objectForKey:@"Artist"];
		
		//NSLog(@"%@ -> %@",[trackA objectForKey:@"Name"], titleA);
		//NSLog(@"%@ -> %@",[trackA objectForKey:@"Artist"], artistA);
		
		/*
		NSMutableString *titleA = [[NSMutableString alloc] init];
		NSMutableString *artistA = [[NSMutableString alloc] init];
		
		NSScanner *scan = [NSScanner scannerWithString:tA];
		while(![scan isAtEnd]) {
			NSString *str;
			if([scan scanCharactersFromSet:charSet intoString:&str])
				[titleA appendString:str];
		}
		scan = [NSScanner scannerWithString:aA];
		while(![scan isAtEnd]) {
			NSString *str;
			if([scan scanCharactersFromSet:charSet intoString:&str])
				[artistA appendString:str];
		}
		
		if(![tA isEqualToString:titleA]) {
			NSLog(@"Different Title: %@ to %@",tA,titleA);
		}
		else {
			NSLog(@"Same Title: %@ to %@",tA,titleA);
		}
		if(![aA isEqualToString:artistA]) {
			NSLog(@"Different Artist: %@ to %@",aA,artistA);
		}
		else {
			NSLog(@"Same Artist: %@ to %@",aA,artistA);
		}
		*/
		
		id trackB;
		BOOL found = NO;
		int j;
		for(j = 0; j < [tracks2 count]; j++) {
			trackB = [tracks2 objectAtIndex:j];
			NSString *titleB = [trackB objectForKey:@"Name"];
			NSString *artistB = [trackB objectForKey:@"Artist"];
			
			//NSLog(@"%@",[trackB objectForKey:@"Name"]);
			//NSLog(@"%@",[trackB objectForKey:@"Artist"]);
			
			/*
			NSMutableString *titleB = [[NSMutableString alloc] init];
			NSMutableString *artistB = [[NSMutableString alloc] init];
			
			NSScanner *scan = [NSScanner scannerWithString:tB];
			while(![scan isAtEnd]) {
				NSString *str;
				[scan scanCharactersFromSet:charSet intoString:&str];
					[titleB appendString:str];
			}
			scan = [NSScanner scannerWithString:aB];
			while(![scan isAtEnd]) {
				NSString *str;
				if([scan scanCharactersFromSet:charSet intoString:&str])
					[artistB appendString:str];
			}
			
			if(![tB isEqualToString:titleB]) {
				NSLog(@"Different Title: %@ to %@",tB,titleB);
			}
			else {
				NSLog(@"Same Title: %@ to %@",tB,titleB);
			}
			if(![aB isEqualToString:artistB]) {
				NSLog(@"Different Artist: %@ to %@",aB,artistB);
			}
			else {
				NSLog(@"Same Artist: %@ to %@",aB,artistB);
			}
			
			*/
			
			if([titleA caseInsensitiveCompare:titleB]==NSOrderedSame && [artistA caseInsensitiveCompare:artistB]==NSOrderedSame) {
				//NSLog(@"%@ by %@ found", titleA,artistA);
				found = YES;
				//[tracks1 removeObjectAtIndex:i];
				//[tracks2 removeObjectAtIndex:j];
				
				
				//[removeIndexesI addObject:trackA];
				//[removeIndexesJ addObject:trackB];
				
				break;
			}
			
		}
		if(!found) {
			//NSLog(@"%@ by %@ not found", titleA,artistA);
			[unMatchedSongs1 addObject:trackA];
			numUnFound++;
		}
	}
	/*
	id a;
	//int count = 0;
	
	for(a in removeIndexesI) {
		[tracks1 removeObject:a];
		//count++;
	}
	//count = 0;
	for(a in removeIndexesJ) {
		[tracks2 removeObject:a];
		//count++;
	}
	*/
	for(trackA in tracks2) {
		NSString *titleA = [trackA objectForKey:@"Name"];
		NSString *artistA = [trackA objectForKey:@"Artist"];
		
		id trackB;
		BOOL found = NO;
		for(trackB in tracks1) {
			NSString *titleB = [trackB objectForKey:@"Name"];
			NSString *artistB = [trackB objectForKey:@"Artist"];
			if([titleA caseInsensitiveCompare:titleB]==NSOrderedSame && [artistA caseInsensitiveCompare:artistB]==NSOrderedSame) {
				//NSLog(@"%@ by %@ found", titleA,artistA);
				found = YES;
				break;
			}
		}
		if(!found) {
			//NSLog(@"%@ by %@ not found", titleA,artistA);
			numUnFound++;
			[unMatchedSongs2 addObject:trackA];
		}
	}
	
	return numUnFound;
}



-(NSString*)removeParenthesisFromString:(NSString*)str {
	NSRange r = [str rangeOfString:@"("];
	NSRange r2 = [str rangeOfString:@")"];
	if(r.location != NSNotFound && r2.location != NSNotFound) {
		NSRange paranthesisWord = NSMakeRange(r.location, r2.location - r.location);
		NSString *s = [str substringWithRange:paranthesisWord];
		return [str stringByReplacingOccurrencesOfString:s withString:@""];
	}
	return nil;
}
/*
- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
			row:(int)rowIndex
{
	if([aTableView isEqualTo:leftTable]) {
		NSString *type = [[aTableColumn headerCell] stringValue];
		return [[[unMatchedSongs1 arrangedObjects] objectAtIndex:rowIndex] objectForKey:type];
	}
	else if([aTableView isEqualTo:rightTable]) {
		NSString *type = [[aTableColumn headerCell] stringValue];
		return [[[unMatchedSongs2 arrangedObjects] objectAtIndex:rowIndex] objectForKey:type];
	}
	return nil;
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
	if([aTableView isEqualTo:leftTable]) {
		return [[unMatchedSongs1 arrangedObjects] count];
	}
	else if([aTableView isEqualTo:rightTable]) {
		return [[unMatchedSongs2 arrangedObjects] count];
	}
	return 0;
}
*/
@end
