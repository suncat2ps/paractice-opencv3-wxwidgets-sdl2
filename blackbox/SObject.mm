//
//  SObject.m
//  blackbox
//
//  Created by 장성각 on 2016. 11. 28..
//  Copyright © 2016년 장성각. All rights reserved.
//

#import "SObject.h"

@implementation SObject

NSWindow* GetNSWindowFromNSView (NSView *view)
{
    [view setWantsLayer:YES];
    return [view window];
}

NSView* getContentViewFromNSWindow (NSWindow *window)
{
    return [window contentView];
}

@end
