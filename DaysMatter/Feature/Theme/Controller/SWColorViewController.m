//
//  SWColorViewController.m
//  Moments
//
//  Created by 宋国华 on 2018/10/11.
//  Copyright © 2018年 songguohua. All rights reserved.
//

#import "SWColorViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "SWTheme.h"

#define kSpacing 5.0f
#define kThumbnail (kScreenW -3*kSpacing)/4

static NSString *const Identifier = @"CollectionCellIdentifier";

@interface SWColorViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SWColorViewController

- (void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSArray *colorSELArr = @[[UIColor flatBlackColor],[UIColor flatBlackColorDark],[UIColor flatBlueColor],[UIColor flatBlueColorDark],[UIColor flatBrownColor],[UIColor flatBrownColorDark],[UIColor flatCoffeeColor],[UIColor flatCoffeeColorDark],[UIColor flatForestGreenColor],[UIColor flatForestGreenColorDark],[UIColor flatGrayColor],[UIColor flatGrayColorDark],[UIColor flatGreenColor],[UIColor flatGreenColorDark],[UIColor flatLimeColor],[UIColor flatLimeColorDark],[UIColor flatMagentaColor],[UIColor flatMagentaColorDark],[UIColor flatMaroonColor],[UIColor flatMaroonColorDark],[UIColor flatMintColor],[UIColor flatMintColorDark],[UIColor flatNavyBlueColor],[UIColor flatNavyBlueColorDark],[UIColor flatOrangeColor],[UIColor flatOrangeColorDark],[UIColor flatPinkColor],[UIColor flatPinkColorDark],[UIColor flatPlumColor],[UIColor flatPlumColorDark],[UIColor flatPowderBlueColor],[UIColor flatPowderBlueColorDark],[UIColor flatPurpleColor],[UIColor flatPurpleColorDark],[UIColor flatRedColor],[UIColor flatRedColorDark],[UIColor flatSandColor],[UIColor flatSandColorDark],[UIColor flatSkyBlueColor],[UIColor flatSkyBlueColorDark],[UIColor flatTealColor],[UIColor flatTealColorDark],[UIColor flatWatermelonColor],[UIColor flatWatermelonColorDark],[UIColor flatWhiteColor],[UIColor flatWhiteColorDark],[UIColor flatYellowColor],[UIColor flatYellowColorDark]];
    
      NSArray *colorSELArr = @[@[[UIColor flatBlackColor],[UIColor flatBlackColorDark]],
                               @[[UIColor flatBlueColor],[UIColor flatBlueColorDark]],
                               @[[UIColor flatBrownColor],[UIColor flatBrownColorDark]],
                               @[[UIColor flatCoffeeColor],[UIColor flatCoffeeColorDark]],
                               @[[UIColor flatForestGreenColor],[UIColor flatForestGreenColorDark]],
                               @[[UIColor flatGrayColor],[UIColor flatGrayColorDark]],
                               @[[UIColor flatGreenColor],[UIColor flatGreenColorDark]],
                               @[[UIColor flatLimeColor],[UIColor flatLimeColorDark]],
                               @[[UIColor flatMagentaColor],[UIColor flatMagentaColorDark]],
                               @[[UIColor flatMaroonColor],[UIColor flatMaroonColorDark]],
                               @[[UIColor flatMintColor],[UIColor flatMintColorDark]],
                               @[[UIColor flatNavyBlueColor],[UIColor flatNavyBlueColorDark]],
                               @[[UIColor flatOrangeColor],[UIColor flatOrangeColorDark]],
                               @[[UIColor flatPinkColor],[UIColor flatPinkColorDark]],
                               @[[UIColor flatPlumColor],[UIColor flatPlumColorDark]],
                               @[[UIColor flatPowderBlueColor],[UIColor flatPowderBlueColorDark]],
                               @[[UIColor flatPurpleColor],[UIColor flatPurpleColorDark]],
                               @[[UIColor flatRedColor],[UIColor flatRedColorDark]],
                               @[[UIColor flatSandColor],[UIColor flatSandColorDark]],
                               @[[UIColor flatSkyBlueColor],[UIColor flatSkyBlueColorDark]],
                               @[[UIColor flatTealColor],[UIColor flatTealColorDark]],
                               @[[UIColor flatWatermelonColor],[UIColor flatWatermelonColorDark]],
                               @[[UIColor flatWhiteColor],[UIColor flatWhiteColorDark]],
                               @[[UIColor flatYellowColor],[UIColor flatYellowColorDark]]];
    
    
    self.dataSource = [NSMutableArray arrayWithCapacity:colorSELArr.count];
    for (int index = 0; index < colorSELArr.count; index ++) {
        NSArray *colors = [colorSELArr objectAtIndex:index];
        SWTheme *theme = [[SWTheme alloc] init];
        theme.firstColor = [colors firstObject];
        theme.lastColor = [colors lastObject];
        [self.dataSource addObject:theme];
    }
    [self.collectionView reloadData];
    
}



- (void)setupNavigationItems {
    [super setupNavigationItems];
}

#pragma mark - UICollectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = kSpacing;
        layout.minimumInteritemSpacing = kSpacing;
        layout.itemSize = CGSizeMake(kThumbnail, kThumbnail);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:kScreenBounds collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColorWhite;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = YES;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:Identifier];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColorWhite;
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    SWTheme *theme = self.dataSource[indexPath.row];
    UIView *themeView = [[UIView alloc] init];
    themeView.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0, (kThumbnail - 30), (kThumbnail - 30)) andColors:@[theme.firstColor,theme.lastColor]];
    themeView.layer.cornerRadius = (kThumbnail - 30)/2;
    [cell.contentView addSubview:themeView];
    [themeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(kThumbnail - 30);
        make.center.mas_equalTo(cell.contentView);
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}
@end
