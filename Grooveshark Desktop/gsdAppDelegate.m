//
//  gsdAppDelegate.m
//  Grooveshark Desktop
//
//  Created by Richard Brooks on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "gsdAppDelegate.h"

@implementation gsdAppDelegate

@synthesize window = _window;
@synthesize mainView = _mainView;
@synthesize mainWebView = _mainWebView;


//int NX_KEYTYPE_PLAY = 16;
//int NX_KEYTYPE_NEXT = 19;
//int NX_KEYTYPE_PREVIOUS = 20;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSURL*url=[NSURL URLWithString:@"http://grooveshark.com"];
    NSURLRequest*request=[NSURLRequest requestWithURL:url];
    [[_mainWebView mainFrame] loadRequest:request];
}

- (void)sendEvent: (NSEvent*)event
{
	if( [event type] == NSSystemDefined && [event subtype] == 8 )
	{
		int keyCode = (([event data1] & 0xFFFF0000) >> 16);
		int keyFlags = ([event data1] & 0x0000FFFF);
		int keyState = (((keyFlags & 0xFF00) >> 8)) == 0xA;
		int keyRepeat = (keyFlags & 0x1);
        
		[self mediaKeyEvent: keyCode state: keyState repeat: keyRepeat];
	}
    
	[super sendEvent: event];
}

- (void)mediaKeyEvent: (int)key state: (BOOL)state repeat: (BOOL)repeat
{
    NSLog (@"Key is %d", key );
    
    
	switch( key )
     {
     case NX_KEYTYPE_PLAY:
     if( state == 0 )
         [ _mainWebView stringByEvaluatingJavaScriptFromString: @"GS.player.togglePlayPause()" ];
     break;
     
     case NX_KEYTYPE_FAST:
     if( state == 0 )
         [ _mainWebView stringByEvaluatingJavaScriptFromString: @"GS.player.nextSong()" ];
     break;
     
     case NX_KEYTYPE_REWIND:
     if( state == 0 )
         [ _mainWebView stringByEvaluatingJavaScriptFromString: @"GS.player.previousSong()" ];
     break;
     }
}

@end
 
