describe('Faculty to see other Evaluation', function() {
    beforeEach(function() {
        setFixtures('<script src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js"></script>table#facultyOEvaluationTable tbody tr td:nth-of-type(3)');
    });

    it('should call data-table function', function(){
        var mock$ = spyOn(window, '$').and.returnValue({
            DataTable:jasmine.createSpy('$').and.returnValue(
                true
            ),
            addClass:jasmine.createSpy('$').and.returnValue(true)
        });
        facultyOEvaluation();
        expect(mock$).toHaveBeenCalled();

    });

});