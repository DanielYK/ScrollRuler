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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.rullerView];
}

-(DYScrollRulerView *)rullerView{
    if (!_rullerView) {
        NSString *unitStr = @"￥";
        CGFloat rullerHeight = [DYScrollRulerView rulerViewHeight];
        _rullerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(5, ScreenHeight/5.0, ScreenWidth-20, rullerHeight) theMinValue:0 theMaxValue:1000 theStep:10 theUnit:unitStr];
        [_rullerView setDefaultValue:500 animated:YES];
        _rullerView.bgColor = [UIColor cyanColor];
        _rullerView.triangleColor   = [UIColor redColor];
        _rullerView.delegate        = self;
        _rullerView.scrollByHand    = YES;
    }
    return _rullerView;
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
