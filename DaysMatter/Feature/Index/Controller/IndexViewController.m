//
//  IndexViewController.m
//  Moments
//
//  Created by 宋国华 on 2018/9/11.
//  Copyright © 2018年 songguohua. All rights reserved.
//

#import "IndexViewController.h"
#import "SWColorViewController.h"
#import "IndexHeaderView.h"
#import "SWMatter.h"


@interface IndexViewController ()<GADBannerViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) IndexHeaderView* tableViewHeader;
@end

@implementation IndexViewController

- (void)initSubviews {
    [super initSubviews];
    self.view.backgroundColor = UIColorForBackground;
}

- (void)initTableView {
    [super initTableView];
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    self.tableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.tableViewHeader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSMutableArray array];
    RLMResults *matters = [SWMatter allObjects];
    if (matters.count == 0) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        SWMatter *matter1 = [[SWMatter alloc] init];
        matter1.title = @"发工资";
        matter1.date = [[NSDate date] dateByAddingDays:130];
        matter1.category = @"生活";
        matter1.categoryImageName = @"xxx.png";
        
        SWMatter *matter2 = [[SWMatter alloc] init];
        matter2.title = @"生日";
        matter2.date = [[NSDate date] dateByAddingDays:-55];
        matter2.category = @"生活";
        matter2.categoryImageName = @"xxx.png";
        
        [realm beginWriteTransaction];
        [realm addObject:matter1];
        [realm addObject:matter2];
        [realm commitWriteTransaction];
         
        [self.dataSource addObject:matter1];
        [self.dataSource addObject:matter2];

    } else {
        for (int i = 0; i < matters.count; i ++) {
            SWMatter *matter = [matters objectAtIndex:i];
            [self.dataSource addObject:matter];
        }
    }
    
    [self.tableView reloadData];

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUITableViewCell *cell = (QMUITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initForTableView:tableView withStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = UIColorMakeX(33);
        cell.detailTextLabel.textColor = UIColorGray;
    }
    SWMatter *matter = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",matter.category,[matter.date formatYMD]];
    if ([NSDate getDaysFrom:matter.date To:[NSDate date]] > 0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"距离%@还有%zi天",matter.title,[NSDate getDaysFrom:matter.date To:[NSDate date]]];

    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@发生已经%zi天",matter.title,[NSDate getDaysFrom:matter.date To:[NSDate date]]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWColorViewController *controller = [[SWColorViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
