//
//  CTPasteCheckPopView.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/24.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTPasteCheckPopView.h"

@interface CTPasteCheckPopView()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (nonatomic, copy) void (^clickButtonBlock)(NSInteger buttonIndex);
@end

@implementation CTPasteCheckPopView

+ (void)showPopViewWithText:(NSString *)text callback:(void(^)(NSInteger buttonIndex))callback{
    CTPasteCheckPopView *popView = NSMainBundleClass(CTPasteCheckPopView.class);
    popView.clickButtonBlock = callback;
    popView.textLabel.text = text;
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [popView startAnimation];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.backgroundView.alpha = 0.0;
}

- (IBAction)cancel:(id)sender {
    if(self.clickButtonBlock){
        self.clickButtonBlock(0);
    }
    [self removeFromSuperview];
}
- (IBAction)search:(id)sender {
    if(self.clickButtonBlock){
        self.clickButtonBlock(1);
    }
    [self removeFromSuperview];
}

- (void)startAnimation{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:6 initialSpringVelocity:30 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.backgroundView.alpha = 0.5;
        self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [self layoutIfNeeded];
    } completion:nil];
}

@end
