//
//  IndexViewController.m
//  Moments
//
//  Created by 宋国华 on 2018/9/11.
//  Copyright © 2018年 songguohua. All rights reserved.
//

#import "IndexViewController.h"
#import "MLMSegmentManager.h"
#import "DaysMatterListViewController.h"
#import "SWMatter.h"
#import "CreateMatterController.h"

@interface IndexViewController (){
    NSArray *list;
}
@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@end

@implementation IndexViewController

- (void)initSubviews {
    [super initSubviews];
    [self setTitle:@"DaysMatter"];
    self.view.backgroundColor = UIColorForBackground;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSegment];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    @weakify(self)
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemAdd handler:^(id sender) {
        @strongify(self)
        CreateMatterController *controller = [[CreateMatterController alloc] init];
        QMUINavigationController *nav = [[QMUINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:NULL];
    }];
}

#pragma mark - 居左下划线
- (void)initSegment {
    RLMResults *matters = [SWMatter allObjects];
    NSMutableDictionary *keyValues = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < matters.count; i ++) {
        SWMatter *matter = [matters objectAtIndex:i];
        [keyValues setObject:@"zz" forKey:[NSString stringWithFormat:@"  %@  ",matter.category]];
    }

    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:keyValues.allKeys];
    [tempArr insertObject:@"  全部  " atIndex:0];
    list = [tempArr copy];
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, self.qmui_navigationBarMaxYInViewCoordinator, SCREEN_WIDTH, 40) titles:list headStyle:SegmentHeadStyleArrow layoutStyle:MLMSegmentLayoutLeft];
    _segHead.lineColor = FlatSkyBlueDark;
    _segHead.fontSize = 14;
    _segHead.lineScale = .9;
    _segHead.bottomLineHeight = PixelOne;
    _segHead.bottomLineColor = UIColorMake(220, 220, 220);
    _segHead.headColor = UIColorThemeForSub;
    _segHead.selectColor = UIColorWhite;
    _segHead.deSelectColor = UIColorMakeX(225);
    _segHead.arrowColor = UIColorWhite;
    _segHead.bottomLineColor = UIColorWhite;
    
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(_segHead.frame)) vcOrViews:[self vcArr:list.count]];
    _segScroll.loadAll = NO;
    _segScroll.showIndex = 0;
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        [self.view addSubview:self.segHead];
        [self.view addSubview:self.segScroll];
    }];
}

#pragma mark - 数据源
- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i ++) {
        DaysMatterListViewController *vc = [DaysMatterListViewController new];
        [arr addObject:vc];
    }
    return arr;
}

- (void)dealloc {
    NSLog(@"释放");
}

@end
