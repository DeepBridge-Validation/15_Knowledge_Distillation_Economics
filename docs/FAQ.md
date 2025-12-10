# Frequently Asked Questions (FAQ)

**Knowledge Distillation for Economics**

Quick answers to common questions about our framework and repository.

---

## General Questions

### What is knowledge distillation?

Knowledge distillation is a technique where a complex "teacher" model (like XGBoost) transfers its knowledge to a simpler "student" model (like Logistic Regression). The student learns to mimic the teacher's predictions while remaining interpretable.

### What's different about "economic" knowledge distillation?

We extend traditional KD to preserve:
1. **Economic constraints** (sign restrictions, monotonicity)
2. **Coefficient stability** (for statistical inference)
3. **Structural break detection** (time-varying relationships)

Traditional KD only focuses on accuracy.

### Why should economists care about this?

Because you can now:
- ✅ Get ML-level accuracy (~97% retention)
- ✅ Keep full interpretability (coefficients, p-values)
- ✅ Satisfy economic theory (constraints preserved)
- ✅ Use for inference (stable coefficients)

### Is this better than SHAP/LIME?

**Different purpose**:
- SHAP/LIME: Post-hoc explanations of black-box models
- Our approach: Intrinsically interpretable models with ML accuracy

**Advantages of our approach**:
- ✅ Coefficients are stable (good for inference)
- ✅ Economic constraints built-in
- ✅ True interpretability (not approximations)

**When to use SHAP/LIME**:
- When you must use a black-box model (e.g., regulatory requirement)
- For local explanations of individual predictions

---

## Installation & Setup

### What operating systems are supported?

Tested on:
- ✅ Ubuntu 20.04+ (Linux)
- ✅ macOS 12.0+
- ✅ Windows 10+ (via Git Bash or WSL)

### What Python version do I need?

**Python 3.9 or higher** required. Tested on:
- Python 3.9
- Python 3.10
- Python 3.11

Python 3.12+ should work but is not extensively tested.

### I'm getting "openml not found" error

Install openml:
```bash
pip install openml
```

Or reinstall all dependencies:
```bash
pip install -r requirements.txt
```

### Can I use conda instead of pip?

Yes! Create environment:
```bash
conda env create -f environment.yml
conda activate econ-distillation
```

### Do I need GPU?

**No**. All experiments run on CPU in reasonable time (~5-10 minutes total).

GPU support: Not needed, but won't hurt if you have one.

---

## Running Experiments

### How long do experiments take?

**Total time**: 5-10 minutes on modern hardware (CPU)

Individual experiments:
- German Credit: ~2-3 minutes
- Adult Income: ~3-5 minutes

### How much RAM do I need?

**Minimum**: 4GB
**Recommended**: 8GB

If you have less RAM, reduce `n_bootstrap` in experiment scripts.

### Can I run experiments in parallel?

Yes, experiments are independent:
```bash
# Terminal 1
python experiments/01_german_credit_experiment.py

# Terminal 2 (simultaneously)
python experiments/02_adult_income_experiment.py
```

### How do I run just one experiment?

```bash
cd experiments
python 01_german_credit_experiment.py
```

### Where are results saved?

- **JSON results**: `experiments/results/*.json`
- **Models**: `experiments/results/*.pkl`
- **Logs**: `experiments/logs/*.log`
- **Figures**: `experiments/figures/`

### My results are slightly different from the paper. Is this a problem?

**Small differences (±2-3%) are expected** due to:
- Random sampling in bootstrap
- Platform-specific floating-point differences
- Library version differences

**Results are valid** if within acceptable ranges (see [REPRODUCIBILITY.md](REPRODUCIBILITY.md#validating-results)).

---

## Methodology Questions

### What student models can I use?

Currently implemented:
- Logistic Regression (linear)
- GAM (Generalized Additive Models) - in progress

**Criteria for student models**:
- Interpretable coefficients
- Support for constraints
- Stable estimation

### What teacher models can I use?

Any scikit-learn compatible classifier:
- ✅ XGBoost (recommended)
- ✅ LightGBM
- ✅ Random Forest
- ✅ Neural Networks
- ❌ Not: Deep RL, graph networks (overkill for tabular data)

### Can I use this for regression (continuous targets)?

**Current implementation**: Classification only

**Extending to regression**: Requires:
- Different loss functions (MSE instead of cross-entropy)
- Adapt economic constraints for continuous targets
- Bootstrap for coefficient stability (same process)

### How do I add my own economic constraints?

Edit the experiment script:
```python
# Example: Add sign constraint
constraints = {
    'income': {'type': 'sign', 'value': -1, 'justification': 'Higher income → Lower risk'}
}

# Example: Add monotonicity
constraints = {
    'education': {'type': 'monotonic', 'direction': 'increasing'}
}
```

See [METHODOLOGY.md](METHODOLOGY.md#economic-constraints) for details.

### What if my dataset doesn't have clear economic constraints?

Options:
1. **Consult domain experts** to define constraints
2. **Use standard KD** without constraints (set β=0)
3. **Learn constraints from data** (future work)

### How many bootstrap samples do I need?

**Default**: 500

**Minimum for stability**: 100
**Recommended**: 500-1000
**Diminishing returns**: Beyond 1000

Trade-off: More samples = better CI, but slower.

---

## Dataset Questions

### Can I use my own dataset?

**Yes!** Follow this structure:
1. Create `experiments/03_your_dataset/`
2. Add data loading in `run_experiment.py`
3. Define economic constraints
4. Update documentation

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.

### What dataset size do I need?

**Minimum**: ~500 samples
**Recommended**: 1000+ samples
**Ideal**: 5000+ samples

Smaller datasets may have:
- Unstable coefficients
- Wide confidence intervals
- Overfitting risk

### Do I need time-series data?

**No**. Cross-sectional data works fine.

**Time-series**: Optional, only needed for structural break detection.

### How do I handle missing values?

Options:
1. **Remove**: Drop rows with missing values (if < 10% missing)
2. **Impute**: Mean/median for numerical, mode for categorical
3. **Model**: Use models that handle missing (XGBoost teacher)

Our experiments: Remove missing (German Credit has none, Adult has ~7%).

### Can I use this for time-series forecasting?

**Current**: Not designed for time-series forecasting

**Possible adaptation**:
- Use lags as features
- Validate with time-aware splits
- Adapt constraints for temporal relationships

---

## Results & Interpretation

### What metrics should I report?

**Accuracy**:
- AUC-ROC (primary)
- Accuracy, F1-score
- Accuracy loss vs. teacher

**Economic validity**:
- Constraint compliance rate
- Sign stability

**Inference quality**:
- Coefficient of variation (CV)
- 95% confidence intervals
- Sign stability percentage

### How do I interpret constraint compliance?

**Compliance rate**: % of constraints satisfied

- **≥95%**: Excellent (economic theory preserved)
- **85-95%**: Good (mostly consistent)
- **70-85%**: Acceptable (some violations)
- **<70%**: Poor (theory not preserved)

### What's a good CV (coefficient of variation)?

**CV = std / |mean|** for each coefficient:

- **< 0.15**: **Stable** (safe for inference) ✅
- **0.15-0.30**: Moderately stable (use with caution)
- **> 0.30**: Unstable (avoid inference) ❌

### Can I use the student model for causal inference?

**Caution**: Knowledge distillation is a **predictive** technique.

For causal inference:
- ✅ Use as exploratory analysis
- ✅ Check constraint compliance
- ❌ Do NOT make strong causal claims without:
  - Proper identification strategy
  - Controlling for confounders
  - Robustness checks

See [METHODOLOGY.md](METHODOLOGY.md) for discussion.

---

## Troubleshooting

### Experiment fails with "MemoryError"

**Solution 1**: Reduce `n_bootstrap`:
```python
# In experiment script, change:
n_bootstrap = 500  # to
n_bootstrap = 100
```

**Solution 2**: Close other applications

**Solution 3**: Use machine with more RAM

### "openml.exceptions.OpenMLServerException"

**Cause**: OpenML server temporarily unavailable

**Solution**: Experiments automatically use fallback synthetic data

**Manual retry**:
```bash
# Wait a few minutes, then retry
python experiments/01_german_credit_experiment.py
```

### Results are way off (>10% difference)

**Check**:
1. Python version: `python --version`
2. Library versions: `pip freeze`
3. Random seed: Should be `RANDOM_STATE=42`
4. Data loading: Verify correct dataset loaded

**Debug**:
```bash
# Verbose output
python experiments/01_german_credit_experiment.py 2>&1 | tee debug.log
```

See [REPRODUCIBILITY.md](REPRODUCIBILITY.md#troubleshooting) for more.

### Code runs but no results saved

**Check**:
- Results directory exists: `ls experiments/results/`
- Permissions: `chmod +w experiments/results/`
- Disk space: `df -h`

**Create directory**:
```bash
mkdir -p experiments/results experiments/logs experiments/figures
```

---

## Paper & Citation

### How do I cite this work?

See [CITATION.bib](../CITATION.bib) for BibTeX entry:

```bibtex
@article{knowledge_distillation_economics_2025,
  title={Knowledge Distillation for Economics: ...},
  author={[Authors]},
  journal={Journal of Econometrics},
  year={2025}
}
```

### What journals/conferences is this suitable for?

**Target venues**:
- Journal of Econometrics (primary)
- NeurIPS Economics & Computation Track
- ICML
- AAAI (AI for Social Impact)

**Economics journals**:
- American Economic Review
- Review of Economic Studies

**ML conferences**:
- NeurIPS, ICML, ICLR (with economics application)

### Can I use this for my research?

**Yes!** This is open-source (MIT License).

You can:
- ✅ Use the code
- ✅ Modify for your needs
- ✅ Publish using this framework

**Please**:
- ✅ Cite our paper
- ✅ Acknowledge the framework
- ✅ Share your adaptations (optional but appreciated)

---

## Contributing

### How can I contribute?

See [CONTRIBUTING.md](../CONTRIBUTING.md) for details.

Quick ways:
1. **Report bugs**: Open an issue
2. **Improve docs**: Fix typos, add clarifications
3. **Add datasets**: Contribute new economic datasets
4. **Code improvements**: Bug fixes, optimizations

### I found a bug. What should I do?

1. **Search existing issues**: May already be reported
2. **Try to reproduce**: Minimal example
3. **Open an issue**: Use bug report template
4. **Include**: OS, Python version, error message, reproduction steps

### I have an idea for a new feature

Great! Please:
1. **Open an issue** with tag `enhancement`
2. **Describe use case**: Why is this useful?
3. **Discuss approach**: How might it work?
4. **Wait for feedback**: before implementing

---

## License

### What license is this under?

**MIT License** - very permissive.

You can:
- ✅ Use commercially
- ✅ Modify
- ✅ Distribute
- ✅ Use privately

You must:
- ✅ Include original license
- ✅ Include copyright notice

You cannot:
- ❌ Hold authors liable

See [LICENSE](../LICENSE) for full text.

---

## Still Have Questions?

- **Check docs**: [Documentation directory](.)
- **Search issues**: [GitHub Issues](https://github.com/DeepBridge-Validation/15_Knowledge_Distillation_Economics/issues)
- **Ask a question**: [Open new issue](https://github.com/DeepBridge-Validation/15_Knowledge_Distillation_Economics/issues/new) with tag `question`

---

**Last updated**: 2025-12-10
**Maintained by**: Knowledge Distillation Economics Team
