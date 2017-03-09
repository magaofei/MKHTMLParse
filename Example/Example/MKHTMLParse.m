//
//  MKHTMLParse.m
//  Example
//
//  Created by MAMIAN on 2017/3/8.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "MKHTMLParse.h"
#import "TFHpple.h"
#import "MKNewsItem.h"

@implementation MKHTMLParse


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
    
    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //    NSURLSessionDataTask *dataTask;
    
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest: request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
    
        
        // 这里替换为 原生的NSURLSessionDataTask后会开新的线程执行，而上面的AF则不会开启新的线程，
    
    
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
            
            // 查找出总页数
//            NSString *newsCountQueryString = @"//td[@id='fanye126886']";
            //            NSArray *NodesU = [hpple searchWithXPathQuery:newsCountQueryString];//搜索这个css
//            TFHppleElement *element = [hpple peekAtSearchWithXPathQuery:newsCountQueryString];//搜索这个css
//            NSString *newsCount = [element text];
//            NSArray *arr = [newsCount componentsSeparatedByString:@"/"];
//            newsCount = [arr lastObject];
            
            /* 当前页 暂时没用
             NSString *currentPageNumber = [arr firstObject];
             // 得到最后一个字符，就是 currentPageNumber
             NSInteger len = currentPageNumber.length;
             currentPageNumber = [currentPageNumber substringWithRange:NSMakeRange(len - 1, 1)];
             //            arr = [currentPageNumber componentsSeparatedByString:@"\ "];
             //            currentPageNumber = [arr lastObject];
             */
            //4
            
            
            
            for (TFHppleElement *element in Nodes) {
                
                MKNewsItem *newsItem = [[MKNewsItem alloc] init];
                
                
                // 6
                //                tutorial.title = [[element firstChild] content];
                newsItem.title = [element text];
                newsItem.time = [[element firstChildWithTagName:@"span"] content];
                NSMutableString *tempTime = [NSMutableString stringWithFormat:@"%@", newsItem.time];
                
                //删除时间前后的[]字符
                [tempTime replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
                [tempTime replaceCharactersInRange:NSMakeRange(10, 1) withString:@""];
                newsItem.time = tempTime;
                //获取第一个标签是span标签内容
                //返回每个属性的文字
                //        NSString *str = [element text];
                //        NSString *str2 = [[element firstChild] content];
                // 7
                newsItem.urlStr = [element objectForKey:@"href"];
                
                [newsGroup addObject:newsItem];
                
                
            }
            
            
            
            
//            //放到缓存中
//            //Cache目录
//            NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//            //根据传入的文件名调用相关的文件，默认为安工要闻
//            NSString *filePath = [path stringByAppendingPathComponent:_plistName];
//            
//            // 存放数据
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//            dict[@"newsCount"] = newsCount;
//            dict[@"newsInfo"] = newsGroup;
//            
//            NSDate *lastRefreshTime = [NSDate date];
//            dict[@"lastRefreshTime"] = lastRefreshTime;
//            
//            
//            
//            BOOL WriteToFileBOOL = [NSKeyedArchiver archiveRootObject:dict toFile:filePath];
//            
//            if (WriteToFileBOOL) { //写入成功
//                MKLog(@"写入成功");
//                MKLog(@"%@", filePath);
//                
//                
//            } else {   //写入失败
//                MKLog(@"写入失败");
//                
//                
//                
//            }
            
//            
//            if (completionHandler) {
//                completionHandler(newsGroup, newsCount, lastRefreshTime, nil);
//            }
            
            if (completionHandler) {
                completionHandler(newsGroup, nil);
            }
            
        }
    }] ;
    
    [dataTask resume];
    
}

@end
