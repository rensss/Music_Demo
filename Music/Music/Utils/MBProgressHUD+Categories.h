//
//  MBProgressHUD+LSExtension.h
//  
//
//  Created by LiuShuo on 2019/5/7.
//

#import <MBProgressHUD.h>

@interface MBProgressHUD (Categories)

// 长时间展示
+ (void)showIndicator;
+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message withParentView:(UIView *)parentView;
+ (void)showIndicatorMessage:(NSString *)message;
+ (void)hide;
+ (void)hideFromParentView:(UIView *)parentView;
// 规定时间内展示
+ (void)showIndicatorWithHideAfter:(NSTimeInterval)timeInterval;
+ (void)showMessage:(NSString *)message withHideAfter:(NSTimeInterval)timeInterval;
+ (void)showIndicatorWithHideAfter:(NSTimeInterval)timeInterval yOffset:(CGFloat)yOffset;
+ (void)showMessage:(NSString *)message withHideAfter:(NSTimeInterval)timeInterval yOffset:(CGFloat)yOffset;

@end

