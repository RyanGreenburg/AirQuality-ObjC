# AirQuality-ObjC

## Project Summary
Students will build an app that allows them to filter countries, states in those countries, and cities in those states and get the current air quality of that city. Network calls will be made using JSONSerialization in Objective C.

## Setup
If you havent already `fork` and `clone` [this]() repository and work from the `starter` branch.

AirVisual provides weather and polution data for given locations around the globe. The documentation can be found [here](https://www.airvisual.com). 

- Create an account and confirm your email address to recieve your API key.
- The documentation has a downloadable Postman link in the upper right hand corner that autofills all available calls in Postman.
- Plug in the base url (https://api.airvisual.com/) and your API key into the Postman requests to look at the data returned.

## Step One
Create the needed models for the `get specified city data` request that we will be using to pull information on specific cities.

### Instructions
#### CityAirQuality Model Declarations
- Create the `CityAirQuality.h/.m` files
- Review the endpoint in the docuementation and see what JSON (information) you will get back.
  - Using this information, add the properties to the `CityAirQuality.h` file.
    <details>
    <summary>Properties</summary>
     <li> @property (nonatomic, copy, readonly) NSString * city;
     <li> @property (nonatomic, copy, readonly) NSString * state;
     <li> @property (nonatomic, copy, readonly) NSString * country;
     </details>
  - You'll notice that the end point has two more levels of dicitonaries: `weather` and `pollution`. We will create two more models to handle these endpoints. For now, add them as properties to the `CityAirQuality.h` file.
    <details>
    <summary>Properties</summary>
    <li> @property (nonatomic, copy, readonly) DVMWeather * weather;
    <li> @property (nonatomic, copy, readonly) DVMPollution * pollution;
    </details>
    
- Add the needed initializer declarations for this Model object
  
    <details>
    <summary>Designated Initializer</summary>
    -(instancetype)initWithCity:(NSString *)city
                      state:(NSString *)state
                    country:(NSString *)country
                    weather:(DVMWeather *)weather
                  pollution:(DVMPollution *)pollution;
    </details>
    
 - In an interface with category, add the dictionary initializer
    <details>
    <summary>Designated Initializer</summary>
    -(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;
      </details>
  
#### Weather Model Declaration
- Create the `Weather.h/.m` files
- Review the endpoint for the `weather` level of the JSON object and add the appropriate properties to the `.h` file
    <details>
    <summary>Properties</summary>
     <li> @property (nonatomic, readonly) NSInteger temperature;
     <li> @property (nonatomic, readonly) NSInteger humidity;
     <li> @property (nonatomic, readonly) NSInteger windSpeed;
     </details>
     
- Add the needed initializer declarations for this Model object
  
    <details>
    <summary>Designated Initializer</summary>
    -(instancetype)initWithWeatherInfo:(NSInteger)temperature
                          humidity:(NSInteger)humidity
                         windSpeed:(NSInteger)windSpeed;
    </details>
    
- In an interface with category, add the dictionary initializer
    <details>
    <summary>Designated Initializer</summary>
    -(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;
    </details>
  
#### Pollution Model Declaration
- Create the `Pollution.h/.m` files
- Review the endpoint for the `pollution` level of the JSON object and add the appropriate properties to the `.h` file
  - The only thing we really care about here is the AQI, add `@property (nonatomic, readonly) NSInteger airQualityIndex;` as the only property
  
- Add the needed initializer declarations for this Model object
    <details>
    <summary>Designated Initializer</summary>
    -(instancetype)initWithInt:(NSInteger) aqi;
    </details>
    
- In an interface with category, add the dictionary initializer
    <details>
    <summary>Designated Initializer</summary>
    -(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;
    </details>
  
#### Pollution Model Implementation
- Implement the declared initializers in the `Pollution.m` file.
  - The designated initializer will live in the implementation body.
  - The `initWithDictionary` initializer will live in an implementation with category extension.

#### Weather Model Implementation

#### CityAirQuality Model Implementation

- Create the Weather model
  - add the properties and the initializers to .h file
    - initWithTemperature:temperature,humidity,windspeed
    - initWithDicitonary:dictionary
  - implement the initalizers in the .m file
- Create the CityAirQuality model
  - add the properties and the initializers to .h file
    - initWithCity:city,state,country,weather,pollution
    - initWithDictionary:dictionary
  - implement the initalizers in the .m file
  
### ModelControllers
- Create the CityAirQualityController
  - add fetchSupportedCountries, fetchSupportedStatesInCountry, fetchSupportedCitiesInState, and fetchDataForCity to .h file
  - implement funcitons in .m file
  
### ViewControllers
- Create a new CocoaTouch Class file subclassed from a UIViewController, change the language to Swift, and add the bridging header
- import DVMCityAirQualityController.h to bridging header
- CountriesListVC
- StatesListVC
- CitiesListVC
- CityDetailsVC
