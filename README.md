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
    
- Add the designated initializer declaration for this Model object
  
    <details>
    <summary>Designated Initializer</summary>
    -(instancetype)initWithCity:(NSString *)city
                      state:(NSString *)state
                    country:(NSString *)country
                    weather:(DVMWeather *)weather
                  pollution:(DVMPollution *)pollution;
    </details>
    
 - Add the convenience initializer in an extension called JSONConvertable
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
     
- Add the designated initializer declaration for this Model object
  
    <details>
    <summary>Designated Initializer</summary>
    -(instancetype)initWithWeatherInfo:(NSInteger)temperature
                          humidity:(NSInteger)humidity
                         windSpeed:(NSInteger)windSpeed;
    </details>
    
- Add the convenience initializer in an extension called JSONConvertable
    <details>
    <summary>Designated Initializer</summary>
    -(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;
    </details>
  
#### Pollution Model Declaration
- Create the `Pollution.h/.m` files
- Review the endpoint for the `pollution` level of the JSON object and add the appropriate properties to the `.h` file
  - The only thing we really care about here is the AQI, add `@property (nonatomic, readonly) NSInteger airQualityIndex;` as the only property
  
- Add the designated initializer declaration for this Model object
    <details>
    <summary>Designated Initializer</summary>
    -(instancetype)initWithInt:(NSInteger) aqi;
    </details>
    
- Add the convenience initializer in an extension called JSONConvertable
    <details>
    <summary>Designated Initializer</summary>
    -(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;
    </details>
  
#### Pollution Model Implementation
- Implement the declared initializers in the `Pollution.m` file.
  - The designated initializer will live in the implementation body
  - The JSONConvertable convenience initializer will live in an extension

#### Weather Model Implementation
- Implement the declared initializers in in the `Weather.m` file.
  - The designated initializer will live in the implementation body
  - The JSONConvertable convenience initializer will live in an extension

#### CityAirQuality Model Implementation
- Implement the declared initializers in in the `CityAirQuality.m` file.
  - The designated initializer will live in the implementation body
  - The JSONConvertable convenience initializer will live in an extension
  
### ModelControllers
Create the `CityAirQualityController.h/.m` files

#### CityAirQuality.h
On this file we will declare the various network call methods we will be using. 

- Add `fetchSupportedCountries`, `fetchSupportedStatesInCountry`, `fetchSupportedCitiesInState`, and `fetchDataForCity` to the .h file
  - `fetchSupportedCountries` will take in no parameters and complete with an array of strings
  - `fetchSupportedStatesInCountry` will take in a string parameter for the country and complete with an array of strings
  - `fetchSupportedCitiesInState` will take in a string parameter for the country, a string parameter for the state, and complete with an array of strings
  - `fetchDataForCity` will take in a string parameter for the country, a string parameter for the state, a string parameter for the city, and complete with a CityAirQuality object
    
#### CityAirQuality.m
We have four network call methods to implement. To make our lives easier when implementing them, we will use string constants to store the frequently used string values for the API calls. 

- Above the class declaration, add string constants for the following:
  - baseUrlString with value "https://api.airvisual.com/"
  - versionComponent with value "v2"
  - countryComponent with value "countries"
  - stateComponent with value "states"
  - cityComponent with value "cities"
  - cityDetailsComponent with value "city"
  - apiKey with your key as the value
  
Implement the function bodies inside the class declaration.

- `fetchSupportedCountries` method body
  - Start with defining a url from the baseUrlString
  - Append the versionComponent string as a pathComponent
  - Append the countryComponent string as a pathComponent
  - Add your apiKey as a queryItem with the key of "key"
  - With your finalURL constructed, perform a shared URLSession dataTaskWithURL and completion
    - handle your error
    - print out your response
    - unwrap your data
      - Create a topLevel dicitonary from serializing the JSON from the unwrapped data
      - Step into your data dictioary from the topLevel dictionary
      - Loop through the data dictionary and create an array of strings from the names of the countries found
      - Complete with the array of strings
- `fetchSupportedStatesInCountry` method body
  - Follow the same flow as the `fetchSupportedCountries` method
  - Change the countryComponent for the stateComponent
  - Add a queryItem for the country, use the string value for the country parameter as the value and "country" as the key
  - Perform your dataTask with the finalURL and complete with the array of strings found for the states
- `fetchSupportedCitiesInState` method body
  - Follow the same flow as the `fetchSupportedCitiesInState` method
  - Change the stateComponent for the cityComponent
  - Add a queryItem for the country, use the string value for the country parameter as the value and "country" as the key
  - Add a queryItem for the state, use the string value for the state parameter as the value and "state" as the key
  - Perform your dataTask with the finalURL and complete with the array of strings found for the cities
- `fetchDataForCity` method body
  - Follow the same flow as the `fetchSupportedCitiesInState` method
  - Change the cityComponent for the cityDetailsComponent
  - Add a queryItem for the country, use the string value for the country parameter as the value and "country" as the key
  - Add a queryItem for the state, use the string value for the state parameter as the value and "state" as the key
  - Add a queryItem for the city, user the string value for the city parameter as the value and "city" as the key
  - Perform your dataTask with the finalURL and complete with the CityAirQuality object found
  
  
### ViewControllers
- Create a new CocoaTouch Class file subclassed from a UIViewController, change the language to Swift, and add the bridging header
- import DVMCityAirQualityController.h to bridging header
- CountriesListVC
- StatesListVC
- CitiesListVC
- CityDetailsVC
