//
//  DVMPollution.h
//  AirQuality ObjC
//
//  Created by RYAN GREENBURG on 11/20/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMPollution : NSObject

@property (nonatomic, readonly) NSInteger airQualityIndex;

-(instancetype)initWithInt:(NSInteger) aqi;

@end

@interface DVMPollution (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
