
describe('Add School', function() {
    beforeEach(function() {

        fixture.set('<script  src="sInterestedSchools.js"></script><input type="button" class="btn btn-default " id="addrow" value="Add School" />');
    });

    it("should trigger an event add school is clicked", function() {
        sInterestedSchool();
        gon = {universities: [{university_name: "test"}]};
        var spyEvent = spyOnEvent('#addrow', 'click');

        $("#addrow").trigger('click');
        expect('click').toHaveBeenTriggeredOn('#addrow');
        expect(spyEvent).toHaveBeenTriggered();
    })

});


describe('Show calender', function() {
    beforeEach(function() {
        fixture.set('<div class="input-group date datepicker-me" id="datetimepicker0">');
    });

    it("should trigger an event when calender icon is clicked", function() {
        sInterestedSchool();
        var spyEvent = spyOnEvent('#datetimepicker0', 'click')
        $("#datetimepicker0").trigger('click');
        expect('click').toHaveBeenTriggeredOn('#datetimepicker0')
        expect(spyEvent).toHaveBeenTriggered()

    })

});

describe('Delete Applications', function() {
    let htmlResponse;
    beforeEach(function() {

        htmlResponse = fixture.load('sInterestedSchools.html');
        spyOn($,'ajax').and.callFake(function(ajaxArgs) {
            ajaxArgs.success(htmlResponse, '200');
        });
    });

    it("university should not exist when delete is clicked", function() {
        sInterestedSchool();
        $('#trash').trigger('click');
        expect('#trash').not.toExist();
    })

    it("should not contain university text when deleted", function(){
        sInterestedSchool();
        $('#trash_3').trigger('click');
        expect($(document)).not.toContain('Boston University');
    })

});


describe('Edit Applications', function() {
    beforeEach(function() {
        htmlResponse =  fixture.load('sInterestedSchools.html');
        spyOn($,'ajax').and.callFake(function(ajaxArgs) {
            ajaxArgs.success(htmlResponse, {'200': 'test'});
        });
    });
    // it("should trigger an event when edit is clicked", function(){
    //     sInterestedSchool();
    //     var spyEvent = spyOnEvent('#edit_4_4', 'click')
    //     $("#edit_4_4").trigger('click');
    //     expect('click').toHaveBeenTriggeredOn('#edit_4_4')
    //     expect(spyEvent).toHaveBeenTriggered()
    // })
    //
    // it("should open edit modal when edit is clicked", function(){
    //     sInterestedSchool();
    //     $(".edit").trigger('click');
    //     var result = $('#schoolModal').modal({backdrop: true});
    //     expect(mock$).toHaveBeenCalled();
    //     expect(result).toEqual(true);
    //     expect('.modal-content').toBeVisible();
    // });
    it("should trigger an event when save is clicked", function(){

        sInterestedSchool();
        var spyEvent = spyOnEvent('#saveModal', 'click')
        $("#saveModal").click()
        expect('click').toHaveBeenTriggeredOn('#saveModal')
        expect(spyEvent).toHaveBeenTriggered()
    })
});