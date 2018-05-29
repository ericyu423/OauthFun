//
//  AFHandlesUserEntity.h
//  OauthFun
//
//  Created by eric yu on 5/28/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AFHandlesUserEntity <NSObject>

-(void)recevieUserEntity: (StockUser *) incomingUserEntity;

@end
