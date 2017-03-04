//
//  YKScrollRulerView.h
//  YKScrollRuler
//
//  Created by Daniel Yao on 16/10/31.
//  Copyright © 2016年 Daniel Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DYScrollRulerView;
@protocol DYScrollRulerDelegate <NSObject>

/*
 *  游标卡尺滑动，对应value回调
 *  滑动视图
 *  当前滑动的值
 */
-(void)dyScrollRulerView:(DYScrollRulerView *)rulerView valueChange:(float)value;

@end
@interface DYScrollRulerView : UIView

@property(nonatomic,weak)id<DYScrollRulerDelegate>       delegate;

//滑动时是否改变textfield值
@property(nonatomic, assign)BOOL scrollByHand;

//三角形颜色
@property(nonatomic,strong)UIColor *triangleColor;
//背景颜色
@property(nonatomic,strong)UIColor *bgColor;

-(instancetype)initWithFrame:(CGRect)frame theMinValue:(float)minValue theMaxValue:(float)maxValue theStep:(float)step theUnit:(NSString *)unit theNum:(NSInteger)betweenNum;

-(void)setRealValue:(float)realValue animated:(BOOL)animated;

+(CGFloat)rulerViewHeight;

-(void)setDefaultValue:(float)defaultValue animated:(BOOL)animated;

@end
