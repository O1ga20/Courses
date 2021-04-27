public with sharing class WeatherForecastService {
    public class WeatherForecastException extends Exception {}
    
    public static Map<Date, Double> getForecasts(Double latitude, Double longitude) {
        HttpRequest req = new HttpRequest();
        req.setMethod(Constants.METHOD_HTTP_GET);
        req.setEndpoint(
            Constants.URL_RAPIDAPI_WEATHERBIT + '?lat=' + latitude +
            '&lon=' + longitude
        );
        req.setHeader('x-rapidapi-key', 'dbba4ce498msh0a2aa20f5b276eep1affd2jsn972508114931');
        req.setHeader('x-rapidapi-host', 'weatherbit-v1-mashape.p.rapidapi.com');
        Map<Date, Double> temperatureByDate = new Map<Date, Double> ();
        
        try {
            Http http = new Http();
            HTTPResponse res = http.send(req);
            if(res.getStatusCode() == 200) {
                Map<String, Object> results =(Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                List<Object> data = (List<Object>)results.get('data');
                
                for (Integer i = 0; i < data.size(); i++){
                    Map<String, Object> weatherByDay = (Map<String, Object>)data[i];
                    Date validDate = Date.valueOf(String.valueOf(weatherByDay.get('valid_date')));
                    Double temp = Double.valueOf(String.valueOf(weatherByDay.get('temp')));
                    temperatureByDate.put(validDate, temp);
                }
            }
        } catch (Exception ex) {
            throw new WeatherForecastException(Constants.EXECEPTION_TEXT + ex.getCause());
        } 
        return temperatureByDate;
    }
}