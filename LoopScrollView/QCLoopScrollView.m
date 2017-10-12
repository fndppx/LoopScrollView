
//
//  QCLoopScrollView.m
//  QingClassSaas
//
//  Created by weikeyan on 2017/10/12.
//  Copyright © 2017年 QingClass. All rights reserved.
//

#import "QCLoopScrollView.h"
#import "UIImageView+WebCache.h"
@interface QCLoopScrollView()<UIScrollViewDelegate>{
    NSInteger _indexPage;
}
@property (nonatomic,strong)UIScrollView * contentScrollView;
@property (nonatomic,strong)UIImageView * leftImageView;
@property (nonatomic,strong)UIImageView * currentImageView;
@property (nonatomic,strong)UIImageView * nextImageView;
@property (nonatomic,strong)NSTimer * timer;

@end
@implementation QCLoopScrollView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setImageURLArray:(NSArray *)imageURLArray{
    _imageURLArray = imageURLArray;
    [self setScrollViewOfImage];
}
- (void)setupScrollView{
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _contentScrollView.contentSize = CGSizeMake( self.frame.size.width*3, self.frame.size.height);
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.bounces = NO;
    _contentScrollView.delegate = self;
    _contentScrollView.backgroundColor = [UIColor grayColor];
    [self addSubview:_contentScrollView];
    
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_contentScrollView addSubview:_leftImageView];
    
    _currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [_contentScrollView addSubview:_currentImageView];
    
    _nextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*2, 0, self.frame.size.width, self.frame.size.height)];
    [_contentScrollView addSubview:_nextImageView];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}
- (void)timerAction{
    [self.contentScrollView setContentOffset:CGPointMake(self.frame.size.width*2, 0) animated:YES];
}

- (void)setScrollViewOfImage{
    [self.currentImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLArray[_indexPage]] placeholderImage:[UIImage imageNamed:@""]];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLArray[_indexPage]] placeholderImage:[UIImage imageNamed:@""]];
    [self.nextImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLArray[_indexPage]] placeholderImage:[UIImage imageNamed:@""]];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset  = scrollView.contentOffset.x;
    if (offset == 0) {
        _indexPage = [self getLastImageViewIndexWithCurrentImageIndexPage:_indexPage];
    }else if (offset == self.frame.size.width*2){
        _indexPage = [self getNextImageViewIndexWithCurrentImageIndexPage:_indexPage];
    }
    
    [self setScrollViewOfImage];
    [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    if (_timer==nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
}
- (NSInteger)getNextImageViewIndexWithCurrentImageIndexPage:(NSInteger)indexPage{
    NSInteger tempIndex = indexPage+1;
    return tempIndex < self.imageURLArray.count?tempIndex:0;
}
- (NSInteger)getLastImageViewIndexWithCurrentImageIndexPage:(NSInteger)indexPage{
    NSInteger tempIndex = indexPage-1;
    if (tempIndex==-1) {
        return self.imageURLArray.count-1;
    }else{
        return tempIndex;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer invalidate];
    _timer = nil;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:_contentScrollView];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageURLArray = [NSMutableArray arrayWithCapacity:0];
        _indexPage = 0;
        [self setupScrollView];
    }
    return self;
}
@end
