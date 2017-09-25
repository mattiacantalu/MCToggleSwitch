//
//  MCToggleSwitch.m
//  YooxNative
//
//  Created by Mattia Cantalù on 16/06/16.
//  Copyright © 2016 Mattia Cantalù. All rights reserved.
//

#import "MCToggleSwitch.h"
static int const toggleWidth  = 51;
static int const toggleHeight = 31;

@interface MCToggleSwitch ()

@property (nonatomic, weak) IBOutlet UIButton           *button;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *leftSpace;

@property (nonatomic) BOOL status;

@property (nonatomic) CGFloat originPosition;
@property (nonatomic) CGFloat finalPosition;

@end

@implementation MCToggleSwitch

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
        UIView* view = [nib firstObject];
        [self addSubview:view];
        [view setFrame:CGRectMake(0, 0, toggleWidth, toggleHeight)];
        
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    self.originPosition = 0.0;
    self.finalPosition = 0.0;
    self.deleteStatusColor = self.button.backgroundColor = self.deleteStatusColor ? self.deleteStatusColor : [UIColor redColor];
    self.checkmarkStatusColor = self.checkmarkStatusColor ? self.checkmarkStatusColor : [UIColor greenColor];
    [self.button setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
}

- (void)layoutSubviews {
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.clipsToBounds = YES;
    
    self.button.layer.cornerRadius = self.button.frame.size.height / 2;
    self.originPosition = (self.frame.size.height - self.button.frame.size.height) / 2;
    self.finalPosition = self.frame.size.width - self.originPosition - self.button.frame.size.width;
    self.leftSpace.constant = self.originPosition;
}

- (void) setDeleteStatusColor:(UIColor *)deleteStatusColor {
    _deleteStatusColor = deleteStatusColor;
}

- (void) setCheckmarkStatusColor:(UIColor *)checkmarkStatusColor {
    _checkmarkStatusColor = checkmarkStatusColor;
}

- (void) setSwitchStatus:(BOOL)status withAnimation:(BOOL)isAnimating {
    
    if (isAnimating)
        [self animationSwitcherButton:!self.status];
    else {
        [self.button setImage:status ? [UIImage imageNamed:@"checkmark"] : [UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        self.leftSpace.constant = status ? self.finalPosition : self.originPosition;
    }
    
    self.status = status;
}

- (BOOL) switchStatus {
    return self.status;
}

- (IBAction)switcherButtonDidTouch:(id)sender {
    [self animationSwitcherButton:self.status];
    self.status = !self.status;

    if ([self.delegate respondsToSelector:@selector(toggleSwitcher:didChangeValue:)])
    {
        [self.delegate toggleSwitcher:self didChangeValue:self.status];
    }
}

- (void)animationSwitcherButton:(BOOL)status {
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.duration = 0.5;
    rotateAnimation.cumulative = false;
    
    if (status) {
        // Clear Shadow
        self.button.layer.shadowOffset = CGSizeZero;
        self.button.layer.shadowOpacity = 0;
        self.button.layer.shadowRadius = self.button.frame.size.height / 2;
        self.button.layer.cornerRadius = self.button.frame.size.height / 2;
        self.button.layer.shadowPath = nil;
        
        // Rotate animation
        rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
        rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI];
        [self.button.layer addAnimation:rotateAnimation forKey:@"rotate"];
        
        [UIView animateWithDuration:.5f delay:.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self.button setImage:[UIImage imageNamed:@"delete"] forState: UIControlStateNormal];
            self.leftSpace.constant = self.originPosition;
            [self layoutIfNeeded];
            self.button.backgroundColor = self.deleteStatusColor;
        } completion:^(BOOL finished) {
        }];
    }
    else {
        
        // Rotate animation
        rotateAnimation.fromValue = [NSNumber numberWithFloat:M_PI];
        rotateAnimation.toValue = [NSNumber numberWithFloat:0.0];
        [self.button.layer addAnimation:rotateAnimation forKey:@"rotate"];
        
        [UIView animateWithDuration:.5f delay:.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self.button setImage:[UIImage imageNamed:@"checkmark"] forState: UIControlStateNormal];
            self.leftSpace.constant = self.finalPosition;
            [self layoutIfNeeded];
            self.button.backgroundColor = self.checkmarkStatusColor;
        } completion:^(BOOL finished) {
            self.button.layer.shadowOffset = CGSizeMake(0, 0.2);
            self.button.layer.shadowOpacity = 0.3;
            self.button.layer.shadowRadius = 5.0;
            self.button.layer.cornerRadius = self.button.frame.size.height / 2;
            self.button.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:self.button.layer.bounds cornerRadius:self.button.frame.size.height / 2] CGPath];
        }];
    }
}

@end
