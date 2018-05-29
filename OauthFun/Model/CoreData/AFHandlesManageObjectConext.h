//
//  AFHandlesManageObjectConext.h
//  OauthFun
//
//  Created by eric yu on 5/28/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol AFHandlesManageObjectConext <NSObject>

-(void)recevieManageObjectContext: (NSManagedObjectContext *) incomingMangedObjectContext;

@end
