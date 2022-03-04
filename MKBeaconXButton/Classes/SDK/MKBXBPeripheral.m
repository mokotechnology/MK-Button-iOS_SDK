//
//  MKBXBPeripheral.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/18.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBPeripheral.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "CBPeripheral+MKBXBAdd.h"

@interface MKBXBPeripheral ()

@property (nonatomic, strong)CBPeripheral *peripheral;

@end

@implementation MKBXBPeripheral

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral {
    if (self = [super init]) {
        self.peripheral = peripheral;
    }
    return self;
}

- (void)discoverServices {
    NSArray *services = @[[CBUUID UUIDWithString:@"FEE0"],  //custom配置服务
                          [CBUUID UUIDWithString:@"180A"]]; //设备信息服务
    [self.peripheral discoverServices:services];
}

- (void)discoverCharacteristics {
    for (CBService *service in self.peripheral.services) {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FEE0"]]) {
            NSArray *list = @[[CBUUID UUIDWithString:@"FEE1"],
                              [CBUUID UUIDWithString:@"FEE2"],
                              [CBUUID UUIDWithString:@"FEE3"],
                              [CBUUID UUIDWithString:@"FEE4"]];
            [self.peripheral discoverCharacteristics:list forService:service];
        }else if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
            NSArray *characteristics = @[[CBUUID UUIDWithString:@"2A24"],
                                         [CBUUID UUIDWithString:@"2A25"],
                                         [CBUUID UUIDWithString:@"2A26"],
                                         [CBUUID UUIDWithString:@"2A27"],
                                         [CBUUID UUIDWithString:@"2A28"],
                                         [CBUUID UUIDWithString:@"2A29"]];
            [self.peripheral discoverCharacteristics:characteristics forService:service];
        }
    }
}

- (void)updateCharacterWithService:(CBService *)service {
    [self.peripheral bxb_updateCharacterWithService:service];
}

- (void)updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    [self.peripheral bxb_updateCurrentNotifySuccess:characteristic];
}

- (BOOL)connectSuccess {
    return [self.peripheral bxb_connectSuccess];
}

- (void)setNil {
    [self.peripheral bxb_setNil];
}

@end
