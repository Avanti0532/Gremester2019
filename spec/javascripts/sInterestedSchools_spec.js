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
it("university should not exist when delete is clicked", function() {
    loadFixtures('sInterestedSchools.html');
    let htmlResponse;
    let success = {
        reload: function(value) {
            window.location.reload();
        }
    };

    spyOn($('.trash'), 'click').and.callThrough();
    spyOn(success, 'reload');
    deleteSchoolFunc();
     $('#trash_3').trigger('click');
     spyOn($,'ajax').and.callFake(function(ajaxArgs) {
        ajaxArgs.success(htmlResponse, '200');
     });
    success.reload();
    expect(success.reload).toHaveBeenCalled();
})