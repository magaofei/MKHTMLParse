//
//  MKHTMLParse.h
//  Example
//
//  Created by MAMIAN on 2017/3/8.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKHTMLParse : NSObject

- (void)loadTutorialsWithUrlString:(NSString *)urlString
                   pathQueryString:(NSString *)pathQueryString
                 completionHandler:(void(^)(NSArray *newItems,
                                            NSError *error))completionHandler;
@end
