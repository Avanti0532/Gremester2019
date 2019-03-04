describe('Add School', function() {
    beforeEach(function() {
        setFixtures('<input type="button" class="btn btn-default " id="addrow" value="Add School" />');
    });

    it("one row show exist after page load", function () {
        expect(jQuery(document).ready(jQuery("#myTable")).length).toBe(1)})

    it("should trigger an event add school is clicked", function() {
          var spyEvent = spyOnEvent('#addrow', 'click')
          $("#addrow").click()
          expect('click').toHaveBeenTriggeredOn('#addrow')
          expect(spyEvent).toHaveBeenTriggered()
    })
});

describe('Delete School', function() {
    beforeEach(function() {
        setFixtures('<td class="col-sm-2"><a class="deleteRow"></a>');
    });

    it("should trigger an event delete is clicked", function() {
        var spyEvent = spyOnEvent('.deleteRow', 'click')
        $(".deleteRow").click()
        expect('click').toHaveBeenTriggeredOn('.deleteRow')
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
