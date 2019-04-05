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
    var spyEvent = spyOnEvent('.trash', 'click');
    //this = 'trash_3'
    let htmlResponse;

    //this.substr(5).split('_') = ['trash',"3"]
    deleteSchoolFunc();
     $('#trash_3').trigger('click');
    // noinspection JSAnnotator
    this.substr(5).split('_') = ['trash',"3"]
    //var app = spyOn($(this.substr),'split').and.returnValue(['trash','3'])
    spyOn($,'ajax').and.callFake(function(ajaxArgs) {
        ajaxArgs.success(htmlResponse, '200');
    });
    expect('#trash_3').not.toBeVisible();
})