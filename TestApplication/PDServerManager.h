//
//  PDServerManager.h
//  TestApplication
//
//  Created by Lavrin on 8/6/17.
//  Copyright © 2017 Embrace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDServerManager : NSObject

+ (PDServerManager*) sharedManager;
- (void) getNewsOnSuccess:(void(^)(NSArray* articles)) success
                onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

@end
