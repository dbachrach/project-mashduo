//
//  Controller.h
//  MusicCompare
//
//  Created by Dustin Bachrach on 1/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Controller : NSObject {
	IBOutlet NSArrayController *unMatchedSongs1;
	IBOutlet NSArrayController *unMatchedSongs2;
	
	IBOutlet NSTableView *leftTable;
	IBOutlet NSTableView *rightTable;
}
-(int)compareLibrary:(NSString*)path1 withLibrary:(NSString*)path2;
@end
