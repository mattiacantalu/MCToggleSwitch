//
//  MCToggleSwitch.h
//  YooxNative
//
//  Created by Mattia Cantalù on 16/06/16.
//  Copyright © 2016 Mattia Cantalù. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class MCToggleSwitch;

@protocol MCToggleSwitchDelegate <NSObject>
@optional

/**
 *  Switch did change value delegate
 *
 *  @param view   switch selected
 *  @param status switch status
 */
- (void) toggleSwitcher:(MCToggleSwitch*)view didChangeValue:(BOOL)status;
@end

@interface MCToggleSwitch : UIView
@property (nonatomic, assign) id<MCToggleSwitchDelegate> delegate;

/**
 *  Customize color
 */
@property (nonatomic, strong) UIColor *deleteStatusColor;
@property (nonatomic, strong) UIColor *checkmarkStatusColor;

/**
 *  Set switch status at launch
 *
 *  @param status switch status
 *  @param isAnimating animate changing value
 */
- (void) setSwitchStatus:(BOOL)status withAnimation:(BOOL)isAnimating;

/**
 *  Get switch status
 *
 *  @return switch status
 */
- (BOOL) switchStatus;

@end
