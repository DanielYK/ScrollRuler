# ScrollRuler


 - 京东金融滑动选择资产尺子，以及类似于体重、身高等滑动尺子的demo
 - 喜欢的朋友可以下载下来，如果您感觉我写的代码对您有所帮助，还请在 github 给个 star，非常感谢您的支持！

//使用方法

//代码实现
[self.view addSubview:self.rullerView];

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

//滑动回调
#pragma mark - YKScrollRulerDelegate
-(void)dyScrollRulerView:(DYScrollRulerView *)rulerView valueChange:(float)value{

    NSLog(@"value->%.f",value);
}

//使用过程中有问题请加QQ或发邮件:584379066 备注：Git ScrollRuler

//参考了个别开源滑动尺子优秀的代码

