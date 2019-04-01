
describe('Delete Applications', function() {
    //let htmlResponse;
    //beforeEach(function() {

       let htmlResponse = fixture.load('sInterestedSchools.html');
        //spyOn($,'ajax').and.callFake(function(ajaxArgs) {
          //  ajaxArgs.success(htmlResponse, '200');
        //});
    //});

    it("university should not exist when delete is clicked", function() {

        let trash = {
            deleteSchool: function(value) {
                var app_id = value.substr(5).split('_');
                var appn_id = app_id[1];
                spyOn($,'ajax').and.callFake(function(ajaxArgs) {
                       ajaxArgs.success(htmlResponse, '200');
                    });
            }
        };
        spyOn(trash, 'deleteSchool');
        $('#trash_3').trigger('click');
        expect(trash.deleteSchool).toHaveBeenCalled();

    })

    it("should not contain university text when deleted", function(){
        $('#trash_3').trigger('click');
        expect($(document)).not.toContain('Boston University');
    })

});


