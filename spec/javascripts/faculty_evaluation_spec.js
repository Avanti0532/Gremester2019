describe('Faculty Evaluation', function() {
    beforeEach(function() {
        setFixtures('<script src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js"></script>');
    });

    it('should call data-table function', function(){
        var mock$ = spyOn(window, '$').and.returnValue({
            DataTable:jasmine.createSpy('$').and.returnValue(
                true
            ),
            addClass:jasmine.createSpy('$').and.returnValue(true)
        });
        facultyEvaluation();
        expect(mock$).toHaveBeenCalled();

    });

});