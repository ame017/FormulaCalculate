//
//  AMENetworkTool.m
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "AMENetworkTool.h"
#import "NSString+AMEString.h"


@implementation AMENetworkTool

+ (void)getInternetDateWithCompletion:(void(^)(NSDate * date,BOOL isError))completion;{
    NSString *urlString = @"http://m.baidu.com";
    urlString = [urlString ame_stringToUTF8];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 2];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * task = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        BOOL isError = NO;
        NSDate * resultDate = [NSDate new];
        if (error) {
            isError = YES;
            resultDate = [NSDate date];
        }else{
//            NSLog(@"response is %@",response);
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
            NSString *date = [[httpResponse allHeaderFields] objectForKey:@"Date"];
            date = [date substringFromIndex:5];
            date = [date substringToIndex:[date length]-4];
            NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
            dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
            resultDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
        }
        completion(resultDate,isError);
    }];
    [task resume];
}

+ (NSDictionary *)getJsonDictionaryWithString:(NSString *)string{
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
    return jsonDictionary;
}
@end
