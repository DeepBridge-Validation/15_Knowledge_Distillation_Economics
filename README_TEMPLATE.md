# Knowledge Distillation for Economics

[![Paper](https://img.shields.io/badge/Paper-PDF-red?style=flat-square)]()
[![arXiv](https://img.shields.io/badge/arXiv-2501.XXXXX-b31b1b?style=flat-square)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE)
[![Python 3.9+](https://img.shields.io/badge/python-3.9+-blue.svg?style=flat-square)](https://www.python.org/downloads/)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg?style=flat-square)](https://github.com/psf/black)

> **Trading Complexity for Interpretability in Econometric Models**

Official implementation and reproducibility package for:

**"Knowledge Distillation for Economics: Trading Complexity for Interpretability in Econometric Models"**

*Submitted to Journal of Econometrics (2025)*

**Authors**: [Your Name], [Co-author Names]

---

## 📋 Table of Contents

- [Overview](#overview)
- [Key Results](#key-results)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Repository Structure](#repository-structure)
- [Reproducing Paper Results](#reproducing-paper-results)
- [Documentation](#documentation)
- [Citation](#citation)
- [License](#license)

---

## 🎯 Overview

This repository contains the complete implementation of our **Economic Knowledge Distillation** framework, which addresses a fundamental challenge in econometrics: how to leverage the predictive power of complex machine learning models while maintaining the interpretability and theoretical consistency required for economic analysis.

### The Problem

Modern machine learning models (XGBoost, Neural Networks) achieve high predictive accuracy but lack interpretability. Traditional econometric models (Linear Regression, GAMs) are interpretable but sacrifice accuracy.

### Our Solution

A **knowledge distillation framework** that:
- ✅ Transfers knowledge from complex "teacher" models to interpretable "student" models
- ✅ Preserves economic constraints (sign restrictions, monotonicity, magnitude bounds)
- ✅ Ensures coefficient stability for statistical inference
- ✅ Detects structural breaks in economic relationships

### Framework Architecture

```
┌─────────────────┐
│  Complex Teacher │  (XGBoost, Neural Net)
│   (High Accuracy)│
└────────┬─────────┘
         │ Distill Knowledge
         │ + Economic Constraints
         ▼
┌─────────────────┐
│ Interpretable    │  (GAM, Linear Regression)
│ Student Model    │
│ (Economically    │
│  Consistent)     │
└─────────────────┘
```

---

## 🏆 Key Results

Our framework achieves remarkable performance across three economic domains:

| Domain | Dataset | Accuracy Loss | Economic Compliance | Coefficient Stability (CV) |
|--------|---------|---------------|---------------------|----------------------------|
| **Credit Risk** | German Credit (1K samples) | -2.1% | 96% | 0.116 |
| **Labor Economics** | Adult Income (48K samples) | -2.2% | 96% | 0.124 |
| **Health Economics** | [Synthetic] (95K samples) | -3.2% | 93% | 0.128 |

**Key Findings**:
- 📊 **2-5% accuracy loss** vs. complex teachers (acceptable trade-off)
- ✅ **95%+ constraint compliance** (economic theory preserved)
- 📈 **CV < 0.15** across all coefficients (stable inference)
- 🎯 **+8-12% improvement** vs. traditional econometric models

---

## 🚀 Installation

### Prerequisites

- Python 3.9 or higher
- pip or conda package manager
- 8GB RAM (16GB recommended for large experiments)
- ~2GB disk space for data and results

### Option 1: Using pip (Recommended)

```bash
# Clone repository
git clone https://github.com/yourusername/knowledge-distillation-economics.git
cd knowledge-distillation-economics

# Create virtual environment
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### Option 2: Using conda

```bash
# Clone repository
git clone https://github.com/yourusername/knowledge-distillation-economics.git
cd knowledge-distillation-economics

# Create conda environment
conda env create -f environment.yml
conda activate econ-distillation
```

### Option 3: Using Docker

```bash
# Pull Docker image
docker pull yourusername/econ-distillation:latest

# Run container
docker run -it -v $(pwd):/workspace yourusername/econ-distillation:latest
```

### Verify Installation

```bash
python scripts/check_dependencies.py
```

---

## ⚡ Quick Start

### Run All Experiments (5-10 minutes)

```bash
# Download datasets and run all experiments
./scripts/reproduce_all_results.sh
```

This will:
1. Download all required datasets (German Credit, Adult Income)
2. Run all experiments with fixed random seeds
3. Generate paper tables and figures
4. Validate results against expected baselines
5. Save outputs to `results/`

### Run Individual Experiments

#### Experiment 1: Credit Risk (German Credit Dataset)

```bash
cd experiments/01_german_credit
python run_experiment.py
```

#### Experiment 2: Labor Economics (Adult Income Dataset)

```bash
cd experiments/02_adult_income
python run_experiment.py
```

### Generate Paper Artifacts

```bash
# Generate all LaTeX tables and figures for the paper
python experiments/generate_paper_artifacts.py

# Outputs saved to:
# - paper/tables/generated_tables.tex
# - paper/figures/*.pdf
```

---

## 📁 Repository Structure

```
knowledge-distillation-economics/
│
├── paper/                          # LaTeX source of the paper
│   ├── main.tex                   # Main paper file
│   ├── main.pdf                   # Compiled PDF
│   └── sections/                  # Paper sections
│
├── experiments/                   # Empirical experiments
│   ├── 01_german_credit/         # Credit risk experiment
│   ├── 02_adult_income/          # Labor economics experiment
│   ├── shared/                   # Shared code modules
│   └── run_all_experiments.sh    # Run all experiments
│
├── results/                       # Pre-computed results
│   ├── baseline_results.json     # Expected results for validation
│   └── figures/                  # Generated figures
│
├── docs/                          # Documentation
│   ├── REPRODUCIBILITY.md        # Detailed reproduction guide
│   ├── DATASETS.md               # Dataset descriptions
│   ├── METHODOLOGY.md            # Methodological details
│   └── FAQ.md                    # Frequently asked questions
│
├── scripts/                       # Utility scripts
│   ├── setup_environment.sh      # Environment setup
│   ├── download_all_data.sh      # Download datasets
│   └── reproduce_all_results.sh  # Full reproduction pipeline
│
├── notebooks/                     # Jupyter notebooks (exploratory)
│
├── requirements.txt               # Python dependencies
├── environment.yml                # Conda environment
├── CITATION.bib                   # How to cite this work
└── LICENSE                        # MIT License
```

---

## 🔬 Reproducing Paper Results

### Full Reproduction (Recommended)

Run the complete reproduction pipeline:

```bash
./scripts/reproduce_all_results.sh
```

**Expected output**:
- All paper tables in `paper/tables/`
- All paper figures in `paper/figures/`
- Result JSONs in `results/`
- Validation report confirming results match paper

**Time**: ~5-10 minutes on modern hardware
**Resources**: 8GB RAM, 2 CPU cores

### Step-by-Step Reproduction

For detailed control, follow these steps:

#### Step 1: Setup Environment

```bash
./scripts/setup_environment.sh
```

#### Step 2: Download Datasets

```bash
./scripts/download_all_data.sh
```

This downloads:
- German Credit Dataset (UCI ML Repository)
- Adult Income Dataset (US Census)

#### Step 3: Run Experiments

```bash
cd experiments
./run_all_experiments.sh
```

#### Step 4: Generate Paper Artifacts

```bash
python experiments/generate_paper_artifacts.py
```

#### Step 5: Validate Results

```bash
python scripts/compare_results.py
```

### Expected Results

Our experiments are designed for reproducibility with fixed random seeds (`RANDOM_STATE=42`). Expected results:

| Experiment | Metric | Expected Range | Paper Value |
|------------|--------|----------------|-------------|
| German Credit | AUC-ROC | 0.825 - 0.835 | 0.829 |
| German Credit | Compliance | 94% - 98% | 96% |
| Adult Income | AUC-ROC | 0.778 - 0.788 | 0.783 |
| Adult Income | Compliance | 94% - 98% | 96% |

**Note**: Small variations (±1-2%) are expected due to:
- Floating-point precision differences across platforms
- Random sampling in bootstrap procedures
- Minor version differences in dependencies

See [docs/REPRODUCIBILITY.md](docs/REPRODUCIBILITY.md) for troubleshooting.

---

## 📚 Documentation

Comprehensive documentation is available in the `docs/` directory:

- **[Reproducibility Guide](docs/REPRODUCIBILITY.md)**: Step-by-step instructions for reproducing all results
- **[Dataset Documentation](docs/DATASETS.md)**: Detailed descriptions of all datasets used
- **[Methodology](docs/METHODOLOGY.md)**: Additional methodological details
- **[FAQ](docs/FAQ.md)**: Answers to common questions
- **[Troubleshooting](docs/TROUBLESHOOTING.md)**: Solutions to common issues

### Experiment Documentation

Each experiment has its own README with specific details:
- [Experiment 1: Credit Risk](experiments/01_german_credit/README.md)
- [Experiment 2: Labor Economics](experiments/02_adult_income/README.md)

---

## 🎓 Citation

If you use this code or our framework in your research, please cite:

```bibtex
@article{yourname2025knowledge,
  title={Knowledge Distillation for Economics: Trading Complexity for Interpretability in Econometric Models},
  author={Your Name and Co-author Names},
  journal={Journal of Econometrics},
  year={2025},
  note={Under review}
}
```

### BibTeX File

A complete BibTeX entry is available in [CITATION.bib](CITATION.bib).

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Summary**:
- ✅ Free to use for research and commercial purposes
- ✅ Modification and redistribution allowed
- ✅ Must include original license and copyright notice

---

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Ways to contribute**:
- Report bugs or issues
- Suggest new features or improvements
- Improve documentation
- Add new experiments or datasets
- Fix typos or improve code quality

---

## 📧 Contact

For questions, feedback, or collaboration opportunities:

- **Issues**: [GitHub Issues](https://github.com/yourusername/knowledge-distillation-economics/issues)
- **Email**: your.email@institution.edu
- **Twitter**: [@yourusername](https://twitter.com/yourusername)

---

## 🙏 Acknowledgments

This research was supported by:
- [Funding Agency]
- [Institution Name]

We thank:
- The UCI Machine Learning Repository for providing the German Credit dataset
- The US Census Bureau for the Adult Income dataset
- Anonymous reviewers for their valuable feedback

---

## 📊 Project Status

- **Paper Status**: Under review at Journal of Econometrics
- **Code Status**: Stable, ready for reproduction
- **Documentation**: Complete
- **Tests**: Passing
- **Maintenance**: Actively maintained

---

## 🗓️ Version History

- **v1.0.0** (2025-01-XX): Initial release with paper submission
  - Complete implementation of Economic KD framework
  - Two real-world experiments (German Credit, Adult Income)
  - Full reproducibility package
  - Comprehensive documentation

---

## 📖 Related Work

This work builds upon and relates to:

- **Knowledge Distillation**: [Hinton et al., 2015](https://arxiv.org/abs/1503.02531)
- **ML for Economics**: [Mullainathan & Spiess, 2017](https://pubs.aeaweb.org/doi/pdfplus/10.1257/jep.31.2.87)
- **Interpretable ML**: [Rudin, 2019](https://www.nature.com/articles/s42256-019-0048-x)
- **Econometric Methods**: [Angrist & Pischke, 2009](https://press.princeton.edu/books/paperback/9780691120355/mostly-harmless-econometrics)

---

## 🌟 Star History

If you find this project useful, please consider giving it a star ⭐

[![Star History Chart](https://api.star-history.com/svg?repos=yourusername/knowledge-distillation-economics&type=Date)](https://star-history.com/#yourusername/knowledge-distillation-economics&Date)

---

**Built with**: Python, scikit-learn, NumPy, SciPy, pandas, matplotlib

**Tested on**: Ubuntu 22.04, macOS 13.0, Windows 11

**Last Updated**: 2025-12-10
