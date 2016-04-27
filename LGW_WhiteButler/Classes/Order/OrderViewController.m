//
//  OrderViewController.m
//  LGW_WhiteButler
//
//  Created by Lilong on 16/4/27.
//  Copyright © 2016年 第七代目. All rights reserved.
//

#import "OrderViewController.h"

//cells
#import "OrderTypeCell.h"

#define SeletionCellHight 44
@interface OrderViewController ()

@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIButton *navBtn;

@property (weak, nonatomic) IBOutlet UIView *noDataView;
@property (weak, nonatomic) IBOutlet UIImageView *hintImageView;

@property (weak, nonatomic) IBOutlet UITableView *selectionTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectionTableViewHeight;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 选择订单种类数组
@property (strong, nonatomic) NSArray *selectionArr;
// 订单数组
@property (strong, nonatomic) NSMutableArray *orderList;
@end

@implementation OrderViewController

#pragma mark 隐藏Nav
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}
#pragma mark - UINavigationControllerDelegate

// 解决手势返回卡屏问题
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        // disable interactivePopGestureRecognizer in the rootViewController of navigationController
        if ([[navigationController.viewControllers firstObject] isEqual:viewController]) {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        } else {
            // enable interactivePopGestureRecognizer
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectionArr = [[NSArray alloc] init];
    self.orderList = [[NSMutableArray alloc] init];
    self.selectionTableViewHeight.constant = 0;
    
    [self getData];
    [self.selectionTableView registerNib:[UINib nibWithNibName:@"OrderTypeCell" bundle:nil] forCellReuseIdentifier:@"OrderTypeCell"];
    // Do any additional setup after loading the view.
}

- (void)getData{
    self.selectionArr = @[@"全部订单",@"收件订单",@"寄件订单",@"卡券订单",@"送水订单"];
    [self.selectionTableView reloadData];
}



#pragma mark -tableViewDelegate -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.selectionTableView) {
        return self.selectionArr.count;
    }else{
        return  self.orderList.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.selectionTableView) {
        return SeletionCellHight;
    }else{
        return 99;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.selectionTableView) {
        OrderTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTypeCell" forIndexPath:indexPath];
        return cell;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 关闭菜单
    [self closeMenuView];
}


// 导航栏按钮点击事件
- (IBAction)navBtnAction:(id)sender {
    self.navBtn.selected = !self.navBtn.selected;
    [self arrowStatusIsDown:self.navBtn.selected];
    
    if (self.navBtn.selected) {
        [self openMenuView];
    }else{
        [self closeMenuView];
    }
}
//打开菜单view
- (void)openMenuView{
    [UIView animateWithDuration:0.8 animations:^{
        self.selectionTableViewHeight.constant = SeletionCellHight * self.selectionArr.count;
        [self.selectionTableView layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}
//关闭菜单view
- (void)closeMenuView{
    [UIView animateWithDuration:0.8 animations:^{
        self.selectionTableViewHeight.constant = 0;
        [self.selectionTableView layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

// 箭头图片转换 up —— down
- (void)arrowStatusIsDown:(BOOL)value {
    self.arrowImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    if (value == YES) {
        [UIView animateWithDuration:0.1 animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
    else {
        [UIView animateWithDuration:0.1 animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}
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
