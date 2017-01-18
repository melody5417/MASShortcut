//
//  MASButtonCell.m
//  MASShortcut
//
//  Created by melody5417 on 18/01/2017.
//  Copyright © 2017 Vadim Shpakovski. All rights reserved.
//

#import "MASButtonCell.h"

@implementation MASButtonCell

- (NSRect)titleRectForBounds:(NSRect)rect {
    NSLog(@"%s bounds:%@", __FUNCTION__, NSStringFromRect(rect));
    
    NSRect titleRect = [super titleRectForBounds:rect];
    
    if (_style == MASShortcutViewStyleRounded &&
        self.alignment == NSTextAlignmentRight) {
        NSSize titleSize = self.attributedTitle.size;
        CGFloat originY = titleRect.origin.y;
        CGFloat originX = rect.origin.x + rect.size.width - titleSize.width - 15;
        return NSMakeRect(originX, originY, titleSize.width, titleSize.height);
    } else {
        return titleRect;
    }
}

@end
