//
//  ViewController.m
//  Masonry学习
//
//  Created by LiChunxing on 16/3/31.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import <Masonry.h>
#import "ViewController.h"
#import "BaseController.h"
#import "UpdateConstrainsController.h"
#import "RemakeConstrainsController.h"
#import "TotallyUpdateConstrainViewController.h"
#import "CompositeConstrainsController.h"
#import "AspectFitConstrainsController.h"
#import "TableConstrainsController.h"
#import "SimpleScrollConstrainController.h"
#import "complexScrollConstrainsController.h"
#import "NormalScrollConstrainController.h"

@interface ViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *viewControllers;

@end

static NSString *const reuseIdentifier = @"cell";

@implementation ViewController

- (NSArray *)viewControllers{
    
    if(_viewControllers){
        return _viewControllers;
    }
    BaseController *baseController = [[BaseController alloc] initWithTitle:@"基础使用"];
    UpdateConstrainsController *updateController = [[UpdateConstrainsController alloc] initWithTitle:@"更新约束"];
    RemakeConstrainsController *remakeController = [[RemakeConstrainsController alloc] initWithTitle:@"重置约束"];
    TotallyUpdateConstrainViewController *totallyController = [[TotallyUpdateConstrainViewController alloc] initWithTitle:@"整体更新"];
    CompositeConstrainsController *compositeController = [[CompositeConstrainsController alloc] initWithTitle:@"复合约束"];
    AspectFitConstrainsController *aspectConstrains = [[AspectFitConstrainsController alloc] initWithTitle:@"百分比约束"];
    TableConstrainsController *tableController = [[TableConstrainsController alloc] initWithTitle:@"动态高度cell"];
    SimpleScrollConstrainController *scrollController = [[SimpleScrollConstrainController alloc] initWithTitle:@"简单的ScrollView"];
    complexScrollConstrainsController *complexScrollController = [[complexScrollConstrainsController alloc] initWithTitle:@"复杂的ScrollView"];
    NormalScrollConstrainController *normalScrolController = [[NormalScrollConstrainController alloc] initWithTitle:@"ScrollView实战"];
    _viewControllers = @[baseController, updateController, remakeController, totallyController, compositeController, aspectConstrains, tableController, scrollController, complexScrollController, normalScrolController];
    return _viewControllers;
}

- (UITableView *)tableView{
    
    if(_tableView){
        return _tableView;
    }
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    [self.tableView setPreservesSuperviewLayoutMargins:NO];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setTableFooterView:nil];
    [self.tableView setTableHeaderView:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewControllers.count;
    
};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    UIViewController *currentViewController = [self.viewControllers objectAtIndex:[indexPath row]];
    cell.textLabel.text = currentViewController.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *currentViewController = [self.viewControllers objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:currentViewController animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


@end





