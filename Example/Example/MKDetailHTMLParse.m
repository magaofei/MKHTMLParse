//
//  MKDetailHTMLParse.m
//  Example
//
//  Created by MAMIAN on 2017/3/12.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKDetailHTMLParse.h"

#import "TFHpple.h"
#import "MKNewsItem.h"


@implementation MKDetailHTMLParse

#pragma mark - 格式化数据
- (void)loadTutorialsWithUrlString:(NSString *)urlString
                   pathQueryString:(NSString *)pathQueryString
                 completionHandler:(void(^)(NSArray *newItems,
                                            //                                            NSString *newsPageCount,
                                            //                                            NSDate *lastRefreshTime ,
                                            NSError *error))completionHandler {
    
    
    //    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //        NSData * data;
        //        if ([response isKindOfClass:[NSData class]]) {
        //            data = responseObject;
        //        }
        
        
        if (error) {
            if (completionHandler) {
                completionHandler(nil, error);
            }
        } else {
            
            NSMutableArray *newsGroup = [NSMutableArray array];
            
            TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:data];
            //        TFHpple *hppleU = [[TFHpple alloc] initWithHTMLData:dataU];
            
            //参考网址 https://www.raywenderlich.com/14172/how-to-parse-html-on-ios
            //3
            //            NSString *pathQueryString = pathQueryString; //
            
            
            NSArray *Nodes = [hpple searchWithXPathQuery:pathQueryString];//搜索这个css
            
            
        
            for (TFHppleElement *element in Nodes) {
                
                
                
//                NSDictionary *dict = [element attributes];
                
//                NSString *src = [element objectForKey:@"src"];
                // 遍历到所有的img标签
                NSArray *n = [element searchWithXPathQuery:@"//img"];

                if (n) {
                    for (TFHppleElement *eleme in n) {
                        NSDictionary *dict = [eleme attributes];
                        NSString *src = dict[@"src"];
                        NSLog(@"%@", src);
                        
                    }
                }
                
                
                MKNewsItem *newsItem = [[MKNewsItem alloc] init];
                
                
                
                // 6
                //                tutorial.title = [[element firstChild] content];
                newsItem.title = [element text];
                
                newsItem.time = [element content];
                
//                newsItem.title =
//                newsItem.time = [[element firstChildWithTagName:@"span"] content];
//                NSMutableString *tempTime = [NSMutableString stringWithFormat:@"%@", newsItem.time];
                
//                //删除时间前后的[]字符
//                [tempTime replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
//                [tempTime replaceCharactersInRange:NSMakeRange(10, 1) withString:@""];
//                newsItem.time = tempTime;
                //获取第一个标签是span标签内容
                //返回每个属性的文字
                //        NSString *str = [element text];
                //        NSString *str2 = [[element firstChild] content];
                // 7
//                newsItem.urlStr = [element objectForKey:@"href"];
                
                [newsGroup addObject:newsItem];
                
                
            }
            
            
            
            if (completionHandler) {
                completionHandler(newsGroup, nil);
            }
            
        }
    }] ;
    
    [dataTask resume];
    
}


@end
