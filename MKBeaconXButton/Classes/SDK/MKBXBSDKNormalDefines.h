
#pragma mark - *****************枚举*********************
typedef NS_ENUM(NSInteger, MKBXBChannelAlarmType) {
    MKBXBChannelAlarmType_single,
    MKBXBChannelAlarmType_double,
    MKBXBChannelAlarmType_long,
    MKBXBChannelAlarmType_abnormalInactivity,
};

typedef NS_ENUM(NSInteger, mk_bxb_txPower) {
    mk_bxb_txPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_bxb_txPowerNeg20dBm,   //-20dBm
    mk_bxb_txPowerNeg16dBm,   //-16dBm
    mk_bxb_txPowerNeg12dBm,   //-12dBm
    mk_bxb_txPowerNeg8dBm,    //-8dBm
    mk_bxb_txPowerNeg4dBm,    //-4dBm
    mk_bxb_txPower0dBm,       //0dBm
    mk_bxb_txPower3dBm,       //3dBm
    mk_bxb_txPower4dBm,       //4dBm
};

typedef NS_ENUM(NSInteger, mk_bxb_reminderType) {
    mk_bxb_reminderType_silent,
    mk_bxb_reminderType_led,
    mk_bxb_reminderType_vibration,
    mk_bxb_reminderType_buzzer,
    mk_bxb_reminderType_ledAndVibration,
    mk_bxb_reminderType_ledAndBuzzer,
};

typedef NS_ENUM(NSInteger, mk_bxb_threeAxisDataRate) {
    mk_bxb_threeAxisDataRate1hz,           //1hz
    mk_bxb_threeAxisDataRate10hz,          //10hz
    mk_bxb_threeAxisDataRate25hz,          //25hz
    mk_bxb_threeAxisDataRate50hz,          //50hz
    mk_bxb_threeAxisDataRate100hz          //100hz
};

typedef NS_ENUM(NSInteger, mk_bxb_threeAxisDataAG) {
    mk_bxb_threeAxisDataAG0,               //±2g
    mk_bxb_threeAxisDataAG1,               //±4g
    mk_bxb_threeAxisDataAG2,               //±8g
    mk_bxb_threeAxisDataAG3                //±16g
};

#pragma mark - *****************Protocol*********************
@protocol MKBXBTriggerChannelAdvParamsProtocol <NSObject>

@property (nonatomic, assign)MKBXBChannelAlarmType alarmType;

/// Whether to enable advertising.
@property (nonatomic, assign)BOOL isOn;

/// Ranging data.(-100dBm~0dBm)
@property (nonatomic, assign)NSInteger rssi;

/// advertising interval.(1~500,unit:20ms)
@property (nonatomic, copy)NSString *advInterval;

@property (nonatomic, assign)mk_bxb_txPower txPower;

@end



@protocol MKBXBChannelTriggerParamsProtocol <NSObject>

@property (nonatomic, assign)MKBXBChannelAlarmType alarmType;

/// Whether to enable trigger function.
@property (nonatomic, assign)BOOL alarm;

/// Ranging data.(-100dBm~0dBm)
@property (nonatomic, assign)NSInteger rssi;

/// advertising interval.(1~500,unit:20ms)
@property (nonatomic, copy)NSString *advInterval;

/// broadcast time after trigger.1s~65535s.
@property (nonatomic, copy)NSString *advertisingTime;

@property (nonatomic, assign)mk_bxb_txPower txPower;

@end

#pragma mark - **************************************

