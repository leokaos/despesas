export class Interval {

    static readonly CURRENT_YEAR = new Interval(
        'Ano Atual',
        () => new Date(new Date().getFullYear(), 0, 1, 0, 0, 0),
        () => new Date());

    static readonly LAST_YEAR = new Interval(
        'Ano Passado',
        () => new Date(new Date().getFullYear() - 1, 0, 1, 0, 0, 0),
        () => new Date(new Date().getFullYear() - 1, 11, 31, 23, 59, 59)
    );

    static readonly CURRENT_MONTH = new Interval(
        'Mês Atual',
        () => new Date(Date.UTC(new Date().getFullYear(), new Date().getMonth(), 1, 0, 0, 0)),
        () => new Date()
    );

    static readonly LAST_MONTH = new Interval(
        'Mês Passado',
        () => new Date(Date.UTC(new Date().getFullYear(), new Date().getMonth() - 1, 1, 0, 0, 0)),
        () => new Date(Date.UTC(new Date().getFullYear(), new Date().getMonth(), 0, 23, 59, 59))
    );

    static readonly LAST_SIX_MONTH = new Interval(
        'Últimos seis meses',
        () => {
            const date = new Date();
            date.setMonth(date.getMonth() - 6);
            date.setDate(1);
            date.setHours(0, 0, 0, 0);
            return date;
        },
        () => new Date(Date.UTC(new Date().getFullYear(), new Date().getMonth(), 0, 23, 59, 59))
    );

    private constructor(
        public readonly descricao: string,
        public readonly dataInicialProvider: () => Date,
        public readonly dataFinalProvider: () => Date,
    ) { }

    public getDataInicial() {
        return this.dataInicialProvider();
    }

    public getDataFinal() {
        return this.dataFinalProvider();
    }

    static values(): Interval[] {
        return [
            Interval.CURRENT_YEAR,
            Interval.LAST_YEAR,
            Interval.CURRENT_MONTH,
            Interval.LAST_MONTH,
            Interval.LAST_SIX_MONTH
        ];
    }

}