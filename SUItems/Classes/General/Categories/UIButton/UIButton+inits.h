/**********//**********//**********//**********//**********//**********//**********//*
 .--,       .--,
( (  \.---./  ) )
 '.__/o   o\__.'
    {=  ^  =}
     >  -  <
    /       \
   //       \\
  //|   .   |\\             高山仰止,景行行止.虽不能至,心向往之。
  "'\       /'"_.-~^`'-.
     \  _  /--'         `
   ___)( )(___
  (((__) (__)))


  UIButton+inits.h

  Created by June on 16/11/29.
  Copyright © 2017年 http://h94uang@gmail.com All rights reserved.

*//**********//**********//**********//**********//**********//**********//**********/

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    kButtonNormal,
    kButtonWhite,
    kButtonRed,
    
} EButtonType;

@interface UIButton (inits)

/**
 *  创建button
 *
 *  @param frame    frame值
 *  @param type     类型
 *  @param title    标题
 *  @param tag      标签
 *  @param target   目标
 *  @param selector 执行句柄
 *
 *  @return 创建好的button
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                         buttonType:(EButtonType)type
                              title:(NSString *)title
                                tag:(NSInteger)tag
                             target:(id)target
                             action:(SEL)selector;

@end
