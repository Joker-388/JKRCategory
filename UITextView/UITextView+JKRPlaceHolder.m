//
//  UITextView+JKRPlaceHolder.m
//  UITextViewDemo
//
//  Created by Lucky on 2017/5/27.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "UITextView+JKRPlaceHolder.h"
#import <objc/runtime.h>

@interface UITextView ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *jkr_placeLabel;
@property (nonatomic, weak) id<UITextViewDelegate> outSideDelegate;

@end

@implementation UITextView (JKRPlaceHolder)

static const char * JKR_UITEXTVIEW_PLACEHOLDER_KEY = "JKR_UITEXTVIEW_PLACEHOLDER_KEY";
static const char * JKR_UITEXTVIEW_PLACEHOLDER_LABEL_KEY = "JKR_UITEXTVIEW_PLACEHOLDER_LABEL_KEY";
static const char * JKR_UITEXTVIEW_PLACEHOLDER_DELEGATE_KEY = "JKR_UITEXTVIEW_PLACEHOLDER_DELEGATE_KEY";

- (void)jkr_setText:(NSString *)text {
    [self jkr_setText:text];
    self.jkr_placeLabel.hidden = text.length;
}

- (void)jkr_setDelegate:(id<UITextViewDelegate>)delegate {
    if ([self isKindOfClass:[UITextView class]]) {
        [self jkr_setDelegate:(id<UITextViewDelegate>) self];
        if (delegate != self) self.outSideDelegate = delegate;
    }
}

- (void)setOutSideDelegate:(id<UITextViewDelegate>)outSideDelegate {
    objc_setAssociatedObject(self, JKR_UITEXTVIEW_PLACEHOLDER_DELEGATE_KEY, outSideDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<UITextViewDelegate>)outSideDelegate {
    return objc_getAssociatedObject(self, JKR_UITEXTVIEW_PLACEHOLDER_DELEGATE_KEY);
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    objc_setAssociatedObject(self, JKR_UITEXTVIEW_PLACEHOLDER_KEY, placeHolder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([self class], @selector(setText:)), class_getInstanceMethod([self class], @selector(jkr_setText:)));
        method_exchangeImplementations(class_getInstanceMethod([self class], @selector(setDelegate:)), class_getInstanceMethod([self class], @selector(jkr_setDelegate:)));
        
        self.jkr_placeLabel = [[UILabel alloc] init];
        [self addSubview:self.jkr_placeLabel];
        self.delegate = self;
    });
    
    self.jkr_placeLabel.font = self.font;
    self.jkr_placeLabel.text = placeHolder;
    self.jkr_placeLabel.textColor = [UIColor lightGrayColor];
    [self.jkr_placeLabel sizeToFit];
    CGRect frame = self.jkr_placeLabel.frame;
    frame.origin.x = 5;
    frame.origin.y = 8;
    self.jkr_placeLabel.frame = frame;
}

- (NSString *)placeHolder {
    return objc_getAssociatedObject(self, JKR_UITEXTVIEW_PLACEHOLDER_KEY);
}

- (UILabel *)jkr_placeLabel {
    return objc_getAssociatedObject(self, JKR_UITEXTVIEW_PLACEHOLDER_LABEL_KEY);
}

- (void)setJkr_placeLabel:(UILabel *)jkr_placeLabel {
    objc_setAssociatedObject(self, JKR_UITEXTVIEW_PLACEHOLDER_LABEL_KEY, jkr_placeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.outSideDelegate && [self.outSideDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.outSideDelegate textViewDidChange:textView];
    }
    self.jkr_placeLabel.hidden = textView.text.length;
}

@end
