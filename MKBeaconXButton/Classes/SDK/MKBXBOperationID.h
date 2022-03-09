
typedef NS_ENUM(NSInteger, mk_bxb_taskOperationID) {
    mk_bxb_defaultTaskOperationID,
    
    mk_bxb_taskReadDeviceModelOperation,        //读取产品型号
    mk_bxb_taskReadProductionDateOperation,     //读取生产日期
    mk_bxb_taskReadFirmwareOperation,           //读取固件版本
    mk_bxb_taskReadHardwareOperation,           //读取硬件类型
    mk_bxb_taskReadSoftwareOperation,           //读取软件版本
    mk_bxb_taskReadManufacturerOperation,       //读取厂商信息
    
#pragma mark - 密码
    mk_bxb_taskReadNeedPasswordOperation,               //读取设备是否需要连接密码
    mk_bxb_connectPasswordOperation,                    //连接密码
    
#pragma mark - custom read
    mk_bxb_taskReadMacAddressOperation,                 //读取mac地址
    mk_bxb_taskReadThreeAxisDataParamsOperation,        //读取3轴传感器数据
    mk_bxb_taskReadConnectableOperation,                //读取设备的可连接状态
    mk_bxb_taskReadPasswordVerificationOperation,       //读取设备密码验证状态
    mk_bxb_taskReadConnectPasswordOperation,            //读取设备的连接密码
    mk_bxb_taskReadEffectiveClickIntervalOperation,     //读取连续按键有效时长
    mk_bxb_taskReadTurnOffDeviceByButtonStatusOperation,    //读取按键开关机状态
    mk_bxb_taskReadScanResponsePacketOperation,         //读取回应包开关
    mk_bxb_taskReadResetDeviceByButtonStatusOperation,  //读取按键是否可以恢复出厂设置
    mk_bxb_taskReadTriggerChannelStateOperation,        //读取各通道广播使能情况
    mk_bxb_taskReadTriggerChannelAdvParamsOperation,    //读取活跃通道广播参数
    mk_bxb_taskReadChannelTriggerParamsOperation,       //读取活跃通道触发广播参数
    mk_bxb_taskReadStayAdvertisingBeforeTriggeredOperation,     //读取活跃通道触发前广播开关
    mk_bxb_taskReadAlarmNotificationTypeOperation,      //读取触发提醒模式
    mk_bxb_taskReadAbnormalInactivityTimeOperation,     //读取异常活动报警静止时间
    mk_bxb_taskReadPowerSavingModeOperation,            //读取省电模式开关
    mk_bxb_taskReadStaticTriggerTimeOperation,          //读取省电模式静止时间
    mk_bxb_taskReadAlarmLEDNotiParamsOperation,         //读取通道触发LED提醒参数
    mk_bxb_taskReadAlarmVibrationNotiParamsOperation,   //读取通道触发马达提醒参数
    mk_bxb_taskReadAlarmBuzzerNotiParamsOperation,      //读取通道触发蜂鸣器提醒参数
    mk_bxb_taskReadRemoteReminderLEDNotiParamsOperation,    //读取远程LED提醒参数
    mk_bxb_taskReadRemoteReminderVibrationNotiParamsOperation,  //读取远程马达提醒参数
    mk_bxb_taskReadRemoteReminderBuzzerNotiParamsOperation,     //读取远程蜂鸣器提醒参数
    mk_bxb_taskReadDismissAlarmByButtonOperation,               //读取按键消警使能
    mk_bxb_taskReadDismissAlarmLEDNotiParamsOperation,  //读取LED消警参数
    mk_bxb_taskReadDismissAlarmVibrationNotiParamsOperation,    //读取马达消警参数
    mk_bxb_taskReadDismissAlarmBuzzerNotiParamsOperation,       //读取蜂鸣器消警参数
    mk_bxb_taskReadDismissAlarmNotificationTypeOperation,   //读取消警提醒模式
    mk_bxb_taskReadBatteryVoltageOperation,             //读取电池电压
    mk_bxb_taskReadDeviceTimeOperation,                 //读取设备时间
    mk_bxb_taskReadSensorStatusOperation,               //读取传感器状态
    mk_bxb_taskReadDeviceIDOperation,                   //读取deviceID
    mk_bxb_taskReadDeviceNameOperation,                 //读取设备名称
    mk_bxb_taskReadSinglePressEventCountOperation,      //读取单击触发次数
    mk_bxb_taskReadDoublePressEventCountOperation,      //读取双击触发次数
    mk_bxb_taskReadLongPressEventCountOperation,        //读取长按触发次数
    mk_bxb_taskReadDeviceTypeOperation,                 //读取设备类型

#pragma mark - custom write
    mk_bxb_taskConfigThreeAxisDataParamsOperation,      //设置3轴传感器参数
    mk_bxb_taskConfigConnectableOperation,              //设置设备的可连接性
    mk_bxb_taskConfigPasswordVerificationOperation,     //设置设备密码验证
    mk_bxb_taskConfigConnectPasswordOperation,          //设置连接密码
    mk_bxb_taskConfigEffectiveClickIntervalOperation,   //设置连续按键有效时长
    mk_bxb_taskConfigPowerOffOperation,                 //关机
    mk_bxb_taskConfigFactoryResetOperation,             //恢复出厂设置
    mk_bxb_taskConfigTurnOffDeviceByButtonStatusOperation,  //设置按键开关机状态
    mk_bxb_taskConfigScanResponsePacketOperation,       //设置回应包开关
    mk_bxb_taskConfigResetDeviceByButtonStatusOperation,    //设置按键是否可以恢复出厂设置
    mk_bxb_taskConfigTriggerChannelAdvParamsOperation,  //设置活跃通道广播参数
    mk_bxb_taskConfigChannelTriggerParamsOperation,     //设置活跃通道触发广播参数
    mk_bxb_taskConfigStayAdvertisingBeforeTriggeredOperation,       //设置活跃通道触发前广播开关
    mk_bxb_taskConfigAlarmNotificationTypeOperation,    //设置触发提醒模式
    mk_bxb_taskConfigAbnormalInactivityTimeOperation,   //设置异常活动报警静止时间
    mk_bxb_taskConfigPowerSavingModeOperation,          //设置省电模式开关
    mk_bxb_taskConfigStaticTriggerTimeOperation,        //设置省电模式静止时间
    mk_bxb_taskConfigAlarmLEDNotiParamsOperation,       //设置通道触发LED提醒参数
    mk_bxb_taskConfigAlarmVibrationNotiParamsOperation, //设置通道触发马达提醒参数
    mk_bxb_taskConfigAlarmBuzzerNotiParamsOperation,    //设置通道触发蜂鸣器提醒参数
    mk_bxb_taskConfigRemoteReminderLEDNotiParamsOperation,  //设置远程LED提醒参数
    mk_bxb_taskConfigRemoteReminderVibrationNotiParamsOperation,    //设置远程马达提醒参数
    mk_bxb_taskConfigRemoteReminderBuzzerNotiParamsOperation,       //设置远程蜂鸣器提醒参数
    mk_bxb_taskConfigDismissAlarmOperation,             //设置远程消警
    mk_bxb_taskConfigDismissAlarmByButtonOperation,     //设置按键消警使能
    mk_bxb_taskConfigDismissAlarmLEDNotiParamsOperation,    //设置远程LED消警参数
    mk_bxb_taskConfigDismissAlarmVibrationNotiParamsOperation,  //设置远程马达消警参数
    mk_bxb_taskConfigDismissAlarmBuzzerNotiParamsOperation,     //设置远程蜂鸣器消警参数
    mk_bxb_taskConfigDismissAlarmNotificationTypeOperation,     //设置消警提醒模式
    mk_bxb_taskClearSinglePressEventDataOperation,      //删除单击通道触发记录
    mk_bxb_taskClearDoublePressEventDataOperation,      //删除双击通道触发记录
    mk_bxb_taskClearLongPressEventDataOperation,        //删除长按通道触发记录
    mk_bxb_taskConfigDeviceTimeOperation,               //设置设备时间
    mk_bxb_taskConfigDeviceIDOperation,                 //设置deviceID
    mk_bxb_taskConfigDeviceNameOperation,               //设置设备名称
};
