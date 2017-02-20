//
//  JTHotkeyManager.m
//  JietuMac
//
//  Created by Yiqi Wang on 2016/11/8.
//  Copyright © 2016年 Yiqi Wang. All rights reserved.
//

#import "JTHotkeyManager.h"
#import "JTSetting.h"

@implementation JTHotkeyManager

/** 注册快捷键组合 同时更新Setting */
- (void)registerHotKeyType:(JTHotkeyType)type
               withshortcut:(MASShortcut *)shortcut
                  callback:(void(^)())callback
                completion:(void(^)(NSError *error))completion {
    
    void (^unregisterCallback)() = ^() {
        if (shortcut) {
            //注册新的快捷键
            BOOL ret = [[MASShortcutMonitor sharedMonitor] registerShortcut:shortcut withAction:callback];
            if (ret) {
                //更新setting
                NSDictionary *newHotKey = [NSDictionary dictionaryWithObjectsAndKeys:@(shortcut.keyCode),
                                           JTHotKeyKeyCode,
                                           @(shortcut.modifierFlags),
                                           JTHotKeyFlags, nil];
                switch (type) {
                    case JTHotkeyTypeRecord:
                        [[JTSetting defaultSetting] setRecordHotKey:newHotKey];
                        break;
                    case JTHotkeyTypeCapture:
                        [[JTSetting defaultSetting] setCaptureHotKey:newHotKey];
                        break;
                        
                    default:
                        break;
                }
            } else {
                NSLog(@"%s 注册快捷键失败", __FUNCTION__);
            }
        }
        
        if (completion) {
            completion(nil);
        }
    };

    
    // 删除之前的快捷键
    [self unregisterHotKeyType:type
                    completion:unregisterCallback];
    
}

/** 删除快捷键组合 同时更新Setting */
- (void)unregisterHotKeyType:(JTHotkeyType)type
                  completion:(void(^)(NSError *error))completion {
    NSUInteger keyCode;
    NSUInteger flags;
    
    NSDictionary *emptyHotkey = [NSDictionary dictionaryWithObjectsAndKeys:@(-1),
                               JTHotKeyKeyCode,
                               @(-1),
                               JTHotKeyFlags, nil];
    
    switch (type) {
        case JTHotkeyTypeRecord:
            keyCode = [[[[JTSetting defaultSetting] recordHotKey] objectForKey:JTHotKeyKeyCode] unsignedIntegerValue];
            flags = [[[[JTSetting defaultSetting] recordHotKey] objectForKey:JTHotKeyFlags] unsignedIntegerValue];
            [[JTSetting defaultSetting] setRecordHotKey:emptyHotkey];
            break;
        case JTHotkeyTypeCapture:
            keyCode = [[[[JTSetting defaultSetting] captureHotKey] objectForKey:JTHotKeyKeyCode] unsignedIntegerValue];
            flags = [[[[JTSetting defaultSetting] captureHotKey] objectForKey:JTHotKeyFlags] unsignedIntegerValue];
            [[JTSetting defaultSetting] setCaptureHotKey:emptyHotkey];
            break;
            
        default:
            break;
    }
    
    MASShortcut *oldShortcut = [MASShortcut shortcutWithKeyCode:keyCode modifierFlags:flags];
    [[MASShortcutMonitor sharedMonitor] unregisterShortcut:oldShortcut];
    
    if (completion) {
        completion(nil);
    }
}

@end
