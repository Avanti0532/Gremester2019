describe('FstudentList', function() {
    beforeEach(function() {
        setFixtures('<script src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js"> </script>table#dtOrderExample tbody tr td:nth-of-type(6)');
    });

    it('should call datatable for showing list of student', function(){
        var mock$ = spyOn(window, '$').and.returnValue({
            DataTable:jasmine.createSpy('$').and.returnValue(
                true
            ),
            addClass:jasmine.createSpy('$').and.returnValue(true)
        });
        fStudentList();
        expect(mock$).toHaveBeenCalled();

    });
});

describe('Year and Term Select', function(){

    beforeEach(function() {
         setFixtures(' <div class="col-md-4">\n' +
             '        <br/>\n' +
             '        <%= label_tag \'term\',\'Term\'%>\n' +
             '        <select id="term" name="term">\n' +
             '          <option value="any">**Any**</option>\n' +
             '          <option value="fall">Fall</option>\n' +
             '          <option value="winter">Winter</option>\n' +
             '          <option value="spring">Spring</option>\n' +
             '          <option value="summer">Summer</option>\n' +
             '        </select>\n' +
             '        <%= label_tag \'year\',\'Year\'%>\n' +
             '        <select id="year" name="year">\n' +
             '          <option value="any">**Any**</option>\n' +
             '          <% year = Date.today.year\n' +
             '             year_2 = year.to_i - 2\n' +
             '             for i in 0..4 do %>\n' +
             '            <option value="<%=year_2+i %>"><%=year_2+i %></option>\n' +
             '          <% end %>\n' +
             '        </select>\n' +
             '        <label class="checkbox-inline"><input type="checkbox" checked="true" name="and_later" id="and_later" disabled>And later terms</label>\n' +
             '      </div>')
    });

    it('should trigger year select function',function(){
        var spyEvent = spyOnEvent('#year', 'change');
        $("#year").change();
        fYearSelect();
        expect(spyEvent).toHaveBeenTriggered();
    });
    it('should check if the triggered event is stopped for year selection',function(){
        var spyEvent = spyOnEvent('#year', 'change');
        $('#year').change(function (event){event.stopPropagation();});
        $("#year").change();
        fYearSelect();
        expect('change').toHaveBeenStoppedOn('#year');
        expect(spyEvent).toHaveBeenStopped();
    });

    it('should call year select function',function(){
        spyOn($(this.id),"find").and.returnValue("**Any**");
        var checkprop = spyOn($('#and_later'),'prop');
        var spy = spyOn($("#year"), 'change' ).and.callThrough();
        $("#year").change();
        fYearSelect();
    });

    it('should check if the triggered event is stopped for term selection',function(){
        var spyEvent = spyOnEvent('#term', 'change');
        $('#term').change(function (event){event.stopPropagation();})
        $("#term").change();
        fTermSelect();
        expect('change').toHaveBeenStoppedOn('#term');
        expect(spyEvent).toHaveBeenStopped();
    });

});

