//
//  JWRoom.h
//  live
//
//  Created by Jungle Wind on 6/12/16.
//  Copyright © 2016 Jungle Wind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWRoom : NSObject

@property (strong, nonatomic) NSString *roomId;

@property (strong, nonatomic) NSString *title;

@property (assign, nonatomic) NSInteger audienceCount;

@end
