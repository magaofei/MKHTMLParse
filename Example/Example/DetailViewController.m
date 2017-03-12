//
//  DetailViewController.m
//  Example
//
//  Created by MAMIAN on 2017/3/12.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "DetailViewController.h"
#import "MKDetailHTMLParse.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MKDetailHTMLParse *parse = [[MKDetailHTMLParse alloc] init];
    
    
    
    
    // 想要把网页的详细内容抓取， 我想这里需要用到正则
    _urlStr = [NSString stringWithFormat:@"%@%@", @"http://www.ayit.edu.cn/", _urlStr];
    
//    [parse loadTutorialsWithUrlString:@"http://www.ayit.edu.cn/info/1056/4584.htm" pathQueryString:@"/html/body/div[5]/div[2]/form/div/div[2]" completionHandler:^(NSArray *newItems, NSError *error) {
//        
//       
//        NSLog(@"%@", newItems);
//        
//    }];
    
    //   //*[@id="vsb_content_3"]
    
    [parse loadTutorialsWithUrlString:@"http://www.ayit.edu.cn/info/1057/4588.htm" pathQueryString:@"//*[@id=\"vsb_content_3\"]" completionHandler:^(NSArray *newItems, NSError *error) {
        
        
        NSLog(@"%@", newItems);
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
