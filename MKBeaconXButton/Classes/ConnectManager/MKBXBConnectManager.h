//
//  MKBXBConnectManager.h
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBXBConnectManager : NSObject

/// 当前连接密码
@property (nonatomic, copy)NSString *password;

/// 是否需要密码连接
@property (nonatomic, assign)BOOL needPassword;

+ (MKBXBConnectManager *)shared;

@end

NS_ASSUME_NONNULL_END
