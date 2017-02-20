//
//  Setting.h
//  JietuMac
//
//  Created by Yiqi Wang on 16/6/2.
//  Copyright © 2016年 Yiqi Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const JTSettingKeyCaptureHotKey;
extern NSString *const JTSettingKeyRecordHotKey;
extern NSString *const JTHotKeyKeyCode;
extern NSString *const JTHotKeyFlags;

/**
 * 截屏相关设置项 显示在设置面板上的
 */
@interface JTSetting : NSObject
+ (JTSetting *)defaultSetting;

/** 截图快捷键
 * 默认值为 control + cmd + A ⌘⌃A modifierFlags = 1310720 keyCode = 0;
 */
@property (nonatomic, strong) NSDictionary *captureHotKey;
/** 录屏快捷键
 * 默认值为 ⌘⌃R modifierFlags = 1310720 keyCode = 15;
 * modifierFlags -1 keyCode -1为空的快捷键
 */
@property (nonatomic, strong) NSDictionary *recordHotKey;


@end
