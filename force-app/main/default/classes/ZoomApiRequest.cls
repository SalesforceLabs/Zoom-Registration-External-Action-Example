global class ZoomApiRequest {
  static final Integer WEBINAR_REGISTRANT_CREATED = 201;
  static final Integer INVALID_PARAM = 300;
  static final Integer BAD_REQUEST = 400;
  static final Integer WEBINAR_NOT_FOUND = 404;
  static final Integer DAILY_RATE_LIMIT_EXCEEDED = 429;

  @InvocableMethod(
    label='Add Zoom Webinar Registrant'
    description='Adds a registrant to a Zoom Webinar'
  )
  global static void addWebinarRegistrant(List<ZoomActionRequest> zoomReq) {
    //Build and serialize payload to send to Zoom from incoming request
    Map<String, String> payload = new Map<String, String>{
      'first_name' => zoomReq[0].firstName,
      'email' => zoomReq[0].email,
      'last_name' => zoomReq[0].lastName
    };
    String jsonBody = JSON.serialize(payload);
    //Create request using Named Credential for endpoint
    HttpRequest req = new HttpRequest();
    req.setEndpoint(
      'callout:MktgExtAction__Zoom_Named_Cred/webinars/' +
        zoomReq[0].webinarId +
        '/registrants'
    );
    req.setMethod('POST');
    req.setHeader('Accept', 'application/json');
    req.setHeader('Content-Type', 'application/json');
    req.setBody(jsonBody);

    //Send request
    Http http = new Http();
    HttpResponse res = http.send(req);
    if (res.getStatusCode() != WEBINAR_REGISTRANT_CREATED) {
      throw new ZoomApiRequestException(
        'Zoom Api Request failed with status code: ' +
          res.getStatusCode() +
          ' and error message: ' +
          res.getStatus()
      );
    }
  }

  //Class that represents input params for Zoom api request
  global class ZoomActionRequest {
    @InvocableVariable(required=true)
    global String firstName;

    @InvocableVariable(required=true)
    global String lastName;

    @InvocableVariable(required=true)
    global String email;

    @InvocableVariable(required=true)
    global String webinarId;
  }

  global class ZoomApiRequestException extends Exception {
  }
}
