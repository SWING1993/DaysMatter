//
//  CreateMatterController.m
//  DaysMatter
//
//  Created by 宋国华 on 2018/10/29.
//  Copyright © 2018 songguohua. All rights reserved.
//

#import "CreateMatterController.h"

@interface CreateMatterController ()

@end

@implementation CreateMatterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    @weakify(self)
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemStop handler:^(id sender) {
        @strongify(self)
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
}

@end
