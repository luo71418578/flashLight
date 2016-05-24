//
//  modelUser.h
//  flashlight
//
//  Created by luo on 16/5/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHSSingleton.h"
@interface modelUser : NSObject

@property (copy ,nonatomic) NSString *name;
@property (copy ,nonatomic) NSString *sex;
@property (copy ,nonatomic) NSString *height;

//LhsSingletonH(modelUser);

@end
