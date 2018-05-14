//
//  ViewController.m
//  ImitateJDjrApp
//
//  Created by 168licai on 2018/5/14.
//  Copyright © 2018年 168licai. All rights reserved.
//

#import "ViewController.h"
#import "ViewController.h"
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define kUISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kUISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kTOPSCROLLVIEWWIDTH 300
#define kTOPSCROLLVIEWSPACE ((kUISCREEN_WIDTH-kTOPSCROLLVIEWWIDTH)/2)
@interface ViewController ()<UIScrollViewDelegate>{
    NSInteger _witchScrollView;//flag哪个scrollView 1为topScrollView 2为bottomScrollView
}
@property(nonatomic,strong)UIScrollView *bgScrollView;
@property(nonatomic,strong)UIScrollView *topScrollView;
@property(nonatomic,strong)UIScrollView *bottomScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self bgScrollView];
    [self topScrollView];
    [self bottomScrollView];
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.topScrollView && _witchScrollView == 1) {
        [self.bottomScrollView setContentOffset:CGPointMake((scrollView.contentOffset.x)*kUISCREEN_WIDTH/kTOPSCROLLVIEWWIDTH, 0)];
    }
    
    if (scrollView == self.bottomScrollView && _witchScrollView == 2) {
        [self.topScrollView setContentOffset:CGPointMake((scrollView.contentOffset.x)*kTOPSCROLLVIEWWIDTH/kUISCREEN_WIDTH, 0)];
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.topScrollView) {
        _witchScrollView = 1;
    }else if (scrollView == self.bottomScrollView){
        _witchScrollView = 2;
    }
}

#pragma mark - getter
-(UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kUISCREEN_WIDTH, kUISCREEN_HEIGHT)];
        _bgScrollView.contentSize = CGSizeMake(0, 800);
        [self.view addSubview:_bgScrollView];
    }
    return _bgScrollView;
}

-(UIScrollView *)topScrollView{
    if (!_topScrollView ){
        _topScrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        _topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(kTOPSCROLLVIEWSPACE, 0, kTOPSCROLLVIEWWIDTH, 200)];
        _topScrollView.contentSize = CGSizeMake(kTOPSCROLLVIEWWIDTH*3, 0);
        _topScrollView.backgroundColor = [UIColor whiteColor];
        _topScrollView.pagingEnabled = YES;
        _topScrollView.bounces = NO;
        _topScrollView.clipsToBounds  = NO;
        _topScrollView.delegate = self;
        _topScrollView.showsHorizontalScrollIndicator = NO;
        for (int i = 0; i<3; i++) {
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(i*kTOPSCROLLVIEWWIDTH, 0, kTOPSCROLLVIEWWIDTH, 200)];
            v.backgroundColor = randomColor;
            [_topScrollView addSubview:v];
        }
        [self.bgScrollView addSubview:_topScrollView];
        
    }
    return _topScrollView;
}
-(UIScrollView *)bottomScrollView{
    if (!_bottomScrollView ){
        _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, kUISCREEN_WIDTH, 600)];
        _bottomScrollView.contentSize = CGSizeMake(375*3, 0);
        _bottomScrollView.backgroundColor = [UIColor whiteColor];
        _bottomScrollView.delegate = self;
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.bounces = NO;
        for (int i = 0; i<3; i++) {
            UIView *v = [[UIImageView alloc] initWithFrame:CGRectMake(i*kUISCREEN_WIDTH, 0, kUISCREEN_WIDTH, 600)];
            v.backgroundColor = randomColor;
            [_bottomScrollView addSubview:v];
        }
        
        [self.bgScrollView addSubview:_bottomScrollView];
        
    }
    return _bottomScrollView;
}


@end
