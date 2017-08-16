//
//  MyOneViewController.m
//  iOS11 新特性
//
//  Created by ml on 2017/8/4.
//  Copyright © 2017年 ml. All rights reserved.
//

#import "MyOneViewController.h"
#import "MySearchResultViewController.h"
@interface MyOneViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)UISearchController *searchVC;
@end

@implementation MyOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorNamed:@"Mybest"];
    self.navigationItem.searchController = self.searchVC;
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(changeColor2)];
//    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    view4.backgroundColor=[UIColor blackColor];
//    UIBarButtonItem *barBtn4=[[UIBarButtonItem alloc]initWithCustomView:view4];
    self.navigationItem.rightBarButtonItem = barBtn2;
    self.title = @"大标题";
    self.navigationItem.searchController = self.searchVC;
    //self.navigationItem.hidesSearchBarWhenScrolling = NO;
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.view addSubview:self.myTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)changeColor2 {
    
}
#pragma mark - UITableViewDataSource
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"IOS11";
    cell.detailTextLabel.text = @"11111";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    vc.title = @"二级界面";
    vc.view.backgroundColor = [UIColor blueColor];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

/*
 UIContextualAction
 表示的是滑开后显示的一个操作按钮，它有下面几个属性：
 style: 有2个可选值：.normal 和 .destructive，区别是背景色不同，.normal是灰色，.destructive是红色。当然如果手动设置了action.backgroundColor，则以backgroundColor为准。
 还有一个区别，下面会说。
 title: action显示的文字，目前没有发现api可以修改这个title的font和color
 image: 设置action的图片，设置了image就不会显示文字了
 handler: 点击action后的回调，它的定义如下：
 
 UIContextualAction: 就是当前所属的action
 UIView: 可以理解成action所呈现出来的那个视图。如果是action是文字的，view是一个叫做UIButtonLabel的,如果是image的，view则是UIImageView
 (Bool) -> Swift.Void: 这个参数是一个闭包，他的作用是一个completionHandler，在handler的定义上面，已经给出了说明，意思是在handler里你应该调用这个completionHandler，以恢复到正常状态（可以看上面那个效果图，点击action后，cell会恢复到未左滑的状态）如果不调用，点击后就会是保持现有的左侧滑开的状态。
 而且这个completionHandler也需要一个Bool类型的参数，传true和传false的区别？官方的说明是pass YES to the completionHandler if the action was actually performed
 其实这个就是style中的normal和destructive的另一个区别。
 我们知道，destructive的意思是危险操作，一般表示的是删除。如果你调用completionHandler传的是true，当style=.destructive时，系统会删掉这个cell，没错，删掉这个cell！按照官方的解释可以理解成，destructive就是删除，你传了true，说明action actually performed，那系统就会删掉这个cell.
 对于style=.normal的，我试了，传true和false，没区别。
 
 */

//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 添加一个删除按钮
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了删除");
//    }];
//
//    // 删除一个置顶按钮
//    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了置顶");
//    }];
//    topRowAction.backgroundColor = [UIColor blueColor];
//
//    // 添加一个更多按钮
//    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了更多");
//
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
//    }];
//    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//
//    // 将设置好的按钮放到数组中返回
//    return @[deleteRowAction, topRowAction, moreRowAction];
//
//}

- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        completionHandler (YES);
    }];
    UIContextualAction *upRowAction = [UIContextualAction contextualActionWithStyle:    UIContextualActionStyleNormal title:@"置顶" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        completionHandler (YES);
    }];
    deleteRowAction.backgroundColor = [UIColor blueColor];
    upRowAction.backgroundColor = [UIColor redColor];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:
                                           @[deleteRowAction,upRowAction]];
    return config;
}

- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //置顶
    
    UIContextualAction *upRowAction = [UIContextualAction contextualActionWithStyle:    UIContextualActionStyleNormal title:@"置顶" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        completionHandler (YES);
    }];
    upRowAction.backgroundColor = [UIColor redColor];

    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:
                                           @[upRowAction]];
    return config;
}

#pragma mark Getter
- (UITableView *)myTableView{
    CGFloat width   = [[UIScreen mainScreen] bounds].size.width;
//    CGFloat height = self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    if (!_myTableView) {
            _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, self.view.frame.size.height) style:UITableViewStylePlain];
            _myTableView.backgroundColor = [UIColor whiteColor];
            _myTableView.delegate = self;
            _myTableView.dataSource = self;
            [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
            _myTableView.tableFooterView = [UIView new];
            _myTableView.showsVerticalScrollIndicator = NO;
            _myTableView.delaysContentTouches = NO;
        _myTableView.contentInsetAdjustmentBehavior =  UIScrollViewContentInsetAdjustmentNever;
    }
    return _myTableView;
}


//- (UISearchController *)searchVC {
//    if (!_searchVC) {
//        _searchVC = [[UISearchController alloc] init];
//        _searchVC.searchResultsUpdater = self;
//    }
//    return _searchVC;
//}
- (UISearchController *)searchVC{
    if (!_searchVC) {
        MySearchResultViewController *searchResultsController = [MySearchResultViewController new];
        _searchVC = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
        _searchVC.searchResultsUpdater = searchResultsController;
        _searchVC.delegate = self;
        [_searchVC.searchBar setImage:[UIImage imageNamed:@"ic_search_small"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        _searchVC.dimsBackgroundDuringPresentation = YES;
        _searchVC.hidesNavigationBarDuringPresentation = YES;
        self.definesPresentationContext = YES;
//        _searchVC.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    }
    return _searchVC;
    
}
@end
