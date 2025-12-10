# Paper - Knowledge Distillation for Economics

**Title**: Knowledge Distillation for Economics: Trading Complexity for Interpretability in Econometric Models

**Título (Português)**: Destilação de Conhecimento para Economia: Negociando Complexidade por Interpretabilidade em Modelos Econométricos

---

## 📁 Organization

This directory contains the paper in **two language versions**:

### 🇧🇷 Portuguese Version (Original)
📂 **`portuguese/`** - Complete and ready for submission
- ✅ LaTeX source files
- ✅ Compiled PDF (main.pdf)
- ✅ All sections and references
- ✅ **Status**: Complete and ready

### 🇺🇸 English Version (Planned)
📂 **`english/`** - In development for international submission
- 🚧 LaTeX source files (to be added)
- 🚧 **Status**: In development

---

## 🚀 Quick Start

### Read the Paper

**Portuguese Version** (complete):
```bash
cd paper/portuguese
open main.pdf  # macOS
# or: xdg-open main.pdf  # Linux
# or: start main.pdf  # Windows
```

### Compile the Paper

**Portuguese Version**:
```bash
cd paper/portuguese
chmod +x compile.sh
./compile.sh
```

Or manually:
```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

---

## 📚 Paper Structure

Both versions follow the same structure:

### Sections

1. **Introduction** - Motivation, problem statement, and contributions
2. **Background and Related Work** - Literature review and gap analysis
3. **Framework Design** - Architecture and economic constraints
4. **Implementation** - Technical details and algorithms
5. **Evaluation** - Experiments with real-world datasets
6. **Discussion** - Findings, limitations, and implications
7. **Conclusion** - Summary and future directions

---

## 🎯 Target Venues

### Primary Targets
- **Journal of Econometrics** (main target)
- **NeurIPS** - Economics and Computation Track

### Alternative Venues
- Review of Economic Studies
- American Economic Review (if results exceptional)
- Econometrica

---

## 📊 Paper Information

| Aspect | Details |
|--------|---------|
| **Length** | ~10 pages |
| **Format** | ACM format (acmart.cls) |
| **Datasets** | German Credit (1K), Adult Income (48K) |
| **Key Results** | 97%+ accuracy retention, 95%+ compliance |
| **Status** | Ready for submission |

---

## 🔨 Compilation Requirements

### Prerequisites

LaTeX distribution:
- **Linux**: `sudo apt-get install texlive-full`
- **macOS**: `brew install --cask mactex`
- **Windows**: MiKTeX or TeX Live

---

## 📖 Citation

See [`../CITATION.bib`](../CITATION.bib) for complete BibTeX entry.

---

## 📞 Contact

For questions about the paper:
- GitHub Issues: [Open an issue](https://github.com/DeepBridge-Validation/15_Knowledge_Distillation_Economics/issues)
- Email: [Contact information]

---

## 🔗 Related Resources

- **Code**: [`../experiments/`](../experiments/) - Reproducible experiments
- **Documentation**: [`../docs/`](../docs/) - Technical details
- **Main README**: [`../README.md`](../README.md) - Repository overview

---

**Last updated**: 2025-12-10
**Maintained by**: Knowledge Distillation Economics Team
