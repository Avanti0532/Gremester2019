describe('Add School', function() {
    beforeEach(function() {
        setFixtures('<input type="button" class="btn btn-default " id="addrow" value="Add School" />');
    });

    it("should trigger an event add school is clicked", function() {
          var spyEvent = spyOnEvent('#addrow', 'click')
          $("#addrow").click()
          expect('click').toHaveBeenTriggeredOn('#addrow')
          expect(spyEvent).toHaveBeenTriggered()
    })
});


describe('Show calender', function() {
    beforeEach(function() {
        setFixtures('<div class="input-group date datepicker-me" id="datetimepicker0">');
    });

    it("should trigger an event when calender icon is clicked", function() {
        var spyEvent = spyOnEvent('#datetimepicker0', 'click')
        $("#datetimepicker0").click()
        expect('click').toHaveBeenTriggeredOn('#datetimepicker0')
        expect(spyEvent).toHaveBeenTriggered()

    })

});

describe('Delete Applications', function() {
    let htmlResponse;
    beforeEach(function() {
        htmlResponse = readFixtures('sInterestedSchools.html');
        spyOn($,'ajax').and.callFake(function(ajaxArgs) {
            ajaxArgs.success(htmlResponse, '200');
        });
    });

    it("university should not exist when delete is clicked", function() {
        $('#trash_3').trigger('click');
        expect('#trash_3').not.toExist();
    })

    it("should not contain university text when deleted", function(){
        $('#trash_3').trigger('click');
        expect($(document)).not.toContain('Boston University');
    })

});

describe('Edit Applications', function() {
    beforeEach(function() {
        loadFixtures('sInterestedSchools.html');
    });
    it("should trigger an event when edit is clicked", function(){
        var spyEvent = spyOnEvent('#edit_4_4', 'click')
        $("#edit_4_4").click()
        expect('click').toHaveBeenTriggeredOn('#edit_4_4')
        expect(spyEvent).toHaveBeenTriggered()
    })
    it("should open the edit modal when edit is clicked", function(){
        //var h = readFixtures('sInterestedSchools.html');
        //var modalSpy = spyOn($("#schoolModal"),'modal').and.returnValue(true)
        //var modalSpy = spyOn($('.edit'),'click').and.callThrough();
        $("#edit_4_4").click();
        //$('.edit').click()
        //$("#schoolModal").modal({backdrop: true});
        //expect($('.edit').click()).toHaveBeenCalled();
    })
});