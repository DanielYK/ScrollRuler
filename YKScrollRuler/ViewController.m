//
//  ViewController.m
//  YKScrollRuler
//
//  Created by Daniel Yao on 16/10/31.
//  Copyright © 2016年 Daniel Yao. All rights reserved.
//
#define ScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight  ([[UIScreen mainScreen] bounds].size.height)

#import "ViewController.h"
#import "DYScrollRulerView.h"

@interface ViewController ()<DYScrollRulerDelegate>
@property(nonatomic,strong)DYScrollRulerView *rullerView;

@property(nonatomic,strong)DYScrollRulerView *timeRullerView;

@property(nonatomic,strong)DYScrollRulerView *noneZeroRullerView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.rullerView];
    [self.view addSubview:self.timeRullerView];
    [self.view addSubview:self.noneZeroRullerView];
}

-(DYScrollRulerView *)rullerView{
    if (!_rullerView) {
        NSString *unitStr = @"￥";
        CGFloat rullerHeight = [DYScrollRulerView rulerViewHeight];
        _rullerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(5, ScreenHeight/5.0*0.5, ScreenWidth-20, rullerHeight) theMinValue:0 theMaxValue:1000 theStep:10 theUnit:unitStr theNum:10];
        [_rullerView setDefaultValue:500 animated:YES];
        _rullerView.bgColor = [UIColor lightGrayColor];
        _rullerView.triangleColor   = [UIColor redColor];
        _rullerView.delegate        = self;
        _rullerView.scrollByHand    = YES;
    }
    return _rullerView;
}


-(DYScrollRulerView *)timeRullerView{
    if (!_timeRullerView) {
        NSString *unitStr = @"";
        CGFloat rullerHeight = [DYScrollRulerView rulerViewHeight];
        _timeRullerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(5, ScreenHeight/5.0*2, ScreenWidth-20, rullerHeight) theMinValue:0 theMaxValue:23  theStep:0.2 theUnit:unitStr theNum:5];
        [_timeRullerView setDefaultValue:2 animated:YES];
        _timeRullerView.bgColor = [UIColor orangeColor];
        _timeRullerView.triangleColor   = [UIColor redColor];
        _timeRullerView.delegate        = self;
        _timeRullerView.scrollByHand    = YES;
    }
    return _timeRullerView;
}


-(DYScrollRulerView *)noneZeroRullerView{
    if (!_noneZeroRullerView) {
        NSString *unitStr = @"";
        CGFloat rullerHeight = [DYScrollRulerView rulerViewHeight];
        _noneZeroRullerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(5, ScreenHeight/5.0*3.5, ScreenWidth-20, rullerHeight) theMinValue:20 theMaxValue:200  theStep:1 theUnit:unitStr theNum:5];
        [_noneZeroRullerView setDefaultValue:50 animated:YES];
        _noneZeroRullerView.bgColor = [UIColor orangeColor];
        _noneZeroRullerView.triangleColor   = [UIColor redColor];
        _noneZeroRullerView.delegate        = self;
        _noneZeroRullerView.scrollByHand    = YES;
    }
    return _noneZeroRullerView;
}
#pragma mark - YKScrollRulerDelegate
-(void)dyScrollRulerView:(DYScrollRulerView *)rulerView valueChange:(float)value{
    
    NSLog(@"value->%.f",value);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

