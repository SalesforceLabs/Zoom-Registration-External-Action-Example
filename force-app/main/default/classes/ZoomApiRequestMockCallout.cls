@isTest
global class ZoomApiRequestMockCallout implements HttpCalloutMock {
  global HttpResponse respond(HttpRequest req) {
    HttpResponse res = new HttpResponse();
    res.setStatus('OK');
    res.setStatusCode(201);
    res.setBody('GREAT');
    return res;
  }
}
