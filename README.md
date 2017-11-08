ScrollRuler
=
喜欢的朋友可以下载下来，如果代码对你有所帮助，还请给个 star，非常感谢你的支持！
= 
 * 京东金融滑动选择资产尺子，以及类似于体重、身高等滑动尺子的demo
 
 
 * 效果图
 
  ![image](https://github.com/DanielYK/ScrollRuler/blob/master/YKScrollRuler/DYScorllRuler/ruler.gif)


 * 使用方法 1.1版本更新 
 - 间隔条数可控使用方法如下，建议更新，增加betweenNum字段属性

<pre><code>
 [self.view addSubview:self.rullerView];
-(DYScrollRulerView *)rullerView{
    if (!_rullerView) {
        NSString *unitStr = @"￥";
        CGFloat rullerHeight = [DYScrollRulerView rulerViewHeight];
        _rullerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(5, ScreenHeight/5.0, ScreenWidth-20, rullerHeight) theMinValue:0 theMaxValue:1000 theStep:10 theUnit:unitStr theNum:10];
        [_rullerView setDefaultValue:500 animated:YES];
        _rullerView.bgColor = [UIColor lightGrayColor];
        _rullerView.triangleColor   = [UIColor redColor];
        _rullerView.delegate        = self;
        _rullerView.scrollByHand    = YES;
    }
    return _rullerView;
}
</code></pre>

//滑动尺子时产生的回调

<pre><code>
#pragma mark - YKScrollRulerDelegate
-(void)dyScrollRulerView:(DYScrollRulerView *)rulerView valueChange:(float)value{

    NSLog(@"value->%.f",value);
}
</code></pre>

 - 使用过程中有问题请加QQ或发邮件:584379066 备注：Git ScrollRuler

//参考了个别开源滑动尺子优秀的代码

