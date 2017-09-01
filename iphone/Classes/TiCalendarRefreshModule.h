/**
 * ti.calendar.refresh
 *
 * Created by Your Name
 * Copyright (c) 2017 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import <EventKit/EventKit.h>

@interface TiCalendarRefreshModule : TiModule
{
@private
    EKEventStore * store;
}

-(EKEventStore*)store;

@end
