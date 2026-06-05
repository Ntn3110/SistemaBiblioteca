package BackEnd.src.model;

public class Usuario {
    private long id;
    private String nome;
    private String email;
    private String telefone;
    private String CPF;

    public Usuario(long id, String nome, String email, String telefone, String CPF) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.telefone = telefone;
        this.CPF = CPF;
    }

    public long getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getEmail() {
        return email;
    }

    public String getTelefone() {
        return telefone;
    }

    public String getCPF() {
        return CPF;
    }
}