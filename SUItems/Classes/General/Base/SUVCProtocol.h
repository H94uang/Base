//
//  SUVCProtocol.h
//  SUItems
//
//  Created by June on 17/3/7.
//  Copyright © 2017年 http://h94uang@gmail.com All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SUVCProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <SUVCProtocol>)viewModel;

- (void)bindViewModel;
- (void)addSubviews;
- (void)layoutNavigation;
- (void)getNewData;
- (void)recoverKeyboard;

@end
