//
//  JTHotkeyManager.h
//  JietuMac
//
//  Created by Yiqi Wang on 2016/11/8.
//  Copyright © 2016年 Yiqi Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JTSetting.h"
#import <MASShortcut/Shortcut.h>

typedef NS_ENUM(NSUInteger, JTHotkeyType) {
  //预留
  JTHotkeyTypeNone = 0,
  JTHotkeyTypeCapture,
  JTHotkeyTypeRecord,
};

@interface JTHotkeyManager : NSObject

/** 注册快捷键组合 同时更新Setting */
- (void)registerHotKeyType:(JTHotkeyType)type
              withshortcut:(MASShortcut *)shortcut
                  callback:(void(^)())callback
                completion:(void(^)(NSError *error))completion;

/** 删除对应type的快捷键组合 同时更新Setting */
- (void)unregisterHotKeyType:(JTHotkeyType)type
                  completion:(void(^)(NSError *error))completion ;

@end
