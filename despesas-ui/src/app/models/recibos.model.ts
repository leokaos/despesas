import { computed, signal } from '@angular/core';
import { Periodo } from './periodo.model';
import { PeriodoUtil } from './util';
import { Feriado } from './feriado.model';

export class ReceitaRecibo {

    dataInicial = signal<Date>(new Date());
    dataFinal = signal<Date>(new Date());
    valorDiario = signal<number>(0);
    percentIVA = signal<number>(0);
    percentIRS = signal<number>(0);
    feriados: Feriado[];
    periodo: Periodo;

    computeDiasUteis = computed(() => {

        let count = 0;
        const curDate = new Date(this.dataInicial().getTime());

        while (curDate <= this.dataFinal()) {
            const dayOfWeek = curDate.getDay();
            if (dayOfWeek !== 0 && dayOfWeek !== 6) {
                const feriado = this.feriados.find(item => this.mesmoDia(curDate, item.data));
                if (!feriado) {
                    count++;
                }
            }
            curDate.setDate(curDate.getDate() + 1);
        }

        return count;
    });

    computeValorBruto = computed(() => this.computeDiasUteis() * this.valorDiario());
    computeValorIVA = computed(() => this.computeValorBruto() * this.percentIVA());
    computeValorLiquido = computed(() => this.computeValorBruto() * (1 - this.percentIRS()));

    constructor(periodo: Periodo, valorDiario: number, percentIVA: number, percentIRS: number, feriados: Feriado[]) {
        this.dataInicial.set(PeriodoUtil.getDataInicial(periodo));
        this.dataFinal.set(PeriodoUtil.getDataFinal(periodo));
        this.valorDiario.set(valorDiario);
        this.percentIVA.set(percentIVA);
        this.percentIRS.set(percentIRS);
        this.feriados = feriados;
        this.periodo = periodo;
    }

    public diasUteis(): number {
        return this.computeDiasUteis();
    }

    public valorBruto(): number {
        return this.computeValorBruto();
    }

    public valorIVA(): number {
        return this.computeValorIVA();
    }

    public valorLiquido(): number {
        return this.computeValorLiquido();
    }

    private mesmoDia(data1: Date, data2: Date) {
        return data1.getFullYear() === data2.getFullYear() && data1.getMonth() === data2.getMonth() && data1.getDate() === data2.getDate();
    }
}
