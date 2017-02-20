#import "AppDelegate.h"
#import "JTSetting.h"
#import "JTHotkeyManager.h"

static NSString *const MASCustomShortcutEnabledKey = @"customShortcutEnabled";
static NSString *const MASHardcodedShortcutEnabledKey = @"hardcodedShortcutEnabled";

@interface AppDelegate ()
@property (strong) IBOutlet MASShortcutView *captureShortcutView;
@property (strong) IBOutlet MASShortcutView *recordShortcutView;
@property (nonatomic, copy) void (^shortcutValueIsNotValid)();
@property (nonatomic, copy) void (^caputreShortcutPressed)();
@property (nonatomic, copy) void (^recordShortcutPressed)();
@end

@implementation AppDelegate

- (void) awakeFromNib
{
  [super awakeFromNib];
  
  /**
   MASShortcutViewStyleDefault = 0,  // Height = 19 px
   MASShortcutViewStyleTexturedRect, // Height = 25 px
   MASShortcutViewStyleRounded,      // Height = 43 px
   MASShortcutViewStyleFlat
   */
  [self.captureShortcutView setStyle:MASShortcutViewStyleRounded];
  [self.recordShortcutView setStyle:MASShortcutViewStyleRounded];
  
  [self setupHotkeyCallback];

  JTSetting *setting = [JTSetting defaultSetting];
  
  //快捷键
  if (setting.captureHotKey) {
    NSInteger keyCode = [[setting.captureHotKey objectForKey:JTHotKeyKeyCode] integerValue];
    NSInteger flags = [[setting.captureHotKey objectForKey:JTHotKeyFlags] integerValue];
    if (keyCode!= -1 && flags!= -1) {
      MASShortcut *shortcut = [MASShortcut shortcutWithKeyCode:keyCode
                                                 modifierFlags:flags];
      [self.captureShortcutView setShortcutValue:shortcut];
      
      // 启动时注册快捷键
      [self registerHotKey:shortcut forHotKeyType:JTHotkeyTypeCapture];
    }
  }
  
  if (setting.recordHotKey) {
    NSInteger keyCode = [[setting.recordHotKey objectForKey:JTHotKeyKeyCode] integerValue];
    NSInteger flags = [[setting.recordHotKey objectForKey:JTHotKeyFlags] integerValue];
    if (keyCode!= -1 && flags!= -1) {
      MASShortcut *shortcut = [MASShortcut shortcutWithKeyCode:keyCode
                                                 modifierFlags:flags];
      [self.recordShortcutView setShortcutValue:shortcut];
      
      // 启动时注册快捷键
      [self registerHotKey:shortcut forHotKeyType:JTHotkeyTypeRecord];
    }
  }
  
  [self bindCaptureShortcutView];
  [self bindRecordShortcutView];
}

#pragma mark - hotkey

- (void)setupHotkeyCallback {
  self.caputreShortcutPressed = ^{
    NSLog(@"caputreShortcutPressed response");
  };
  
  self.recordShortcutPressed = ^ {
    NSLog(@"recordShortcutPressed response");
  };
}

/** 绑定shortcutview的回调 */
- (void)bindCaptureShortcutView {
  self.captureShortcutView.shortcutValueChange = ^(MASShortcutView *view) {
    MASShortcut *shortcutValue = view.shortcutValue;
    [(AppDelegate *)[NSApp delegate] registerHotKey:shortcutValue forHotKeyType:JTHotkeyTypeCapture];
  };
}

/** 绑定shortcutview的回调 */
- (void)bindRecordShortcutView {
  self.recordShortcutView.shortcutValueChange = ^(MASShortcutView *view) {
    MASShortcut *shortcutValue = view.shortcutValue;
    [(AppDelegate *)[NSApp delegate] registerHotKey:shortcutValue forHotKeyType:JTHotkeyTypeRecord];
  };
}

- (void)registerHotKey:(MASShortcut *)shortcut forHotKeyType:(JTHotkeyType)type {
  if (type == JTHotkeyTypeRecord) {
    [[[JTHotkeyManager alloc] init] registerHotKeyType:JTHotkeyTypeRecord
                                          withshortcut:shortcut
                                              callback:self.recordShortcutPressed
                                            completion:^(NSError *error) {
                                              NSLog(@"注册Record成功");
                                            }];
  } else if (type == JTHotkeyTypeCapture) {
    [[[JTHotkeyManager alloc] init] registerHotKeyType:JTHotkeyTypeCapture
                                          withshortcut:shortcut
                                              callback:self.caputreShortcutPressed
                                            completion:^(NSError *error) {
                                              NSLog(@"注册capture成功");
                                            }];
  }
}

#pragma mark NSApplicationDelegate

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication*) sender
{
    return YES;
}

@end
