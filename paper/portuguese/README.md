# Paper - Versão em Português

**Título**: Destilação de Conhecimento para Economia: Negociando Complexidade por Interpretabilidade em Modelos Econométricos

**Title (English)**: Knowledge Distillation for Economics: Trading Complexity for Interpretability in Econometric Models

---

## 📄 Arquivos

- **main.tex** - Arquivo principal do paper em LaTeX
- **main.pdf** - PDF compilado do paper
- **sections/** - Seções do paper (7 arquivos)
- **bibliography/** - Referências bibliográficas
- **acmart.cls** - Classe LaTeX ACM
- **compile.sh** - Script de compilação

---

## 🔨 Como Compilar

### Opção 1: Script Automático

```bash
cd paper/portuguese
chmod +x compile.sh
./compile.sh
```

### Opção 2: Compilação Manual

```bash
cd paper/portuguese
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

---

## 📚 Estrutura do Paper

### Seções

1. **01_introduction.tex** - Introdução
2. **02_background.tex** - Fundamentação e Trabalhos Relacionados
3. **03_design.tex** - Design do Framework
4. **04_implementation.tex** - Implementação
5. **05_evaluation.tex** - Avaliação
6. **06_discussion.tex** - Discussão
7. **07_conclusion.tex** - Conclusão

### Bibliografia

- **references.bib** - Referências completas do paper

---

## 🎯 Target Venues

- Journal of Econometrics (principal)
- NeurIPS Economics & Computation Track
- Review of Economic Studies

---

## 📊 Informações do Paper

- **Status**: Completo e pronto para submissão
- **Páginas**: ~10 páginas
- **Idioma**: Português (versão original)
- **Formato**: ACM format (acmart.cls)

---

## 🔄 Versão em Inglês

A versão em inglês do paper está em desenvolvimento em `paper/english/`.

---

**Última atualização**: 2025-12-10
