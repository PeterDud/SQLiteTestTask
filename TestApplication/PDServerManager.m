//
//  PDServerManager.m
//  TestApplication
//
//  Created by Lavrin on 8/6/17.
//  Copyright © 2017 Embrace. All rights reserved.
//

#import "PDServerManager.h"
#import "PDArticle.h"

@implementation PDServerManager

+ (PDServerManager*) sharedManager {
    
    static PDServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PDServerManager alloc] init];
    });
    
    return manager;
}

- (void) getNewsOnSuccess:(void(^)(NSArray* articles)) success
                onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSString *dataUrl =
    @"https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey=c3ebfa7945194cb89a9e98340a695027";
    
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    NSURLSessionDataTask *downloadTask =
    [[NSURLSession sharedSession]
    dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                           options:kNilOptions
                                                             error:&error];
        NSMutableArray *articles = [NSMutableArray array];
        NSArray *responses = [jsonResponse objectForKey:@"articles"];
        
        for (NSDictionary *response in responses) {
            
            PDArticle *article = [[PDArticle alloc] initWithServerResponse:response];
            [articles addObject: article];
        }

        if (success) {
            success(articles);
        }
    }];
    
    [downloadTask resume];
}






@end
