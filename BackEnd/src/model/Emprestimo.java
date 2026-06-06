package BackEnd.src.model;

import java.time.LocalDate;

public class Emprestimo {
    private long id;
    private long usuarioId;
    private long livroId;
    private LocalDate dataEmprestimo;
    private LocalDate dataPrevistaDevolucao;
    private LocalDate dataDevolucao;
    private String status;
    private double multa;

    public Emprestimo(long id, long usuarioId, long livroId, LocalDate dataEmprestimo, LocalDate dataPrevistaDevolucao, LocalDate dataDevolucao, String status, double multa) {
        this.id = id;
        this.usuarioId = usuarioId;
        this.livroId = livroId;
        this.dataEmprestimo = dataEmprestimo;
        this.dataPrevistaDevolucao = dataPrevistaDevolucao;
        this.dataDevolucao = dataDevolucao;
        this.status = status;
        this.multa = multa;
    }

    public long getId() {
        return id;
    }

    public long getUsuarioId() {
        return usuarioId;
    }

    public long getLivroId() {
        return livroId;
    }

    public LocalDate getDataEmprestimo() {
        return dataEmprestimo;
    }

    public LocalDate getDataPrevistaDevolucao() {
        return dataPrevistaDevolucao;
    }

    public LocalDate getDataDevolucao() {
        return dataDevolucao;
    }

    public String getStatus() {
        return status;
    }

    public double getMulta() {
        return multa;
    }

    public void setMulta(double multa) {
        this.multa = multa;
    }
}