//
//  MASButtonCell.h
//  MASShortcut
//
//  Created by melody5417 on 18/01/2017.
//  Copyright © 2017 Vadim Shpakovski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASShortcutView.h"

@interface MASButtonCell : NSButtonCell
@property (nonatomic, assign) MASShortcutViewStyle style;
@end
