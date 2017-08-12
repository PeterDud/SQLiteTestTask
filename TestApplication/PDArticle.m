//
//  PDArticle.m
//  TestApplication
//
//  Created by Lavrin on 8/6/17.
//  Copyright © 2017 Embrace. All rights reserved.
//

#import "PDArticle.h"

@implementation PDArticle

- (instancetype)initWithServerResponse:(NSDictionary *)response
{
    self = [super init];
    if (self) {
        
        self.title = [response objectForKey:@"title"];
        self.imageURL = [NSURL URLWithString:[response objectForKey:@"urlToImage"]];
        self.desc = [response objectForKey:@"description"];
        self.url = [response objectForKey:@"url"];
        self.publishedAt = [response objectForKey:@"publishedAt"];

    }
    return self;
}

@end
