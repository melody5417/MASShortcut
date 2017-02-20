//
//  Setting.m
//  JietuMac
//
//  Created by Yiqi Wang on 16/6/2.
//  Copyright © 2016年 Yiqi Wang. All rights reserved.
//

#import "JTSetting.h"

NSString *const JTSettingKeyCaptureHotKey = @"settingkeycapturehotkey";
NSString *const JTSettingKeyRecordHotKey = @"JTSettingKeyRecordHotKey";
NSString *const JTHotKeyKeyCode = @"keyCode";
NSString *const JTHotKeyFlags = @"modifierFlags";

@implementation JTSetting
static JTSetting *_defaultSetting;
+ (JTSetting *)defaultSetting {
    if (!_defaultSetting) {
        @synchronized (self) {
            if (!_defaultSetting) {
                _defaultSetting = [[JTSetting alloc] init];
            }
        }
    }
    return _defaultSetting;
}

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - getter & setter

- (NSDictionary *)captureHotKey {
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:JTSettingKeyCaptureHotKey];
    if (obj) {
        return obj;
    } else {
        NSDictionary *hotkey = [self defaultValueOfCaptureHotKey];
        [self setCaptureHotKey:hotkey];
        return hotkey;
    }
}

- (void)setCaptureHotKey:(NSDictionary *)captureHotKey {
    [[NSUserDefaults standardUserDefaults] setObject:captureHotKey forKey:JTSettingKeyCaptureHotKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)recordHotKey {
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:JTSettingKeyRecordHotKey];
    if (obj) {
        return obj;
    } else {
        NSDictionary *hotkey = [self defaultValueOfRecordHotKey];
        [self setRecordHotKey:hotkey];
        return hotkey;
    }
}

- (void)setRecordHotKey:(NSDictionary *)recordHotKey {
    [[NSUserDefaults standardUserDefaults] setObject:recordHotKey forKey:JTSettingKeyRecordHotKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - default value

- (NSDictionary *)defaultValueOfCaptureHotKey {
  return [NSDictionary dictionaryWithObjectsAndKeys:@(0), JTHotKeyKeyCode, @(1310720), JTHotKeyFlags, nil];
}

- (NSDictionary *)defaultValueOfRecordHotKey {
  return [NSDictionary dictionaryWithObjectsAndKeys:@(15), JTHotKeyKeyCode, @(1310720), JTHotKeyFlags, nil];
}

@end
