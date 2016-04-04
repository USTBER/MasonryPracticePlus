//
//  TableConstrainsController.m
//  Masonry学习
//
//  Created by LiChunxing on 16/4/1.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import "TableConstrainsController.h"
#import "People.h"
//#import "LCHAutoHeightCellPlus.h"
#import "LCHAutoHeightCell.h"

@interface TableConstrainsController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSMutableArray *peoples;
@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *const reuseIdentifier = @"LCHCell";

@implementation TableConstrainsController


- (UITableView *)tableView{
    
    if(_tableView){
        return _tableView;
    }
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.bounces = NO;
    WeakSelf(weakSelf);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    return _tableView;
}

- (NSMutableArray *)peoples{
    
    if(_peoples){
        return _peoples;
    }
    _peoples = [[NSMutableArray alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Peoples" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:filePath];
    for(NSDictionary *dic in arr){
        NSString *name = [dic objectForKey:@"name"];
        NSString *information = [dic objectForKey:@"information"];
        People *p = [[People alloc] initWithName:name information:information];
        [_peoples addObject:p];
    }
    return _peoples;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LCHAutoHeightCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.peoples.count;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 200.f;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [LCHAutoHeightCell cellHeightWithPeople:[self.peoples objectAtIndex:[indexPath row]]];
    return height;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LCHAutoHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.people = [self.peoples objectAtIndex:[indexPath row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect frame = cell.frame;
    CGFloat Y = frame.origin.y;
    CGFloat Height = frame.size.height;
    NSLog(@"按下cell,Y坐标是: %f  高度是: %f", Y, Height);
}

@end
