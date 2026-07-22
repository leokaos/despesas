import { addDays, format, subDays, endOfMonth as dateFnsEndOfMonth, endOfYear as dateFnsEndOfYear } from 'date-fns';

export class QueryUtil {

    public static FUNCOES = new Map<string, (param: string) => string>([
        ["now", QueryUtil.now],
        ["startOfMonth", QueryUtil.startOfMonth],
        ["startOfYear", QueryUtil.startOfYear],
        ["endOfMonth", QueryUtil.endOfMonth],
        ["endOfYear", QueryUtil.endOfYear],
        ["today", QueryUtil.today],
    ]);

    constructor() { }

    private static today(expression: string): string {
        let date = new Date();
        date.setUTCHours(0, 0, 0, 0);
        return QueryUtil.decorateWithExpressions(expression, date);
    }

    private static now(expression: string): string {
        return QueryUtil.decorateWithExpressions(expression, new Date());
    }

    private static startOfMonth(expression: string) {
        let now = new Date();
        let date = new Date(now.getFullYear(), now.getMonth(), 1, 0, 0, 0, 0);

        return QueryUtil.decorateWithExpressions(expression, date);
    }

    private static startOfYear(expression: string) {
        let now = new Date();
        let date = new Date(now.getFullYear(), 0, 1, 0, 0, 0, 0);

        return QueryUtil.decorateWithExpressions(expression, date);
    }

    private static endOfMonth(expression: string) {
        let now = new Date();
        let date = dateFnsEndOfMonth(now);
        date.setHours(23, 59, 59, 999);

        return QueryUtil.decorateWithExpressions(expression, date);
    }

    private static endOfYear(expression: string) {
        let now = new Date();
        let date = dateFnsEndOfYear(now);
        date.setHours(23, 59, 59, 999);

        return QueryUtil.decorateWithExpressions(expression, date);
    }

    private static decorateWithExpressions(expression: string, dataBase: Date): string {

        const operacoes = expression.matchAll(/([+-])\s*(\d+)/g);
        let finalDate = dataBase;

        for (const op of operacoes) {
            const quantidade = parseInt(op[2]);
            if (op[1] === '-') {
                finalDate = subDays(dataBase, quantidade);
            } else if (op[1] === '+') {
                finalDate = addDays(dataBase, quantidade);
            }
        }

        return format(finalDate, 'yyyy-MM-dd');
    }

}