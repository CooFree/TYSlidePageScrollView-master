//
//  CustomViewController.m
//  TYSlidePageScrollViewDemo
//
//  Created by tanyang on 15/7/17.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "CustomViewController.h"
#import "TYTitlePageTabBar.h"
#import "TableViewController.h"

@interface CustomViewController ()
@property (nonatomic, weak) UIButton *backBtn;
@property (nonatomic, weak) UIButton *pageBarBackBtn;

@property (nonatomic, weak) UIButton *shareBtn;
@property (nonatomic, weak) UIButton *pageBarShareBtn;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewControllers = @[[self creatViewControllerPage:0 itemNum:6],[self creatViewControllerPage:1 itemNum:16],[self creatViewControllerPage:2 itemNum:6],[self creatViewControllerPage:3 itemNum:12]];
    
    self.slidePageScrollView.pageTabBarStopOnTopHeight = _isNoHeaderView ? 0 : 20;
    
    [self addBackNavButton];
    
    [self addHeaderView];
    
    [self addTabPageMenu];
    
    [self addFooterView];
    
    [self.slidePageScrollView reloadData];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)addBackNavButton
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back-hover"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(10, 25, 30, 30);
    [backBtn addTarget:self action:@selector(navGoBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.slidePageScrollView addSubview:backBtn];
    _backBtn = backBtn;
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"share-hover"] forState:UIControlStateNormal];
    shareBtn.frame = CGRectMake(CGRectGetWidth(self.slidePageScrollView.frame)-10-30, 25, 30, 30);

    [self.slidePageScrollView addSubview:shareBtn];
    _shareBtn = shareBtn;
    
    _backBtn.hidden = _isNoHeaderView;
    _shareBtn.hidden = _isNoHeaderView;
}

- (void)addHeaderView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.slidePageScrollView.frame), 180)];
    imageView.image = [UIImage imageNamed:@"CYLoLi"];
    imageView.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 75, 100, 30)];
    label.textColor = [UIColor orangeColor];
    label.text = @"headerView";
    [imageView addSubview:label];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 105, 320, 30)];
    label1.textColor = [UIColor orangeColor];
    label1.text = @"pageTabBarStopOnTopHeight 20 ↓↓";
    [imageView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 135, 320, 30)];
    label2.textColor = [UIColor orangeColor];
    label2.text = @"pageTabBarIsStopOnTop YES ↓↓";
    [imageView addSubview:label2];
    
    self.slidePageScrollView.headerView = _isNoHeaderView ? nil : imageView;
}

- (void)addTabPageMenu
{
    TYTitlePageTabBar *titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:@[@"简介",@"课程",@"评论",@"答疑"]];
    titlePageTabBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.slidePageScrollView.frame), _isNoHeaderView?50:40);
    titlePageTabBar.edgeInset = UIEdgeInsetsMake(_isNoHeaderView?20:0, 50, 0, 50);
    titlePageTabBar.titleSpacing = 10;
    titlePageTabBar.backgroundColor = [UIColor lightGrayColor];
    self.slidePageScrollView.pageTabBar = titlePageTabBar;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back-darkGray"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(10, _isNoHeaderView?20:5, 30, 30);
    [backBtn addTarget:self action:@selector(navGoBack:) forControlEvents:UIControlEventTouchUpInside];
    [titlePageTabBar addSubview:backBtn];
    //backBtn.hidden = YES;
    _pageBarBackBtn = backBtn;
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    shareBtn.frame = CGRectMake(CGRectGetWidth(self.slidePageScrollView.frame)-10-30, _isNoHeaderView?20:5, 30, 30);
    //shareBtn.hidden = YES;
    [titlePageTabBar addSubview:shareBtn];
    _pageBarShareBtn = shareBtn;
    
    _pageBarShareBtn.hidden = !_isNoHeaderView;
    _pageBarBackBtn.hidden = !_isNoHeaderView;
}

- (void)addFooterView
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.slidePageScrollView.frame), 40)];
    footerView.backgroundColor = [UIColor orangeColor];
    UILabel *lable = [[UILabel alloc]initWithFrame:footerView.bounds];
    lable.textColor = [UIColor whiteColor];
    lable.text = @"  footerView";
    [footerView addSubview:lable];
    
    self.slidePageScrollView.footerView = footerView;
}

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageTabBarScrollOffset:(CGFloat)offset state:(TYPageTabBarState)state
{
    switch (state) {
        case TYPageTabBarStateStopOnTop:
            NSLog(@"TYPageTabBarStateStopOnTop");
            _backBtn.hidden = YES;
            _pageBarBackBtn.hidden = NO;
            
            _shareBtn.hidden = YES;
            _pageBarShareBtn.hidden = NO;
            break;
        case TYPageTabBarStateStopOnButtom:
            NSLog(@"TYPageTabBarStateStopOnButtom");
            break;
        default:
            if (_backBtn.isHidden) {
                _backBtn.hidden = NO;
            }
            if (!_pageBarBackBtn.isHidden) {
                _pageBarBackBtn.hidden = YES;
            }
            
            if (_shareBtn.isHidden) {
                _shareBtn.hidden = NO;
            }
            if (!_pageBarShareBtn.isHidden) {
                _pageBarShareBtn.hidden = YES;
            }
            break;
    }
}

- (void)clickedPageTabBarStopOnTop:(UIButton *)button
{
    button.selected = !button.isSelected;
    self.slidePageScrollView.pageTabBarIsStopOnTop = !button.isSelected;
}

- (void)navGoBack:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIViewController *)creatViewControllerPage:(NSInteger)page itemNum:(NSInteger)num
{
    TableViewController *tableViewVC = [[TableViewController alloc]init];
    tableViewVC.itemNum = num;
    tableViewVC.page = page;
    return tableViewVC;
}

//- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView horizenScrollToPageIndex:(NSInteger)index
//{
//    // 测试 reloadData 正常
//    TableViewController *VC = self.viewControllers[index];
//    [VC.tableView reloadData];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
