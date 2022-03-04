
typedef NS_ENUM(NSInteger, mk_bxb_taskOperationID) {
    mk_bxb_defaultTaskOperationID,
    
    mk_bxb_taskReadDeviceModelOperation,        //读取产品型号
    mk_bxb_taskReadProductionDateOperation,     //读取生产日期
    mk_bxb_taskReadFirmwareOperation,           //读取固件版本
    mk_bxb_taskReadHardwareOperation,           //读取硬件类型
    mk_bxb_taskReadSoftwareOperation,           //读取软件版本
    mk_bxb_taskReadManufacturerOperation,       //读取厂商信息
    
#pragma mark - custom read
    mk_bxb_taskReadMacAddressOperation,                 //读取mac地址
    mk_bxb_taskReadThreeAxisDataParamsOperation,        //读取3轴传感器数据
    mk_bxb_taskReadEffectiveClickIntervalOperation,     //读取连续按键有效时长
    mk_bxb_taskReadTriggerChannelStateOperation,        //读取各通道广播使能情况
    mk_bxb_taskReadTriggerChannelAdvParamsOperation,    //读取活跃通道广播参数
    mk_bxb_taskReadChannelTriggerParamsOperation,       //读取活跃通道触发广播参数
    mk_bxb_taskReadStayAdvertisingBeforeTriggeredOperation,     //读取活跃通道触发前广播开关
    mk_bxb_taskReadAlarmNotificationTypeOperation,      //读取触发提醒模式
    mk_bxb_taskReadDismissAlarmLEDNotiParamsOperation,  //读取LED消警参数
    mk_bxb_taskReadDismissAlarmVibrationNotiParamsOperation,    //读取马达消警参数
    mk_bxb_taskReadDismissAlarmBuzzerNotiParamsOperation,       //读取蜂鸣器消警参数
    mk_bxb_taskReadDismissAlarmNotificationTypeOperation,   //读取消警提醒模式
    mk_bxb_taskReadBatteryVoltageOperation,             //读取电池电压
    mk_bxb_taskReadDeviceTimeOperation,                 //读取设备时间
    mk_bxb_taskReadDeviceIDOperation,                   //读取deviceID
    mk_bxb_taskReadDeviceNameOperation,                 //读取设备名称
    mk_bxb_taskReadSinglePressEventCountOperation,      //读取单击触发次数
    mk_bxb_taskReadDoublePressEventCountOperation,      //读取双击触发次数
    mk_bxb_taskReadLongPressEventCountOperation,        //读取长按触发次数
    
#pragma mark - custom write
    mk_bxb_taskConfigThreeAxisDataParamsOperation,      //设置3轴传感器参数
    mk_bxb_taskConfigEffectiveClickIntervalOperation,   //设置连续按键有效时长
    mk_bxb_taskConfigActiveChannelOperation,            //设置活跃通道
    mk_bxb_taskConfigTriggerChannelAdvParamsOperation,  //设置活跃通道广播参数
    mk_bxb_taskConfigChannelTriggerParamsOperation,     //设置活跃通道触发广播参数
    mk_bxb_taskConfigStayAdvertisingBeforeTriggeredOperation,       //设置活跃通道触发前广播开关
    mk_bxb_taskConfigAlarmNotificationTypeOperation,    //设置触发提醒模式
    mk_bxb_taskConfigDismissAlarmOperation,             //设置远程消警
    mk_bxb_taskClearSinglePressEventDataOperation,      //删除单击通道触发记录
    mk_bxb_taskClearDoublePressEventDataOperation,      //删除双击通道触发记录
    mk_bxb_taskClearLongPressEventDataOperation,        //删除长按通道触发记录
    mk_bxb_taskConfigDismissAlarmLEDNotiParamsOperation,    //设置远程LED消警参数
    mk_bxb_taskConfigDismissAlarmVibrationNotiParamsOperation,  //设置远程马达消警参数
    mk_bxb_taskConfigDismissAlarmBuzzerNotiParamsOperation,     //设置远程蜂鸣器消警参数
    mk_bxb_taskConfigDismissAlarmNotificationTypeOperation,     //设置消警提醒模式
    mk_bxb_taskConfigDeviceTimeOperation,               //设置设备时间
    mk_bxb_taskConfigDeviceIDOperation,                 //设置deviceID
    mk_bxb_taskConfigDeviceNameOperation,               //设置设备名称
    mk_bxb_connectPasswordOperation,                    //连接密码
};
