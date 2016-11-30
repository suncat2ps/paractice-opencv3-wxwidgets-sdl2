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
