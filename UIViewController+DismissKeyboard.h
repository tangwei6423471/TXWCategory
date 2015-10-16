/*!
 @header        UIViewController (DismissKeyboard)
 @abstract      统一处理，点空白收回键盘的处理
 @brief         各种项目可复用该分类
 @discussion    收回键盘
 */

#import <UIKit/UIKit.h>

@interface UIViewController (DismissKeyboard)
- (void)setupForDismissKeyboard;
//- (void)setupForDismissKeyboardScollView;// alvin 20150812 滑动scollview收键盘
@end
