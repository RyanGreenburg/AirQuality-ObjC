//
//  DVMCityAirQualityController.h
//  AirQuality ObjC
//
//  Created by RYAN GREENBURG on 11/21/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DVMCityAirQuality;

NS_ASSUME_NONNULL_BEGIN

@interface DVMCityAirQualityController : NSObject

+(void)fetchSupportedCountries:(void (^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchSupportedStatesInCountry:(NSString *)country
                          completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchSupportedCitiesInState:(NSString *)state
                           country:(NSString *)country
                        completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchDataForCity:(NSString *)city
                  state:(NSString *)state
                country:(NSString *)country
             completion:(void (^) (DVMCityAirQuality *_Nullable))compleiton;

@end

NS_ASSUME_NONNULL_END
