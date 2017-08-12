//
//  PDArticle.h
//  TestApplication
//
//  Created by Lavrin on 8/6/17.
//  Copyright © 2017 Embrace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface PDArticle : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *publishedAt;
@property (strong, nonatomic) NSString *desc;
@property (weak, nonatomic) UIImage *articleImageView;

- (instancetype) initWithServerResponse: (NSDictionary *) response;

@end
