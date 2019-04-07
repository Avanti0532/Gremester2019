describe('FstudentList', function() {
    beforeEach(function() {
        setFixtures('<script src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js"> </script>table#dtOrderExample tbody tr td:nth-of-type(6)');
    });

    it('should trigger save edit school changes event', function(){
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