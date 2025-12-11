# Knowledge Distillation for Economics (English Version)

This is the English version of the paper "Knowledge Distillation for Economics: Trading Complexity for Interpretability in Econometric Models".

## Authors
- Gustavo Coelho Haase (Banco do Brasil S.A)
- Paulo Henrique Dourado da Silva (Banco do Brasil S.A)

## Abstract

Economists and policymakers face a fundamental dilemma: complex machine learning models achieve high predictive accuracy but lack the economic interpretability essential for policy analysis, while traditional econometric models are interpretable but limited in predictive power. We present an econometric knowledge distillation framework that transfers knowledge from complex models to interpretable models, simultaneously preserving economic intuition, economic constraints, and coefficient stability.

## Compilation

To compile the paper, run:

```bash
./compile.sh
```

Or manually:

```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

## Structure

- `main.tex` - Main document file
- `sections/` - Individual section files
  - `01_introduction.tex` - Introduction and motivation
  - `02_background.tex` - Related work and theoretical foundations
  - `03_design.tex` - Framework design
  - `04_implementation.tex` - Implementation details
  - `05_evaluation.tex` - Evaluation and case studies
  - `06_discussion.tex` - Discussion and implications
  - `07_conclusion.tex` - Conclusions and future work
- `bibliography/references.bib` - Bibliography references
- `acmart.cls` - ACM article class

## Requirements

- LaTeX distribution (TeX Live, MiKTeX, etc.)
- BibTeX
- Required LaTeX packages: babel, inputenc, fontenc, graphicx, booktabs, amsmath, listings, xcolor, algorithm, algpseudocode, pifont

## Note

This is a translation from the original Portuguese version located in `../portuguese/`.
