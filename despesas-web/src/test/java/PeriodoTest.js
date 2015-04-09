describe('PeriodoTest ', function() {

  it('deveria retornar a data 01/01/2015', function() {

    var vo = new Periodo(1, 2015);

    var dateInicial = new Date(2015, 0, 1, 0, 0, 0, 0);

    expect(vo.getDataInicial()).toEqual(dateInicial);

  });

  it('deveria retornar a data 31/01/2015', function() {

    var vo = new Periodo(1, 2015);

    var dateFinal = new Date(2015, 0, 31, 23, 59, 59, 999);

    expect(vo.getDataFinal()).toEqual(dateFinal);

  });

  it('toString deveria retornar janeiro de 2015', function() {

    var vo = new Periodo(1, 2015);

    expect(vo.toString()).toEqual("janeiro de 2015");

  });

});
