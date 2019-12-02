//
//  DVMCityAirQuality.m
//  AirQuality ObjC
//
//  Created by RYAN GREENBURG on 11/20/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

#import "DVMCityAirQuality.h"
#import "DVMWeather.h"
#import "DVMPollution.h"

@implementation DVMCityAirQuality
/**
 Initializes and returns a DVMCityAirQuality object with the given properties
 */
- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(DVMWeather *)weather pollution:(DVMPollution *)pollution
{
    // Initialize superclass
    self = [super init];
    // If the superclass is not nil
    if (self) {
        // Assing the properties of the class with the values passed in from the initializer parameters
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    // Return the initialized object
    return self;
}

@end

@implementation DVMCityAirQuality (JSONConvertable)
/**
 Initializes and returns a DVMCityAirQuality object by accessing values in the passed in dictonary
 */
- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    // Init the values with the needed types, and assign them by subscripting into the dictionary at the necessary keys to access those values
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[@"state"];
    NSString *country = dictionary[@"country"];
    NSDictionary *currentInfo = dictionary[@"current"];
    // On the below lines, we are accessing the initWithDictionary initializers for the DVMWeather and DVMPollution objects to init and assign the needed values for the designated initializer. We pass in the dictionaries found at the keys "weather" and "pollution"
    DVMWeather *weather = [[DVMWeather alloc] initWithDictionary:currentInfo[@"weather"]];
    DVMPollution *pollution = [[DVMPollution alloc] initWithDictionary:currentInfo[@"pollution"]];
    // Return an instance of the class by calling the designated initializer and passing in the values pulled out from the dictionary
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
