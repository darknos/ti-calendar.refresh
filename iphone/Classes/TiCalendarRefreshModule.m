/**
 * ti.calendar.refresh
 *
 * Created by Sergey Nosenko
 * Copyright (c) 2017 Sergey Nosenko. All rights reserved.
 */

#import "TiCalendarRefreshModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiCalendarRefreshModule

#pragma mark Internal

-(EKEventStore*)store
{
    if (store == nil) {
        store = [[EKEventStore alloc] init];
    }
    if (store == NULL) {
        DebugLog(@"[WARN] Could not access EventStore. ");
    }
    return store;
}


// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"23280fa3-081b-459f-bc67-6525713ee0bc";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.calendar.refresh";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[DEBUG] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs



-(void)refreshSourcesIfNecessary:(id)arg {
    NSLog(@"NOT IN MAIN");
    if (![NSThread isMainThread]) {
        __block id result = nil;
        NSLog(@"NOT IN MAIN");
        TiThreadPerformOnMainThread(^{[self refreshSourcesIfNecessary:arg];}, YES);
        return;
    }
    
    EKEventStore* ourStore = [self store];
    if (ourStore  == NULL) {
        NSLog(@"Could not instantiate an event of the event store.");
        return;
        
    }
    [ourStore refreshSourcesIfNecessary];
}

@end
