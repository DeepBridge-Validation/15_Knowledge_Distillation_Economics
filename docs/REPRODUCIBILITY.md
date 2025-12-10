# Reproducibility Guide

**Knowledge Distillation for Economics**

This document provides detailed step-by-step instructions for reproducing all results from the paper "Knowledge Distillation for Economics: Trading Complexity for Interpretability in Econometric Models".

---

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Quick Start](#quick-start)
3. [Detailed Setup Instructions](#detailed-setup-instructions)
4. [Running Experiments](#running-experiments)
5. [Validating Results](#validating-results)
6. [Troubleshooting](#troubleshooting)
7. [Platform-Specific Notes](#platform-specific-notes)

---

## System Requirements

### Minimum Requirements

- **Operating System**: Linux, macOS, or Windows 10+
- **Python**: 3.9 or higher
- **RAM**: 4GB (8GB recommended)
- **Storage**: ~500MB free space
- **CPU**: 2 cores minimum
- **Internet**: Required for downloading datasets

### Recommended Configuration

- **Python**: 3.9 or 3.10
- **RAM**: 8GB or more
- **CPU**: 4+ cores (for faster execution)
- **Storage**: 1GB free space

### Tested Platforms

This code has been tested on:
- Ubuntu 22.04 LTS (Python 3.9, 3.10)
- macOS 13.0+ (Python 3.9, 3.10)
- Windows 11 (Python 3.9, 3.10)

---

## Quick Start

For users familiar with Python and command line:

```bash
# 1. Clone repository
git clone https://github.com/DeepBridge-Validation/15_Knowledge_Distillation_Economics.git
cd 15_Knowledge_Distillation_Economics

# 2. Create virtual environment
python3 -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 3. Install dependencies
pip install -r requirements.txt

# 4. Verify installation
python scripts/check_dependencies.py

# 5. Run all experiments
./scripts/reproduce_all_results.sh
```

**Expected time**: 10-15 minutes total (including setup)

---

## Detailed Setup Instructions

### Step 1: Clone the Repository

```bash
git clone https://github.com/DeepBridge-Validation/15_Knowledge_Distillation_Economics.git
cd 15_Knowledge_Distillation_Economics
```

Or download and extract the ZIP file from GitHub.

### Step 2: Check Python Version

```bash
python3 --version
```

Should output: `Python 3.9.X` or higher

**If Python < 3.9**:
- Download from: https://www.python.org/downloads/
- Or use conda: `conda install python=3.9`

### Step 3: Create Virtual Environment (Recommended)

**Why?** Isolates project dependencies from system Python.

#### Option A: Using venv (built-in)

```bash
# Create virtual environment
python3 -m venv venv

# Activate (Linux/macOS)
source venv/bin/activate

# Activate (Windows)
venv\Scripts\activate

# Verify activation (should show venv path)
which python  # Linux/macOS
where python  # Windows
```

#### Option B: Using conda

```bash
# Create conda environment
conda create -n econ-distillation python=3.9

# Activate
conda activate econ-distillation
```

### Step 4: Install Dependencies

```bash
# Ensure you're in project root and virtual environment is active
pip install --upgrade pip
pip install -r requirements.txt
```

**Expected time**: 2-3 minutes

**Common issues**:
- If `pip` is slow, try: `pip install --use-deprecated=legacy-resolver -r requirements.txt`
- If specific package fails, install individually: `pip install package-name`

### Step 5: Verify Installation

```bash
python scripts/check_dependencies.py
```

**Expected output**:
```
================================================================================
Knowledge Distillation for Economics - Dependency Check
================================================================================

Python Version:
✅ Python 3.9.X (>= 3.9.0)

Required Dependencies:
✅ numpy: X.X.X (>= 1.21.0)
✅ pandas: X.X.X (>= 1.3.0)
✅ scipy: X.X.X (>= 1.7.0)
✅ scikit-learn: X.X.X (>= 1.0.0)
✅ xgboost: X.X.X (>= 1.5.0)
✅ statsmodels: X.X.X (>= 0.13.0)
✅ matplotlib: X.X.X (>= 3.4.0)
✅ seaborn: X.X.X (>= 0.11.0)
✅ openml: X.X.X (>= 0.12.0)
...

================================================================================
✅ ALL DEPENDENCIES OK
================================================================================
```

**If any dependency fails**:
- Install missing package: `pip install package-name`
- Check [Troubleshooting](#troubleshooting) section

---

## Running Experiments

### Full Reproduction (Recommended)

Run all experiments and generate all results:

```bash
./scripts/reproduce_all_results.sh
```

**What this does**:
1. Checks all dependencies
2. Creates necessary directories
3. Downloads datasets automatically (German Credit, Adult Income)
4. Runs both experiments with fixed random seeds
5. Generates LaTeX tables for paper
6. Saves results to `experiments/results/`

**Expected time**: 5-10 minutes

**Expected output**:
```
==========================================================================
FULL REPRODUCTION PIPELINE - Knowledge Distillation for Economics
==========================================================================

Step 1/5: Checking Dependencies
✅ All dependencies are installed

Step 2/5: Preparing Directories
✅ Directories ready

Step 3/5: Running Experiments
Running all experiments via run_all_experiments.sh...
✅ All experiments completed

Step 4/5: Generating Paper Tables and Figures
✅ LaTeX tables generated

Step 5/5: Validating Results
✅ Results validated

==========================================================================
REPRODUCTION COMPLETE!
==========================================================================
```

### Running Individual Experiments

#### Experiment 1: German Credit (Credit Risk)

```bash
cd experiments
python3 01_german_credit_experiment.py
```

**Expected output**:
- Console output with progress bars
- Results saved to: `results/german_credit_results.json`
- Models saved to: `results/german_credit_models.pkl`
- Execution time: ~2-3 minutes

#### Experiment 2: Adult Income (Labor Economics)

```bash
cd experiments
python3 02_adult_income_experiment.py
```

**Expected output**:
- Results saved to: `results/adult_income_results.json`
- Models saved to: `results/adult_income_models.pkl`
- Execution time: ~3-5 minutes

### Generating Paper Artifacts

After running experiments:

```bash
cd experiments
python3 generate_latex_tables.py
```

**Outputs**:
- LaTeX tables ready to include in paper
- Saved to paper directory

---

## Validating Results

### Expected Results

Our experiments use **fixed random seeds** (`RANDOM_STATE=42`) for reproducibility.

#### Experiment 1: German Credit Dataset

| Metric | Expected Value | Acceptable Range | Your Result |
|--------|---------------|------------------|-------------|
| Teacher AUC | ~0.85 | 0.82 - 0.88 | _______ |
| Student AUC | ~0.83 | 0.80 - 0.85 | _______ |
| Accuracy Loss | ~2-3% | 1-5% | _______ |
| Compliance Rate | ~90% | 85-95% | _______ |
| CV (Stability) | ~0.12 | 0.10 - 0.15 | _______ |

#### Experiment 2: Adult Income Dataset

| Metric | Expected Value | Acceptable Range | Your Result |
|--------|---------------|------------------|-------------|
| Teacher AUC | ~0.82 | 0.79 - 0.85 | _______ |
| Student AUC | ~0.80 | 0.77 - 0.82 | _______ |
| Accuracy Loss | ~2-3% | 1-5% | _______ |
| Compliance Rate | ~93% | 90-96% | _______ |
| CV (Stability) | ~0.12 | 0.10 - 0.15 | _______ |

### Why Results May Vary Slightly

Small variations (±2-3%) are **expected and normal** due to:

1. **Stochastic algorithms**: ML models have inherent randomness
2. **Bootstrap sampling**: Random sampling in stability analysis
3. **Floating-point arithmetic**: Platform-specific differences
4. **Library versions**: Minor differences in sklearn/xgboost versions
5. **Hardware differences**: CPU architecture, threading

### When to Be Concerned

Results are **problematic** if:
- AUC differs by > 0.05 (5 percentage points)
- Compliance differs by > 10%
- CV differs by > 0.08
- Any metric is outside acceptable range

→ See [Troubleshooting](#troubleshooting)

### Checking Your Results

```bash
# View results
cat experiments/results/german_credit_results.json
cat experiments/results/adult_income_results.json

# Or use Python
python3 -c "import json; print(json.dumps(json.load(open('experiments/results/german_credit_results.json')), indent=2))"
```

---

## Troubleshooting

### Problem: "openml not found" or import errors

**Cause**: Missing dependency

**Solution**:
```bash
pip install openml
# Or reinstall all dependencies
pip install -r requirements.txt
```

### Problem: "Memory Error" during experiments

**Cause**: Insufficient RAM (especially during bootstrap)

**Solutions**:
1. **Reduce bootstrap samples**: Edit experiment scripts
   - Change `n_bootstrap=500` to `n_bootstrap=100`
2. **Close other applications** to free RAM
3. **Use machine with more RAM** (8GB+ recommended)

### Problem: Results significantly different from paper

**Possible causes**:
1. **Wrong Python/library versions**
   - Check: `python scripts/check_dependencies.py`
2. **Random seed not set properly**
   - Verify: `RANDOM_STATE=42` in experiment scripts
3. **Modified code**
   - Re-clone repository to get original code

**Debugging steps**:
```bash
# Check Python version
python3 --version

# Check library versions
pip freeze | grep -E "numpy|pandas|scikit-learn|xgboost"

# Re-run with verbose output
python3 experiments/01_german_credit_experiment.py 2>&1 | tee debug.log
```

### Problem: Datasets don't download automatically

**Cause**: OpenML service temporarily unavailable or network issues

**Solution**:
1. **Check internet connection**
2. **Retry later** (OpenML may be down temporarily)
3. **Use fallback**: Experiments automatically use synthetic data if OpenML fails

**Manual download** (if needed):
```python
from sklearn.datasets import fetch_openml
data = fetch_openml('credit-g', version=1, as_frame=True)
```

### Problem: "Permission denied" when running scripts

**Cause**: Script not executable

**Solution**:
```bash
chmod +x scripts/reproduce_all_results.sh
chmod +x experiments/run_all_experiments.sh
```

### Problem: Script fails on Windows

**Cause**: Bash scripts don't run natively on Windows

**Solutions**:
1. **Use Git Bash** (comes with Git for Windows)
2. **Use WSL** (Windows Subsystem for Linux)
3. **Run Python scripts directly**:
   ```bash
   python experiments/01_german_credit_experiment.py
   python experiments/02_adult_income_experiment.py
   ```

---

## Platform-Specific Notes

### Linux

Should work out-of-the-box. Tested on Ubuntu 22.04.

### macOS

**Notes**:
- XGBoost may require additional setup on M1/M2 chips
- If OpenMP issues: `brew install libomp`

### Windows

**Recommendations**:
1. **Use Git Bash** for running shell scripts
2. **Or use WSL** for full Linux compatibility
3. **Activate venv**: Use `venv\Scripts\activate` instead of `source venv/bin/activate`

**Path separators**:
- Use forward slashes `/` in Python code
- Use backslashes `\` in Windows command prompt

---

## Additional Resources

### Documentation

- **Main README**: [`../README.md`](../README.md)
- **Experiment README**: [`../experiments/README.md`](../experiments/README.md)
- **Paper**: [`../POR/main.pdf`](../POR/main.pdf)

### Getting Help

1. **Check this guide** first
2. **Review experiment logs**: `experiments/logs/*.log`
3. **Open an issue**: GitHub Issues (with error logs)

### Reporting Issues

When reporting reproduction issues, please include:
- Operating system and version
- Python version (`python --version`)
- Output of `pip freeze`
- Complete error message
- Output of `python scripts/check_dependencies.py`

---

## Reproducibility Checklist

Use this checklist to verify successful reproduction:

- [ ] Python 3.9+ installed and verified
- [ ] Virtual environment created and activated
- [ ] All dependencies installed (`check_dependencies.py` passes)
- [ ] Experiment 1 (German Credit) runs successfully
- [ ] Experiment 2 (Adult Income) runs successfully
- [ ] Results are within acceptable ranges
- [ ] LaTeX tables generated
- [ ] No errors in log files

**If all checked**: ✅ **Reproduction successful!**

---

## Citation

If you successfully reproduced our results, please cite:

```bibtex
@article{knowledge_distillation_economics_2025,
  title={Knowledge Distillation for Economics: Trading Complexity for
         Interpretability in Econometric Models},
  author={[Authors]},
  journal={Journal of Econometrics},
  year={2025}
}
```

---

**Document version**: 1.0
**Last updated**: 2025-12-10
**Maintained by**: Knowledge Distillation Economics Team
