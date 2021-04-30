@RestResource(urlMapping='/Tourist/*')
global with sharing class TouristRestService {
    private static final String REQUEST_PARAMS_FUZZYNAME = 'fuzzyname';
    private static final String REQUEST_PARAMS_AGE = 'age';
    
    @HttpGet
    global static void getTourists() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        Map<String, String> paramsMap = request.params;
        String touristName = paramsMap.get(REQUEST_PARAMS_FUZZYNAME);
        String touristAge = paramsMap.get(REQUEST_PARAMS_AGE);
        if(String.isEmpty(touristName)) {
            response.responseBody = Blob.valueOf(Constants.RESPONSE_BODY_TOURIST_NAME_EMPTY);
            response.statusCode = Constants.RESPONSE_STATUS_CODE_404;
            return;
        } 
        if(String.isEmpty(touristAge)) {
            List<Tourist__c> resultWithoutAge = TouristManager.getByNameSOSL(touristName);
            response.responseBody = Blob.valueOf(JSON.serializePretty(resultWithoutAge));
            response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
            return;
        } else if(!touristAge.isNumeric()) {
            response.responseBody = Blob.valueOf(Constants.RESPONSE_BODY_TOURIST_AGE_NOT_NUMBER);
            response.statusCode = Constants.RESPONSE_STATUS_CODE_404;
            return;
        } 
        List<Tourist__c> result = TouristManager.getSameNameAge(touristName, touristAge);
        response.responseBody = Blob.valueOf(JSON.serializePretty(result));
        response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
    }
    
    @HttpPost
    global static void createTourist(String name, String lastName, String birthdate, String email) {
        RestResponse response = RestContext.response;
        Tourist__c newTourist = new Tourist__c(
            Name = name,
            LastName__c = lastName,
            Birthdate__c = Date.valueOf(birthdate),
            Email__c = email
        );
        List<Tourist__c> same = TouristManager.getTheSame(new Set<String> {lastName}, new Set<String> {email});
        if(!same.isEmpty()) {
            response.responseBody = Blob.valueOf(Constants.DUPLICATE);
            response.statusCode = Constants.RESPONSE_STATUS_CODE_409;
        } 
        insert newTourist;
    }
}