describe('My applications', function() {
    describe('Delete Applications', function () {
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
            spyOn($, 'ajax').and.callFake(function (ajaxArgs) {
                ajaxArgs.success(htmlResponse, '200');
            });
            success.reload();
            expect(success.reload).toHaveBeenCalled();
        });
    });

    describe('Edit Applications', function () {
        beforeEach(function () {

            loadFixtures('sInterestedSchools.html');
        });
        it("should trigger an event when edit is clicked", function () {
            var spyEvent = spyOnEvent('#edit_4_4', 'click');
            $("#edit_4_4").click();
            editSchoolFunc();
            expect('click').toHaveBeenTriggeredOn('#edit_4_4');
            expect(spyEvent).toHaveBeenTriggered();
        });

    });

    describe('Add applications', function () {
        beforeEach(function () {
            loadFixtures('sInterestedSchools.html');
            window.gon = {};
            gon.universities = "Auburn University"
        });
        it("should trigger an event add school is clicked", function () {
            var spyEvent = spyOnEvent('#addrow', 'click')
            $("#addrow").click();
            addSchoolFunc();
            expect('click').toHaveBeenTriggeredOn('#addrow')
            expect(spyEvent).toHaveBeenTriggered()
        });

        it('append rows when add is clicked', function () {
            spyOn($("#addrow"), 'click').and.callThrough();
            addSchoolFunc();
            $("#addrow").click();
            expect(jQuery(document).ready(jQuery("#myTableId")).length).toBe(1);
        });

    });

    describe('Save applications', function () {
        beforeEach(function () {
            setFixtures('<td><input type="button" class="save btn btn-md btn-success " value="Save" id="add_save"><div id="add_alert" class="alert alert-danger fade" role="alert"></div></td>');
        });
        it('should trigger save school event', function () {
            var spyEvent = spyOnEvent('#add_save', 'click');
            $("#add_save").click();
            saveSchoolFunc();
            expect('click').toHaveBeenTriggeredOn('#add_save');
            expect(spyEvent).toHaveBeenTriggered();
        });
        it('should call success when successful server call', function () {
            let htmlResponse;
            var success = jasmine.createSpy('success');
            $("table.order-list").trigger('click', ".save");
            saveSchoolFunc();
            spyOn($, 'ajax').and.callFake(function (ajaxArgs) {
                ajaxArgs.success(htmlResponse, '200');
            });
            success.and.callFake(function (jsonData) {
                expect(success).toHaveBeenCalled();

            });

        });
    });

    describe('Save Modal applications', function () {
        beforeEach(function () {
            loadFixtures('sInterestedSchools.html');
        });
        it('should trigger save edit school changes event', function () {
            var spyEvent = spyOnEvent('#saveModal', 'click');
            $("#saveModal").click();
            saveModalFunc();
            expect('click').toHaveBeenTriggeredOn('#saveModal');
            expect(spyEvent).toHaveBeenTriggered();
        });
        it('should hide modal when successful server call', function () {
            var success = jasmine.createSpy('success');
            var htmlResponse;
            spyOn($("#saveModal"), 'click').and.callThrough();
            saveModalFunc();
            $("#saveModal").click();
            spyOn($, 'ajax').and.callFake(function (ajaxArgs) {
                ajaxArgs.success(htmlResponse, '200');
            });
            success.and.callFake(function (jsonData) {
                expect(success).toHaveBeenCalled();
                expect($("#schoolModal")).toBeHidden();

            });
        });

        it('should gave error message if both admitted date and rejected date are selected', function () {
            setFixtures('<div class="modal-body">\n' +
                '                <form role="form">\n' +
                '                    <div class="alert alert-danger fade" role="alert"></div>\n' +
                '                    <div class="form-group">\n' +
                '                        <label>University Name:</label>\n' +
                '                        <input type="text" class="form-control" id="uni_name" disabled="true">\n' +
                '                    </div>\n' +
                '                    <label>Applied Date:</label>\n' +
                '                    <input id="datepickerapp" type="date" class="form-control" value="2018-05-11" />\n' +
                '                    <label>Accepted Date:</label>\n' +
                '                    <input id="datepickeradm" type="date" class="form-control" value="2018-05-11" />\n' +
                '                    <label>Rejected Date:</label>\n' +
                '                    <input id="datepickerrej" type="date" class="form-control" value="2019-03-11" />\n' +
                '                    <input type=\'hidden\' name=\'_method\' value=\'put\' />\n' +
                '                </form>\n' +
                '            </div>\n' +
                '            <div class="modal-footer">\n' +
                '                <button type="button" class="btn btn-default btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>\n' +
                '                <button type="button" class="btn btn-default btn-success pull-right" id="saveModal"><span class="glyphicon glyphicon-upload"></span>Save</button>\n' +
                '            </div>');
            saveModalFunc();
            $("#saveModal").click();
            expect($("div[role=alert]")).toContainText('Both admitted date and rejected date cannot be selected!')
        });

        it('should return an error if applied date is later than rejected date', function () {
            setFixtures('<div class="modal-body">\n' +
                '                <form role="form">\n' +
                '                    <div class="alert alert-danger fade" role="alert"></div>\n' +
                '                    <div class="form-group">\n' +
                '                        <label>University Name:</label>\n' +
                '                        <input type="text" class="form-control" id="uni_name" disabled="true">\n' +
                '                    </div>\n' +
                '                    <label>Applied Date:</label>\n' +
                '                    <input id="datepickerapp" type="date" class="form-control" value="2019-05-17" />\n' +
                '                    <label>Accepted Date:</label>\n' +
                '                    <input id="datepickeradm" type="date" class="form-control" value="" />\n' +
                '                    <label>Rejected Date:</label>\n' +
                '                    <input id="datepickerrej" type="date" class="form-control" value="2018-05-11" />\n' +
                '                    <input type=\'hidden\' name=\'_method\' value=\'put\' />\n' +
                '                </form>\n' +
                '            </div>\n' +
                '            <div class="modal-footer">\n' +
                '                <button type="button" class="btn btn-default btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>\n' +
                '                <button type="button" class="btn btn-default btn-success pull-right" id="saveModal"><span class="glyphicon glyphicon-upload"></span>Save</button>\n' +
                '            </div>');
            saveModalFunc();
            $("#saveModal").click();
            expect($("div[role=alert]")).toContainText('Applied date cannot be later than rejected date!')
        })
        it('should return an error if applied date is empty', function () {
            setFixtures('<div class="modal-body">\n' +
                '                <form role="form">\n' +
                '                    <div class="alert alert-danger fade" role="alert"></div>\n' +
                '                    <div class="form-group">\n' +
                '                        <label>University Name:</label>\n' +
                '                        <input type="text" class="form-control" id="uni_name" disabled="true">\n' +
                '                    </div>\n' +
                '                    <label>Applied Date:</label>\n' +
                '                    <input id="datepickerapp" type="date" class="form-control" value="" />\n' +
                '                    <label>Accepted Date:</label>\n' +
                '                    <input id="datepickeradm" type="date" class="form-control" value="" />\n' +
                '                    <label>Rejected Date:</label>\n' +
                '                    <input id="datepickerrej" type="date" class="form-control" value="2018-05-11" />\n' +
                '                    <input type=\'hidden\' name=\'_method\' value=\'put\' />\n' +
                '                </form>\n' +
                '            </div>\n' +
                '            <div class="modal-footer">\n' +
                '                <button type="button" class="btn btn-default btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>\n' +
                '                <button type="button" class="btn btn-default btn-success pull-right" id="saveModal"><span class="glyphicon glyphicon-upload"></span>Save</button>\n' +
                '            </div>');
            saveModalFunc();
            $("#saveModal").click();
            expect($("div[role=alert]")).toContainText('Applied date cannot be empty')
        });

        it('should return an error if applied date is later than admitted date', function () {
            setFixtures('<div class="modal-body">\n' +
                '                <form role="form">\n' +
                '                    <div class="alert alert-danger fade" role="alert"></div>\n' +
                '                    <div class="form-group">\n' +
                '                        <label>University Name:</label>\n' +
                '                        <input type="text" class="form-control" id="uni_name" disabled="true">\n' +
                '                    </div>\n' +
                '                    <label>Applied Date:</label>\n' +
                '                    <input id="datepickerapp" type="date" class="form-control" value="2019-05-17" />\n' +
                '                    <label>Accepted Date:</label>\n' +
                '                    <input id="datepickeradm" type="date" class="form-control" value="2018-05-11" />\n' +
                '                    <label>Rejected Date:</label>\n' +
                '                    <input id="datepickerrej" type="date" class="form-control" value="" />\n' +
                '                    <input type=\'hidden\' name=\'_method\' value=\'put\' />\n' +
                '                </form>\n' +
                '            </div>\n' +
                '            <div class="modal-footer">\n' +
                '                <button type="button" class="btn btn-default btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>\n' +
                '                <button type="button" class="btn btn-default btn-success pull-right" id="saveModal"><span class="glyphicon glyphicon-upload"></span>Save</button>\n' +
                '            </div>');
            saveModalFunc();
            $("#saveModal").click();
            expect($("div[role=alert]")).toContainText('Applied date cannot be later than admitted date!')
        });
    });

    describe('Delete School Row', function () {

        it('should delete row', function () {
            setFixtures('<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Delete" id="uni_delete"></td>');
            var input = $('.ibtnDel');
            var spyEvent = spyOnEvent(input, 'click' );
            spyOn(input, 'click' ).and.callThrough();
            delRowFunc();
            $( input ).click();
            expect( spyEvent ).toHaveBeenTriggered();
        });
    });
});

