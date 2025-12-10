# Knowledge Distillation for Economics

[![Paper](https://img.shields.io/badge/Paper-PDF-red?style=flat-square)](POR/main.pdf)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE)
[![Python 3.9+](https://img.shields.io/badge/python-3.9+-blue.svg?style=flat-square)](https://www.python.org/downloads/)

> **Trading Complexity for Interpretability in Econometric Models**

Official implementation and reproducibility package for:

**"Knowledge Distillation for Economics: Trading Complexity for Interpretability in Econometric Models"**

*Target Venues: Journal of Econometrics, NeurIPS Economics & Computation Track (2025)*

---

## Table of Contents

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

## Overview

This repository contains the complete implementation of our **Economic Knowledge Distillation** framework, which addresses a fundamental challenge in econometrics: how to leverage the predictive power of complex machine learning models while maintaining the interpretability and theoretical consistency required for economic analysis.

### The Problem

Modern machine learning models (XGBoost, Neural Networks) achieve high predictive accuracy but lack interpretability. Traditional econometric models (Linear Regression, GAMs) are interpretable but sacrifice accuracy. **Economic research requires both.**

### Our Solution

A **knowledge distillation framework** that:
- Transfers knowledge from complex "teacher" models to interpretable "student" models
- Preserves economic constraints (sign restrictions, monotonicity, magnitude bounds)
- Ensures coefficient stability for statistical inference (bootstrap validation)
- Detects structural breaks in economic relationships
- Achieves 97%+ accuracy retention with full interpretability

### Framework Architecture

```
┌──────────────────────┐
│   Complex Teacher    │  XGBoost / Neural Network
│   (High Accuracy)    │  AUC: 0.85+
└──────────┬───────────┘
           │
           │ Knowledge Distillation
           │ + Economic Constraints
           │ + Stability Analysis
           ▼
┌──────────────────────┐
│ Interpretable Student│  Logistic Regression / GAM
│ (Economically Valid) │  AUC: 0.83+ (97%+ retention)
│ + Coefficient CI     │  95%+ constraint compliance
│ + Economic Theory    │  CV < 0.15 (stable inference)
└──────────────────────┘
```

---

## Key Results

Our framework achieves remarkable performance across two real-world economic domains:

| Domain | Dataset | Samples | Accuracy Loss | Compliance | Stability (CV) |
|--------|---------|---------|---------------|------------|----------------|
| **Credit Risk** | German Credit (UCI) | 1,000 | ~2-3% | 85-95% | ~0.10-0.15 |
| **Labor Economics** | Adult Income (Census) | 48,842 | ~2-3% | 90-96% | ~0.10-0.15 |

**Key Findings**:
- **Minimal accuracy loss** (~2-5%) vs. complex teacher models
- **High economic compliance** (85-95%+) with theoretical constraints preserved
- **Stable coefficients** (CV < 0.15) suitable for statistical inference
- **Significant improvement** (+8-12% AUC) vs. traditional econometric baselines

---

## Installation

### Prerequisites

- Python 3.9 or higher
- pip package manager
- 4GB RAM minimum (8GB recommended)
- ~500MB disk space for data and results

### Setup Instructions

```bash
# Clone repository
git clone https://github.com/[username]/knowledge-distillation-economics.git
cd knowledge-distillation-economics

# Create virtual environment (recommended)
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Verify installation
python scripts/check_dependencies.py
```

### Alternative: Using conda

```bash
# Create conda environment
conda create -n econ-distillation python=3.9
conda activate econ-distillation

# Install dependencies
pip install -r requirements.txt
```

---

## Quick Start

### Run All Experiments (~5-10 minutes)

```bash
# Run complete reproduction pipeline
./scripts/reproduce_all_results.sh
```

This will:
1. Download required datasets (German Credit, Adult Income) automatically
2. Run all experiments with fixed random seeds (reproducible)
3. Generate paper tables and figures
4. Save outputs to `experiments/results/`

### Run Individual Experiments

#### Experiment 1: Credit Risk (German Credit Dataset)

```bash
cd experiments
python3 01_german_credit_experiment.py
```

**Output**: `results/german_credit_results.json`, models, and plots

#### Experiment 2: Labor Economics (Adult Income Dataset)

```bash
cd experiments
python3 02_adult_income_experiment.py
```

**Output**: `results/adult_income_results.json`, models, and plots

### Generate Paper Tables/Figures

```bash
cd experiments
python3 generate_latex_tables.py
```

**Output**: LaTeX tables ready to include in paper

---

## Repository Structure

```
knowledge-distillation-economics/
│
├── README.md                          # This file
├── LICENSE                            # MIT License
├── CITATION.bib                       # How to cite this work
├── requirements.txt                   # Python dependencies
│
├── POR/                               # Paper LaTeX source (Portuguese)
│   ├── main.tex                      # Main paper file
│   ├── main.pdf                      # Compiled PDF
│   ├── sections/                     # Paper sections
│   └── bibliography/                 # References
│
├── experiments/                       # Empirical experiments
│   ├── README.md                     # Experiment documentation
│   ├── 01_german_credit_experiment.py
│   ├── 02_adult_income_experiment.py
│   ├── generate_latex_tables.py
│   ├── run_all_experiments.sh
│   ├── data/                         # Downloaded datasets (auto-created)
│   ├── results/                      # Experiment outputs
│   ├── figures/                      # Generated visualizations
│   └── logs/                         # Execution logs
│
├── docs/                              # Documentation
│   ├── REPRODUCIBILITY.md            # Detailed reproduction guide
│   └── [more documentation]
│
├── scripts/                           # Utility scripts
│   ├── check_dependencies.py         # Verify installation
│   └── reproduce_all_results.sh      # Full reproduction pipeline
│
├── results/                           # Pre-computed results (optional)
└── notebooks/                         # Jupyter notebooks (exploratory)
```

---

## Reproducing Paper Results

### Full Reproduction (Recommended)

```bash
# One-command full reproduction
./scripts/reproduce_all_results.sh
```

**Expected time**: 5-10 minutes on modern hardware
**Requirements**: 4GB RAM, 2 CPU cores

### Step-by-Step Manual Reproduction

#### Step 1: Verify Environment

```bash
python scripts/check_dependencies.py
```

Should output: `✅ ALL DEPENDENCIES OK`

#### Step 2: Run Experiments

```bash
cd experiments
./run_all_experiments.sh
```

This runs:
- German Credit experiment (~2-3 min)
- Adult Income experiment (~3-5 min)

#### Step 3: Generate Paper Artifacts

```bash
python experiments/generate_latex_tables.py
```

Outputs saved to paper-ready LaTeX tables.

#### Step 4: Review Results

```bash
# Check results
ls -lh experiments/results/
cat experiments/results/german_credit_results.json
```

### Expected Results

Our experiments use fixed random seeds (`RANDOM_STATE=42`) for reproducibility:

| Experiment | Metric | Expected Range | Paper Value |
|------------|--------|----------------|-------------|
| German Credit | AUC-ROC | 0.80 - 0.85 | ~0.83 |
| German Credit | Compliance | 85% - 95% | ~90% |
| Adult Income | AUC-ROC | 0.78 - 0.82 | ~0.80 |
| Adult Income | Compliance | 90% - 96% | ~93% |

**Note**: Small variations (±2-3%) are expected due to:
- Stochastic nature of machine learning algorithms
- Bootstrap sampling procedures
- Platform-specific floating-point differences

See [docs/REPRODUCIBILITY.md](docs/REPRODUCIBILITY.md) for detailed troubleshooting.

---

## Documentation

Comprehensive documentation is available:

- **[Experiment README](experiments/README.md)**: Detailed experiment descriptions
- **[Reproducibility Guide](docs/REPRODUCIBILITY.md)**: Step-by-step reproduction instructions
- **[Paper PDF](POR/main.pdf)**: Full paper with methodology and results

### Key Concepts

**Economic Constraints**:
- **Sign constraints**: Coefficients must have economically justified signs
- **Monotonicity**: Features must have monotonic relationships (e.g., education → income)
- **Magnitude bounds**: Effect sizes must be within reasonable ranges

**Knowledge Distillation**:
- Teacher model: Complex ML model (XGBoost, Neural Net)
- Student model: Interpretable econometric model (Logistic, GAM)
- Soft targets: Probability distributions from teacher guide student training

**Stability Analysis**:
- Bootstrap resampling (500+ iterations)
- Coefficient of Variation (CV) < 0.15 threshold
- Sign stability > 95% across bootstrap samples

---

## Citation

If you use this code or framework in your research, please cite:

```bibtex
@article{knowledge_distillation_economics_2025,
  title={Knowledge Distillation for Economics: Trading Complexity for
         Interpretability in Econometric Models},
  author={[Your Names - Update CITATION.bib]},
  journal={Journal of Econometrics},
  year={2025},
  note={Under review}
}
```

Full BibTeX entry available in [CITATION.bib](CITATION.bib).

---

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file.

**Summary**: Free to use for research and commercial purposes, with attribution.

---

## Contributing

We welcome contributions! Ways to contribute:
- Report bugs or issues
- Suggest improvements or new features
- Improve documentation
- Add new experiments or datasets

Please open an issue first to discuss proposed changes.

---

## Contact

For questions or feedback:
- **Issues**: [GitHub Issues](https://github.com/[username]/knowledge-distillation-economics/issues)
- **Paper**: See [POR/main.pdf](POR/main.pdf) for methodology details

---

## Acknowledgments

This research uses public datasets from:
- **German Credit Data**: UCI Machine Learning Repository
- **Adult Income Data**: US Census Bureau (1994 Census)

We thank the maintainers of these datasets for making them publicly available.

---

## Project Status

- **Paper Status**: In preparation for Journal of Econometrics submission
- **Code Status**: Stable and ready for reproduction
- **Documentation**: Complete
- **Maintenance**: Actively maintained

---

## Version History

- **v1.0.0** (2025-12-10): Initial release
  - Complete implementation of Economic KD framework
  - Two real-world experiments (German Credit, Adult Income)
  - Full reproducibility package
  - Comprehensive documentation

---

**Built with**: Python, scikit-learn, NumPy, SciPy, pandas, matplotlib, seaborn

**Last Updated**: 2025-12-10
