//
//  AddUserModel.h
//  红包Demo
//
//  Created by xiaerfei on 15/8/26.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AddUserModelType){
    AddUserModelTypeAllUser,    //所有用户
    AddUserModelTypeSingleUser, //单个用户
};



@interface AddUserModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) AddUserModelType addUserModelType;
@property (nonatomic, assign) BOOL isSelected;
@end
