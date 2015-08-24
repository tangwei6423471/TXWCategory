/*!
 @header        UIViewController (HUD)
 @abstract      将三方库 MBProgressHUD 的方法作为viewcontroller分类
 @brief         runtime机制给hud动态添加显示的文字内容
 @discussion    动态消失提示view
 */

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;     // 视图上显示hud和文字提示hint

- (void)hideHud;                                                // 隐藏hud

- (void)showHint:(NSString *)hint;                              // 只显示文字提示hint

- (void)showHint:(NSString *)hint yOffset:(float)yOffset;       // 从默认(showHint:)显示的位置再往上(下)yOffset

@end
