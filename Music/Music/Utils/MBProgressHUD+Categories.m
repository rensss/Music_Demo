//
//  MBProgressHUD+LSExtension.m
//  
//
//  Created by LiuShuo on 2019/5/7.
//

#import "MBProgressHUD+Categories.h"

@implementation MBProgressHUD (Categories)

+ (void)showIndicator {
    [self hide];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        hud.detailsLabel.textColor = UIColor.whiteColor;
        hud.contentColor = UIColor.whiteColor;
    });
}

+ (void)showMessage:(NSString *)message {
    [self hide];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.detailsLabel.text = message;
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.font  = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        hud.detailsLabel.textColor = UIColor.whiteColor;
        hud.contentColor = UIColor.whiteColor;
    });
}

+ (void)showMessage:(NSString *)message withParentView:(UIView *)parentView {
    [self hideFromParentView:parentView];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
        hud.detailsLabel.text = message;
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.font  = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        hud.detailsLabel.textColor = UIColor.whiteColor;
        hud.contentColor = UIColor.whiteColor;
    });
}

+ (void)showIndicatorMessage:(NSString *)message {
    [self hide];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.detailsLabel.text = message;
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.detailsLabel.font  = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        hud.detailsLabel.textColor = UIColor.whiteColor;
        hud.contentColor = UIColor.whiteColor;
    });
}

+ (void)hide {
    dispatch_async(dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:NO];
        [MBProgressHUD hide];
    });
}

+ (void)hideFromParentView:(UIView *)parentView {
    dispatch_async(dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideAllHUDsForView:parentView animated:NO];
        [MBProgressHUD hideHUDForView:parentView animated:NO];
    });
}

+ (void)showIndicatorWithHideAfter:(NSTimeInterval)timeInterval {
    [self hide];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        hud.detailsLabel.textColor = UIColor.whiteColor;
        hud.contentColor = UIColor.whiteColor;
        [hud hideAnimated:YES afterDelay:timeInterval];
    });
}

+ (void)showMessage:(NSString *)message withHideAfter:(NSTimeInterval)timeInterval {
    [self hide];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.detailsLabel.text = message;
        hud.detailsLabel.font  = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
        hud.mode = MBProgressHUDModeText;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        hud.detailsLabel.textColor = UIColor.whiteColor;
        hud.contentColor = UIColor.whiteColor;
        [hud hideAnimated:YES afterDelay:timeInterval];
    });
}

+ (void)showIndicatorWithHideAfter:(NSTimeInterval)timeInterval yOffset:(CGFloat)yOffset {
    [self hide];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        CGPoint offset = hud.offset;
        offset.y = yOffset;
        hud.offset = offset;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        hud.detailsLabel.textColor = UIColor.whiteColor;
        hud.contentColor = UIColor.whiteColor;
        [hud hideAnimated:YES afterDelay:timeInterval];
    });
    
}

+ (void)showMessage:(NSString *)message withHideAfter:(NSTimeInterval)timeInterval yOffset:(CGFloat)yOffset {
    [self hide];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.detailsLabel.text = message;
        hud.detailsLabel.font  = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
        hud.mode = MBProgressHUDModeText;
        CGPoint offset = hud.offset;
        offset.y = yOffset;
        hud.offset = offset;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        hud.detailsLabel.textColor = UIColor.whiteColor;
        hud.contentColor = UIColor.whiteColor;
        [hud hideAnimated:YES afterDelay:timeInterval];
    });
}

@end
