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
    beforeEach(function() {
        loadFixtures('sInterestedSchools.html');
    });
    it("should trigger an event when edit is clicked", function(){
        var spyEvent = spyOnEvent('#edit_4_4', 'click')
        $("#edit_4_4").click()
        expect('click').toHaveBeenTriggeredOn('#edit_4_4')
        expect(spyEvent).toHaveBeenTriggered()
    });

    it('successful server call when edit is clicked', function(){
        //let htmlResponse;
        let jsonData = {"id":2,"profile_id":1,"university_id":65,"applied":true,"applied_date":"2019-04-17T00:00:00.000Z","admitted":null,"admitted_date":null,"rejected":null,"rejected_date":null,"created_at":"2019-04-05T21:15:11.712Z","updated_at":"2019-04-05T21:15:11.712Z","term":"Fall","year":2019,"uni_name":"California Institute Of Technology"};
        //var spy = spyOn(window, "editSchoolFunc");
        //$("#schoolModal").modal();
        //var spy = spyon($("#schoolModal"),'modal');
        //var modalSpy = spyOn($("#schoolModal").modal(),'backdrop').and.callFake(function(){
            //return true;
        //});

        //$("#schoolModal").modal();
        spyOn($('.edit'), 'click').and.callThrough();
        //let modal = {
         //   editPopup: function(){
               // {backdrop: true}
            //}
        //}
        //var modalSpy = spyOn(modal(),'backdrop').andReturn(true);
         //var modalSpy = jasmine.createSpyObj('modal',['backdrop']);
        //$("#schoolModal").modal();
        //var modalSpy = spyOn($("#schoolModal"), 'modal').and.callThrough();
         var modalSpy = spyOn(modal(),'backdrop').andReturn(true);
         editSchoolFunc();
         $('#edit_4_4').trigger('click');
         spyOn($, 'ajax').and.callFake(function(ajaxArgs) {
             ajaxArgs.success(jsonData);
         });
         //modal.editPopup();
         //expect(modal.editPopup).toHaveBeenCalled();
         //$("#schoolModal").modal();
         expect(modalSpy).toHaveBeenCalled();
        //expect($.ajax.mostRecentCall.args[0]['url']).toEqual('/applications/3');

    });

});

describe('Add applications', function() {
    beforeEach(function() {
        loadFixtures('sInterestedSchools.html');
    });
    it("should trigger an event add school is clicked", function() {
        var spyEvent = spyOnEvent('#addrow', 'click')
        $("#addrow").click()
        expect('click').toHaveBeenTriggeredOn('#addrow')
        expect(spyEvent).toHaveBeenTriggered()
    });

 it('append rows when add is clicked', function(){
     spyOn($("#addrow"), 'click').and.callThrough();
     expect(jQuery(document).ready(jQuery("#myTableId")).length).toBe(1);
 });

});
