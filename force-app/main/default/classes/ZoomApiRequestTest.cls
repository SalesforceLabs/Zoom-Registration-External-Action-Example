@isTest
public class ZoomApiRequestTest {
  static testMethod void testAddWebinarRegistrant() {
    Test.startTest();

    //to makesure test class is cover, need to call invocable class directly, which in this scenario I need to instantiate
    // inner class

    List<ZoomApiRequest.ZoomActionRequest> request = new List<ZoomApiRequest.ZoomActionRequest>();
    ZoomApiRequest.ZoomActionRequest zoomReq = new ZoomApiRequest.ZoomActionRequest();
    zoomReq.firstName = 'Test';
    zoomReq.email = 'test@test.com';
    zoomReq.webinarId = 'ABC123';
    zoomReq.lastName = 'Last Name';

    request.add(zoomReq);

    Test.setMock(HttpCalloutMock.class, new ZoomApiRequestMockCallout());

    //the call the method directly - here my method is updateQuote
    ZoomApiRequest.addWebinarRegistrant(request);

    Test.stopTest();
  }
}
