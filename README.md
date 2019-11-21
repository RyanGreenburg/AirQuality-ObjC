# AirQuality-ObjC

## Review the Documentation
AirVisual provides weather and polution data for given locations around the globe. The documentation can be found [here](https://www.airvisual.com). 

- Create an account and confirm your email address to recieve your API key.
- The documentation has a downloadable Postman link in the upper right hand corner that autofills all available calls in Postman.
- Plug in the base url (https://api.airvisual.com/) and your API key into the Postman requests to look at the data returned.

## Starting the Project
We will be using the 'Get specified city data' request to pull information on specific cities.

### Models
- Create the Pollution model
  - add the properties and the initializers to .h file 
    - initWithString:airQualityIndex
    - initWithDictionary:dictionary
  - implement the initalizers in the .m file
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
