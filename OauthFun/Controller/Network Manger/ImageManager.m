//
//  ImageManager.m
//  OauthFun
//
//  Created by eric yu on 5/27/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager

+(id)sharedService {
    static ImageManager *sharedService = nil;
    sharedService = [[self alloc]init];
    return self;
}

-(void)fetchAvatarImagesFrom:(NSArray *)urls completionHandler:(void (^)(NSArray* images))completionHandler {
    
    
    
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray *images = [[NSMutableArray alloc]init];
    
    NSInteger divider = 3;
    NSInteger urlsPerTask = urls.count / divider ;
    NSInteger remainderURLs = urls.count % divider ;
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
       
        NSArray *firstFew = [urls subarrayWithRange:NSMakeRange(0, urlsPerTask != 0 ? urlsPerTask : remainderURLs)];
        for (NSString *url in firstFew) {
            [images addObject:[self getAvatarFrom:url]];
        }
    });
    
    if (urlsPerTask != 0) {
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSArray *secondTen = [urls subarrayWithRange:NSMakeRange(urlsPerTask - 1, urlsPerTask)];
            for (NSString *url in secondTen) {
                [images addObject:[self getAvatarFrom:url]];
            }
        });
        
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSArray *thirdTen = [urls subarrayWithRange:NSMakeRange(urlsPerTask * 2 - 1, urlsPerTask + remainderURLs)];
            for (NSString *url in thirdTen) {
                [images addObject:[self getAvatarFrom:url]];
            }
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        completionHandler(images);
    });
    
}
-(UIImage *)getAvatarFrom:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:url];
    return [UIImage imageWithData:imageData];
}


@end
