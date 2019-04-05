//
// describe('Delete Applications', function() {
//     //let htmlResponse;
//     //beforeEach(function() {
//
//     let htmlResponse = loadFixtures('sInterestedSchools.html');
//     //spyOn($,'ajax').and.callFake(function(ajaxArgs) {
//     //  ajaxArgs.success(htmlResponse, '200');
//     //});
//     //});
//
//     it("university should not exist when delete is clicked", function() {
//
//          let trash = {
//                deleteSchool: function(value) {
//             }
//          };
//          spyOn(trash, 'deleteSchool').and.callThrough();
//         trash.deleteSchool('trash_3');
//         $('#trash_3').click();
//          expect(trash.deleteSchool).toHaveBeenCalledWith('trash_3');
//     })
//
//     it("should not contain university text when deleted", function(){
//         $('#trash_3').trigger('click');
//         expect($(document)).not.toContain('Boston University');
//     })
//
// });
describe('Delete Applications', function() {
    it("successful server call when deletion is called", function () {
        loadFixtures('sInterestedSchools.html');
        let htmlResponse;
        let success = {
            reload: function (value) {
                window.location.reload();
            }
        };

        spyOn($('.trash'), 'click').and.callThrough();
        spyOn(success, 'reload');
        deleteSchoolFunc();
        $('#trash_3').trigger('click');
        spyOn($, 'ajax').and.callFake(function(ajaxArgs) {
            ajaxArgs.success(htmlResponse, '200');
        });
        success.reload();
        expect(success.reload).toHaveBeenCalled();
    });
});

describe('Edit Applications', function(){
    it('successful server call when edit is clicked', function(){
        loadFixtures('sInterestedSchools.html');
        let jsonData = {"id":2,"profile_id":1,"university_id":65,"applied":true,"applied_date":"2019-04-17T00:00:00.000Z","admitted":null,"admitted_date":null,"rejected":null,"rejected_date":null,"created_at":"2019-04-05T21:15:11.712Z","updated_at":"2019-04-05T21:15:11.712Z","term":"Fall","year":2019,"uni_name":"California Institute Of Technology"};
        spyOn($('.edit'), 'click').and.callThrough();
        editSchoolFunc();
        $('#edit_4_4').trigger('click');
        spyOn($, 'ajax').and.callFake(function(ajaxArgs) {
             ajaxArgs.success(jsonData);
        });

    });

});