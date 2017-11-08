//
//  YKScrollRulerView.m
//  YKScrollRuler
//
//  Created by Daniel Yao on 16/10/31.
//  Copyright © 2016年 Daniel Yao. All rights reserved.
//
#define ScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight  ([[UIScreen mainScreen] bounds].size.height)

#define TextColorGrayAlpha 1.0 //文字的颜色灰度
#define TextRulerFont  [UIFont systemFontOfSize:11]
#define RulerLineColor [UIColor grayColor]

#define RulerGap        12 //单位距离
#define RulerLong       40
#define RulerShort      30
#define TrangleWidth    16
#define CollectionHeight 70

#import "DYScrollRulerView.h"

/**
 *  绘制三角形标示
 */
@interface DYTriangleView : UIView
@property(nonatomic,strong)UIColor *triangleColor;

@end
@implementation DYTriangleView

-(void)drawRect:(CGRect)rect{
    //设置背景颜色
    [[UIColor clearColor]set];
    
    UIRectFill([self bounds]);
    
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //利用path路径进行绘制三角形
    CGContextBeginPath(context);//标记
    
    CGContextMoveToPoint(context, 0, 0);
    
    CGContextAddLineToPoint(context, TrangleWidth, 0);
    
    CGContextAddLineToPoint(context, TrangleWidth/2.0, TrangleWidth/2.0);
    CGContextSetLineCap(context, kCGLineCapButt);//线结束时是否绘制端点，该属性不设置。有方形，圆形，自然结束3中设置
    CGContextSetLineJoin(context, kCGLineJoinBevel);//线交叉时设置缺角。有圆角，尖角，缺角3中设置
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [_triangleColor setFill];//设置填充色
    [_triangleColor setStroke];//设置边框色
    
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path，后属性表示填充
}

@end


/***************DY************分************割************线***********/

@interface DYRulerView : UIView

@property (nonatomic,assign)NSInteger betweenNumber;
@property (nonatomic,assign)int minValue;
@property (nonatomic,assign)int maxValue;
@property (nonatomic,  copy)NSString *unit;
@property (nonatomic,assign)CGFloat step;

@end
@implementation DYRulerView

-(void)drawRect:(CGRect)rect{
    CGFloat startX = 0;
    CGFloat lineCenterX = RulerGap;
    CGFloat shortLineY  = rect.size.height - RulerLong;
    CGFloat longLineY = rect.size.height -RulerShort;
    CGFloat topY = 0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);//设置线的宽度，
    CGContextSetLineCap(context,kCGLineCapButt);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);//设置线的颜色，默认是黑色
    for (int i = 0; i <= _betweenNumber; i ++){
        CGContextMoveToPoint(context, startX+lineCenterX*i, topY);
        if (i%_betweenNumber == 0){
            NSString *num = [NSString stringWithFormat:@"%.f%@",i*_step+_minValue,_unit];
            if ([num floatValue]>1000000){
                num = [NSString stringWithFormat:@"%.f万%@",[num floatValue]/10000.f,_unit];
            }
            
            NSDictionary *attribute = @{NSFontAttributeName:TextRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:TextColorGrayAlpha alpha:1.0]};
            CGFloat width = [num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
            [num drawInRect:CGRectMake(startX+lineCenterX*i-width/2, longLineY+10, width, 14) withAttributes:attribute];
            CGContextAddLineToPoint(context, startX+lineCenterX*i, longLineY);
        }else{
            CGContextAddLineToPoint(context, startX+lineCenterX*i, shortLineY);
        }
        CGContextStrokePath(context);//开始绘制
    }
}

@end


/***************DY************分************割************线***********/

@interface DYHeaderRulerView : UIView

@property(nonatomic,assign)int minValue;
@property(nonatomic,  copy)NSString *unit;

@end

@implementation DYHeaderRulerView

-(void)drawRect:(CGRect)rect{
    
    CGFloat longLineY = rect.size.height - RulerShort;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetLineCap(context, kCGLineCapButt);
    
    CGContextMoveToPoint(context, rect.size.width, 0);
    NSString *num = [NSString stringWithFormat:@"%d%@",_minValue,_unit];
    if ([num floatValue]>1000000){
        num = [NSString stringWithFormat:@"%.f万%@",[num floatValue]/10000.f,_unit];
    }
    
    NSDictionary *attribute = @{NSFontAttributeName:TextRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:TextColorGrayAlpha alpha:1]};
    CGFloat width = [num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [num drawInRect:CGRectMake(rect.size.width-width/2, longLineY+10, width, 14) withAttributes:attribute];
    CGContextAddLineToPoint(context,rect.size.width, longLineY);
    CGContextStrokePath(context);//开始绘制
}

@end




/***************DY************分************割************线***********/
@interface DYFooterRulerView : UIView

@property(nonatomic,assign)int maxValue;
@property(nonatomic,  copy)NSString *unit;
@end
@implementation DYFooterRulerView

-(void)drawRect:(CGRect)rect{
    CGFloat longLineY = rect.size.height - RulerShort;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetLineCap(context, kCGLineCapButt);
    
    CGContextMoveToPoint(context, 0, 0);//起始点
    NSString *num = [NSString stringWithFormat:@"%d%@",_maxValue,_unit];
    if ([num floatValue]>1000000) {
        num = [NSString stringWithFormat:@"%.f万%@",[num floatValue]/10000.f,_unit];
    }
    NSDictionary *attribute = @{NSFontAttributeName:TextRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:TextColorGrayAlpha alpha:1]};
    CGFloat width = [num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [num drawInRect:CGRectMake(0-width/2, longLineY+10, width, 14) withAttributes:attribute];
    CGContextAddLineToPoint(context, 0, longLineY);
    CGContextStrokePath(context);//开始绘制
}

@end

/***************DY************分************割************线***********/

@interface DYScrollRulerView()<UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UITextField     *valueTF;
@property(nonatomic, strong)UILabel         *unitLab;
@property(nonatomic, strong)UICollectionView*collectionView;
@property(nonatomic, strong)UIImageView     *redLine;
@property(nonatomic, strong)DYTriangleView  *triangle;
@property(nonatomic, assign)float           realValue;
@property(nonatomic, copy  )NSString        *unit;//单位
@property(nonatomic, assign)float           stepNum;//分多少个区
@property(nonatomic, assign)float           minValue;//游标的最小值
@property(nonatomic, assign)float           maxValue;//游标的最大值
@property(nonatomic, assign)float           step;//间隔值，每两条相隔多少值
@property(nonatomic, assign)NSInteger       betweenNum;
@end
@implementation DYScrollRulerView

-(instancetype)initWithFrame:(CGRect)frame theMinValue:(float)minValue theMaxValue:(float)maxValue theStep:(float)step theUnit:(NSString *)unit theNum:(NSInteger)betweenNum{
    
    self = [super initWithFrame:frame];
    if (self) {
        _minValue   = minValue;
        _maxValue   = maxValue;
        _step       = step;
        _stepNum    = (_maxValue-_minValue)/_step/betweenNum;
        _unit       = unit;
        _betweenNum = betweenNum;
        _bgColor    = [UIColor whiteColor];
        _triangleColor          = [UIColor orangeColor];//默认橙色
        self.backgroundColor    = [UIColor whiteColor];
        
        [self addSubview:self.valueTF];
        [self addSubview:self.unitLab];
        [self addSubview:self.collectionView];
        [self addSubview:self.triangle];
        self.unitLab.text = _unit;
    }
    return self;
}

-(DYTriangleView *)triangle{
    if (!_triangle) {
        _triangle = [[DYTriangleView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-0.5-TrangleWidth/2, CGRectGetMaxY(_valueTF.frame), TrangleWidth, TrangleWidth)];
        _triangle.backgroundColor   = [UIColor clearColor];
        _triangle.triangleColor     = _triangleColor;
    }
    return _triangle;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_valueTF.frame), self.bounds.size.width, CollectionHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = _bgColor;
        _collectionView.bounces         = YES;
        _collectionView.showsHorizontalScrollIndicator  = NO;
        _collectionView.showsVerticalScrollIndicator    = NO;
        _collectionView.dataSource      = self;
        _collectionView.delegate        = self;
        _collectionView.contentSize     = CGSizeMake(_stepNum*_step+ScreenWidth/2, CollectionHeight);
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"headCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"footerCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"custemCell"];
    }
    return _collectionView;
}
-(UITextField *)valueTF{
    if (!_valueTF) {
        _valueTF                          = [[UITextField alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-60, 10,80, 40)];
        _valueTF.userInteractionEnabled   = YES;
        _valueTF.defaultTextAttributes    = @{
                                              NSFontAttributeName:[UIFont systemFontOfSize:19],
                                              NSForegroundColorAttributeName:[UIColor redColor]};
        _valueTF.textAlignment            = NSTextAlignmentRight
        ;
        _valueTF.delegate                 = self;
        _valueTF.keyboardType             = UIKeyboardTypeNamePhonePad;
    }
    return _valueTF;
}
-(UILabel *)unitLab{
    if (!_unitLab) {
        _unitLab = [[UILabel alloc]initWithFrame:CGRectMake( self.bounds.size.width/2+20 , 10, 40, 40)];
        _unitLab.textColor = [UIColor redColor];
    }
    return _unitLab;
}
-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    _collectionView.backgroundColor = _bgColor;
}
-(void)setTriangleColor:(UIColor *)triangleColor{
    _triangleColor = triangleColor;
    _triangle.triangleColor = _triangleColor;
}

-(void)setRealValue:(float)realValue{
    [self setRealValue:realValue animated:NO];
}
-(void)setRealValue:(float)realValue animated:(BOOL)animated{
    
    _realValue      = realValue;
    _valueTF.text   = [NSString stringWithFormat:@"%.1f",_realValue*_step+_minValue];
    [_collectionView setContentOffset:CGPointMake((int)realValue*RulerGap, 0) animated:animated];
}

+(CGFloat)rulerViewHeight{
    return 40+20+CollectionHeight;
}

-(void)setDefaultValue:(float)defaultValue animated:(BOOL)animated{
    _realValue      = defaultValue;
    _valueTF.text   = [NSString stringWithFormat:@"%.1f",defaultValue];
    
    [_collectionView setContentOffset:CGPointMake(((defaultValue-_minValue)/(float)_step)*RulerGap, 0) animated:animated];
    
}
#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([newStr intValue]>_maxValue){
        _valueTF.text =  [NSString stringWithFormat:@"%.f",_maxValue];
        [self performSelector:@selector(didChangeValue) withObject:nil afterDelay:0];
        return NO;
    }else{
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(didChangeValue) withObject:nil afterDelay:1];
        return YES;
    }
}
-(void)didChangeValue{
    float textFieldValue = [_valueTF.text floatValue];
    if ((textFieldValue-_minValue)>=0) {
        [self setRealValue:(textFieldValue-_minValue)/(float)_step animated:YES];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"少于最低值，请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma mark UICollectionViewDataSource & Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2+_stepNum;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headCell" forIndexPath:indexPath];
        DYHeaderRulerView *headerView = [cell.contentView viewWithTag:1000];
        if (!headerView){
            headerView = [[DYHeaderRulerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, CollectionHeight)];
            headerView.backgroundColor  =  [UIColor clearColor];
            headerView.tag              =  1000;
            headerView.minValue         = _minValue;
            headerView.unit             = _unit;
            [cell.contentView addSubview:headerView];
        }
        
        return cell;
    }else if( indexPath.item == _stepNum +1){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"footerCell" forIndexPath:indexPath];
        DYFooterRulerView *footerView = [cell.contentView viewWithTag:1001];
        if (!footerView){
            footerView = [[DYFooterRulerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, CollectionHeight)];
            footerView.backgroundColor  = [UIColor clearColor];
            footerView.tag              = 1001;
            footerView.maxValue         = _maxValue;
            footerView.unit             = _unit;
            [cell.contentView addSubview:footerView];
        }
        
        return cell;
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"custemCell" forIndexPath:indexPath];
        DYRulerView *rulerView = [cell.contentView viewWithTag:1002];
        if (!rulerView){
            rulerView  = [[DYRulerView alloc]initWithFrame:CGRectMake(0, 0, RulerGap*_betweenNum, CollectionHeight)];
            rulerView.tag               = 1002;
            rulerView.step              = _step;
            rulerView.unit              = _unit;
            rulerView.betweenNumber     = _betweenNum;
            [cell.contentView addSubview:rulerView];
        }
        if(indexPath.item>=8 && indexPath.item<=12){
            rulerView.backgroundColor   =  [UIColor greenColor];
        }else if(indexPath.item>=13 && indexPath.item<=18){
            rulerView.backgroundColor   =  [UIColor redColor];
        }else{
            rulerView.backgroundColor   =  [UIColor grayColor];
        }
        
        rulerView.minValue = _step*(indexPath.item-1)*_betweenNum+_minValue;
        rulerView.maxValue = _step*indexPath.item*_betweenNum;
        [rulerView setNeedsDisplay];
        
        return cell;
    }
}

-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0 || indexPath.item == _stepNum+1){
        return CGSizeMake(self.frame.size.width/2, CollectionHeight);
    }else{
        return CGSizeMake(RulerGap*_betweenNum, CollectionHeight);
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}

#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int value = scrollView.contentOffset.x/RulerGap;
    float totalValue = value*_step +_minValue;
    
    if (_scrollByHand) {
        if (totalValue >= _maxValue) {
            _valueTF.text = [NSString stringWithFormat:@"%.1f",_maxValue];
        }else if(totalValue <= _minValue){
            _valueTF.text = [NSString stringWithFormat:@"%.1f",_minValue];
        }else{
            _valueTF.text = [NSString stringWithFormat:@"%.1f",value*_step +_minValue];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(dyScrollRulerView:valueChange:)]) {
        [self.delegate dyScrollRulerView:self valueChange:totalValue];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{//拖拽时没有滑动动画
    if (!decelerate){
        [self setRealValue:round(scrollView.contentOffset.x/(RulerGap)) animated:YES];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setRealValue:round(scrollView.contentOffset.x/(RulerGap)) animated:YES];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
@end

