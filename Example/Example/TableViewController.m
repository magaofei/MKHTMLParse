//
//  TableViewController.m
//  Example
//
//  Created by MAMIAN on 2017/3/8.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "TableViewController.h"
#import "MKHTMLParse.h"
#import "MKNewsItem.h"

#import "DetailViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation TableViewController

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
        
    }
    return _items;
}

static NSString *ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    MKHTMLParse *parse = [[MKHTMLParse alloc] init];
    
    
    [parse loadTutorialsWithUrlString:@"http://www.ayit.edu.cn/xwzx/ybdt.htm" pathQueryString:@"//div[@class='newslist l']/ul/li/a" completionHandler:^(NSArray *newItems, NSError *error) {
        
        [self.items addObjectsFromArray:newItems];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    MKNewsItem *item = self.items[indexPath.row];
    cell.textLabel.text = item.title;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 跳转
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    MKNewsItem *item = self.items[indexPath.row];
    detailVC.urlStr = item.urlStr;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
