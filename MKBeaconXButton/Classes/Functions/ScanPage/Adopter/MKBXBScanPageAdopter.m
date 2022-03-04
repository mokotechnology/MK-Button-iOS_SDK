//
//  MKBXBScanPageAdopter.m
//  MKBeaconXButton_Example
//
//  Created by aa on 2022/2/24.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKBXBScanPageAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import <objc/runtime.h>

#import "MKMacroDefines.h"

#import "MKBXBScanDeviceDataCell.h"
#import "MKBXBScanAdvCell.h"
#import "MKBXBScanDeviceInfoCell.h"

#import "MKBXBScanDataModel.h"

#import "MKBXBBaseAdvModel.h"

#pragma mark - *********************此处分类为了对数据列表里面的设备信息帧数据和设备信息帧数据里面的广播帧数据进行替换和排序使用**********************

static const char *indexKey = "indexKey";
static const char *frameTypeKey = "frameTypeKey";

@interface NSObject (MKBXScanAdd)

/// 用来标示数据model在设备列表或者设备信息广播帧数组里的index
@property (nonatomic, assign)NSInteger index;

/*
 用来对同一个设备的广播帧进行排序，顺序为
 MKBXBAdvAlarmType_single,(MKBXBAdvFrameType)
 MKBXBAdvAlarmType_double,(MKBXBAdvFrameType)
 MKBXBAdvAlarmType_long,(MKBXBAdvFrameType)
 MKBXBAdvAlarmType_abnormalInactivity,(MKBXBAdvFrameType)
 MKBXBRespondFrameType,
 */
@property (nonatomic, assign)NSInteger frameIndex;

@end

@implementation NSObject (MKBXScanAdd)

- (void)setIndex:(NSInteger)index {
    objc_setAssociatedObject(self, &indexKey, @(index), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)index {
    return [objc_getAssociatedObject(self, &indexKey) integerValue];
}

- (void)setFrameIndex:(NSInteger)frameIndex {
    objc_setAssociatedObject(self, &frameTypeKey, @(frameIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)frameIndex {
    return [objc_getAssociatedObject(self, &frameTypeKey) integerValue];
}

@end




#pragma mark - *****************************MKBXBScanPageAdopter**********************


@implementation MKBXBScanPageAdopter

+ (NSObject *)parseAdvDatas:(MKBXBBaseAdvModel *)advModel {
    if ([advModel isKindOfClass:MKBXBAdvDataModel.class]) {
        //触发数据包
        MKBXBAdvDataModel *tempModel = (MKBXBAdvDataModel *)advModel;
        MKBXBScanAdvCellModel *cellModel = [[MKBXBScanAdvCellModel alloc] init];
        cellModel.alarmMode = tempModel.alarmType;
        cellModel.triggerStatus = tempModel.trigger;
        cellModel.triggerCount = tempModel.triggerCount;
        cellModel.deviceID = tempModel.deviceID;
        
        return cellModel;
    }
    if ([advModel isKindOfClass:MKBXBAdvRespondDataModel.class]) {
        //芯片信息报
        MKBXBAdvRespondDataModel *tempModel = (MKBXBAdvRespondDataModel *)advModel;
        MKBXBScanDeviceInfoCellModel *cellModel = [[MKBXBScanDeviceInfoCellModel alloc] init];
        cellModel.rangingData = [tempModel.rangingData stringByAppendingString:@"dBm"];
        cellModel.acceleration = [NSString stringWithFormat:@"X: %@mg Y: %@mg Z: %@mg",SafeStr(tempModel.xData),SafeStr(tempModel.yData),SafeStr(tempModel.zData)];
        
        return cellModel;
    }
    return nil;
}

+ (MKBXBScanDataModel *)parseBaseAdvDataToInfoModel:(MKBXBBaseAdvModel *)advData {
    if (!advData || ![advData isKindOfClass:MKBXBBaseAdvModel.class]) {
        return [[MKBXBScanDataModel alloc] init];
    }
    MKBXBScanDataModel *deviceModel = [[MKBXBScanDataModel alloc] init];
    deviceModel.identifier = advData.peripheral.identifier.UUIDString;
    deviceModel.rssi = [NSString stringWithFormat:@"%ld",(long)[advData.rssi integerValue]];
    deviceModel.displayTime = @"N/A";
    deviceModel.lastScanDate = [[NSDate date] timeIntervalSince1970] * 1000;
    deviceModel.connectEnable = advData.connectEnable;
    deviceModel.peripheral = advData.peripheral;
    NSInteger frameType = 0;
    if ([advData isKindOfClass:MKBXBAdvRespondDataModel.class]) {
        //如果是回应包
        MKBXBAdvRespondDataModel *tempDataModel = (MKBXBAdvRespondDataModel *)advData;
        deviceModel.battery = tempDataModel.voltage;
        deviceModel.txPower = [NSString stringWithFormat:@"%ld",(long)[tempDataModel.txPower integerValue]];
        deviceModel.macAddress = SafeStr(tempDataModel.macAddress);
        frameType = 4;
    }else if ([advData isKindOfClass:MKBXBAdvDataModel.class]) {
        MKBXBAdvDataModel *tempDataModel = (MKBXBAdvDataModel *)advData;
        deviceModel.deviceName = SafeStr(tempDataModel.deviceName);
        frameType = tempDataModel.alarmType;
    }
    NSObject *obj = [self parseAdvDatas:advData];
    if (!obj) {
        return deviceModel;
    }
    obj.index = 0;
    obj.frameIndex = frameType;
    [deviceModel.advertiseList addObject:obj];
    
    return deviceModel;
}

+ (void)updateInfoCellModel:(MKBXBScanDataModel *)exsitModel advData:(MKBXBBaseAdvModel *)advData {
    exsitModel.connectEnable = advData.connectEnable;
    exsitModel.peripheral = advData.peripheral;
    exsitModel.rssi = [NSString stringWithFormat:@"%ld",(long)[advData.rssi integerValue]];
    if (exsitModel.lastScanDate > 0) {
        NSTimeInterval space = [[NSDate date] timeIntervalSince1970] * 1000 - exsitModel.lastScanDate;
        if (space > 10) {
            exsitModel.displayTime = [NSString stringWithFormat:@"%@%ld%@",@"<->",(long)space,@"ms"];
            exsitModel.lastScanDate = [[NSDate date] timeIntervalSince1970] * 1000;
        }
    }
    NSInteger frameType = 0;
    if ([advData isKindOfClass:MKBXBAdvRespondDataModel.class]) {
        //如果是回应包
        MKBXBAdvRespondDataModel *tempDataModel = (MKBXBAdvRespondDataModel *)advData;
        exsitModel.battery = tempDataModel.voltage;
        exsitModel.txPower = [NSString stringWithFormat:@"%ld",(long)[tempDataModel.txPower integerValue]];
        exsitModel.macAddress = SafeStr(tempDataModel.macAddress);
        frameType = 4;
    }else if ([advData isKindOfClass:MKBXBAdvDataModel.class]) {
        MKBXBAdvDataModel *tempDataModel = (MKBXBAdvDataModel *)advData;
        exsitModel.deviceName = SafeStr(tempDataModel.deviceName);
        frameType = tempDataModel.alarmType;
    }
    NSObject *tempModel = [self parseAdvDatas:advData];
    if (!tempModel) {
        return;
    }
    tempModel.frameIndex = frameType;
    for (NSObject *model in exsitModel.advertiseList) {
        if (tempModel.frameIndex == model.frameIndex) {
            //需要替换
            tempModel.index = model.index;
            [exsitModel.advertiseList replaceObjectAtIndex:model.index withObject:tempModel];
            return;
        }
    }
    //如果eddStone帧数组里面不包含该数据，直接添加
    [exsitModel.advertiseList addObject:tempModel];
    tempModel.index = exsitModel.advertiseList.count - 1;
    NSArray *tempArray = [NSArray arrayWithArray:exsitModel.advertiseList];
    NSArray *sortedArray = [tempArray sortedArrayUsingComparator:^NSComparisonResult(NSObject *p1, NSObject *p2){
        if (p1.frameIndex > p2.frameIndex) {
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
    }];
    [exsitModel.advertiseList removeAllObjects];
    for (NSInteger i = 0; i < sortedArray.count; i ++) {
        NSObject *tempModel = sortedArray[i];
        tempModel.index = i;
        [exsitModel.advertiseList addObject:tempModel];
    }
}

@end
