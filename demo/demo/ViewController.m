//
//  ViewController.m
//  demo
//
//  Created by December on 16/4/6.
//  Copyright © 2016年 lqz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *array1 = @[];
    NSLog(@"这是数组越界测试 ＝ %@",array1[1]);
    
    NSMutableArray *array2 = [NSMutableArray new];
    [array2 addObject:nil];
    NSLog(@"这是NSMutableArray set nil object 测试");
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:nil forKey:@"key"];
    NSLog(@"这是NSMutableDictionary set nil object 测试");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
