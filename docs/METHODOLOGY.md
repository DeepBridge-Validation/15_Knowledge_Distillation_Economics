# Methodology

**Knowledge Distillation for Economics: Technical Details**

This document provides detailed technical information about the methodology used in our Economic Knowledge Distillation framework.

---

## Table of Contents

- [Overview](#overview)
- [Framework Architecture](#framework-architecture)
- [Economic Constraints](#economic-constraints)
- [Distillation Process](#distillation-process)
- [Stability Analysis](#stability-analysis)
- [Structural Break Detection](#structural-break-detection)
- [Implementation Details](#implementation-details)
- [Hyperparameters](#hyperparameters)

---

## Overview

Our framework extends traditional knowledge distillation to preserve economic constraints and ensure coefficient stability for statistical inference.

### Key Innovation

Traditional KD: Teacher → Student (accuracy focus)

Economic KD: Teacher → Student (accuracy + economic validity + stability)

---

## Framework Architecture

### Components

1. **Teacher Training**: Complex ML model (XGBoost, Neural Network)
2. **Economic Constraint Encoder**: Encode domain knowledge
3. **Constrained Distillation Engine**: Modified loss function
4. **Coefficient Stability Analyzer**: Bootstrap validation
5. **Structural Break Detector**: Time-varying analysis

### Data Flow

```
Input Data (X, y)
    ↓
[Teacher Training]
    ↓
Soft Targets (p̂_teacher)
    ↓
[Economic Constraints] → [Distillation Loss]
    ↓
Student Model (interpretable)
    ↓
[Stability Analysis] → Confidence Intervals
    ↓
Final Model + Validation Metrics
```

---

## Economic Constraints

### Types of Constraints

#### 1. Sign Constraints

**Definition**: Coefficient must have specific sign

**Mathematical Formulation**:
```
β_j · sign(β_j) ≥ 0 for positive constraint
β_j · sign(β_j) ≤ 0 for negative constraint
```

**Example**:
- Income → Default Risk: **Negative** (higher income = lower risk)
- Debt-to-income → Default Risk: **Positive** (higher ratio = higher risk)

**Penalty Term**:
```python
L_sign = Σ max(0, -sign_j · β_j) for j in constrained_features
```

#### 2. Monotonicity Constraints

**Definition**: Feature-target relationship is monotonic

**For GAMs**:
```
f_j(x) is monotonically increasing/decreasing
```

**Implementation**:
- Use monotonic splines (statsmodels, pygam)
- Or penalize non-monotonicity: `L_mono = Σ|f'(x_i)|` where f'(x_i) < 0 for increasing

**Example**:
- Education → Income: **Monotonically increasing**
- Age → Health Risk: **Monotonically increasing** (up to certain age)

#### 3. Magnitude Bounds

**Definition**: Effect size must be within reasonable range

**Formulation**:
```
β_min ≤ β_j ≤ β_max
```

**Example**:
- Interest rate effect on default: [0.5, 2.0] (from economic theory)

**Penalty**:
```python
L_bound = Σ max(0, β_j - β_max) + max(0, β_min - β_j)
```

### Constraint Compliance Metric

```python
compliance_rate = (# constraints satisfied) / (# total constraints)
```

**Threshold**: We consider ≥95% compliance as acceptable.

---

## Distillation Process

### Loss Function

Our modified loss function combines three components:

```
L_total = α·L_KD + β·L_constraint + γ·L_hard
```

Where:
- **L_KD**: Knowledge distillation loss (KL divergence)
- **L_constraint**: Economic constraint penalty
- **L_hard**: Standard classification loss
- **α, β, γ**: Weighting hyperparameters

### Detailed Loss Components

#### 1. Knowledge Distillation Loss (L_KD)

```python
L_KD = KL(softmax(z_student/T) || softmax(z_teacher/T))
```

Where:
- `z`: logits
- `T`: temperature (typically 2-5)
- `KL`: Kullback-Leibler divergence

**Intuition**: Student learns to match teacher's probability distribution.

#### 2. Economic Constraint Loss (L_constraint)

```python
L_constraint = λ_sign · L_sign + λ_mono · L_mono + λ_bound · L_bound
```

Components:
- `L_sign`: Penalty for wrong signs
- `L_mono`: Penalty for non-monotonicity
- `L_bound`: Penalty for out-of-bound magnitudes

#### 3. Hard Label Loss (L_hard)

```python
L_hard = CrossEntropy(y_true, softmax(z_student))
```

Standard classification loss for ground truth labels.

### Training Algorithm

```python
Algorithm: Economic Knowledge Distillation

Input:
  - X_train, y_train: Training data
  - teacher: Trained teacher model
  - constraints: Economic constraints
  - α, β, γ: Loss weights
  - T: Temperature

Output:
  - student: Trained student model

1. Initialize student model
2. For each epoch:
     3. For each batch (X_batch, y_batch):
          4. Get teacher predictions: p_teacher = teacher.predict_proba(X_batch)
          5. Get student logits: z_student = student(X_batch)
          6. Calculate L_KD with temperature T
          7. Calculate L_constraint from student coefficients
          8. Calculate L_hard from true labels
          9. L_total = α·L_KD + β·L_constraint + γ·L_hard
          10. Backpropagate and update student
     11. Validate constraint compliance
12. Return student
```

---

## Stability Analysis

### Bootstrap Procedure

To ensure coefficients are stable for inference:

```python
Algorithm: Bootstrap Stability Analysis

Input:
  - X, y: Full dataset
  - student: Trained student model
  - n_bootstrap: Number of samples (default: 500)

Output:
  - coef_mean: Mean coefficients
  - coef_std: Standard deviation
  - coef_ci: 95% confidence intervals
  - cv: Coefficient of variation

1. Initialize storage for n_bootstrap coefficient sets
2. For i = 1 to n_bootstrap:
     3. Sample (X_boot, y_boot) with replacement from (X, y)
     4. Train student on (X_boot, y_boot)
     5. Extract coefficients: β_i
     6. Store β_i
7. Calculate statistics across bootstrap samples:
     - coef_mean = mean(β_1, ..., β_n)
     - coef_std = std(β_1, ..., β_n)
     - coef_ci = percentile([2.5, 97.5])
     - cv = coef_std / |coef_mean|
8. Return statistics
```

### Stability Metrics

#### 1. Coefficient of Variation (CV)

```
CV_j = σ(β_j) / |μ(β_j)|
```

**Interpretation**:
- CV < 0.15: **Stable** (acceptable for inference)
- 0.15 ≤ CV < 0.30: **Moderately stable**
- CV ≥ 0.30: **Unstable** (avoid inference)

#### 2. Sign Stability

```
sign_stability_j = (# bootstrap samples where sign(β_j) = sign(β_j_mean)) / n_bootstrap
```

**Threshold**: ≥95% considered stable.

#### 3. Confidence Interval Width

Narrower intervals indicate more stability.

```
ci_width_j = CI_97.5(β_j) - CI_2.5(β_j)
```

---

## Structural Break Detection

### Motivation

Economic relationships may change over time (e.g., financial crisis, policy changes).

### Rolling Window Analysis

```python
Algorithm: Structural Break Detection

Input:
  - X, y, time: Time-series data
  - window_size: Size of rolling window
  - min_samples: Minimum samples per window

Output:
  - break_points: Detected structural breaks
  - coef_evolution: Coefficient trajectories

1. Sort data by time
2. For each window starting at t:
     3. Extract data in [t, t+window_size]
     4. Train student model
     5. Extract coefficients: β_t
     6. Store β_t
7. Calculate coefficient variance across windows
8. Detect breaks using CUSUM or Chow test:
     - Large change in β_t → potential break
9. Return break points and trajectories
```

### Break Detection Methods

#### 1. CUSUM (Cumulative Sum Control Chart)

```
CUSUM_t = Σ(β_i - β_mean) for i=1 to t
```

**Break detected** if |CUSUM_t| exceeds threshold.

#### 2. Chow Test

Test if coefficients differ significantly before/after time t:

```
F = [(RSS_pooled - RSS_1 - RSS_2) / k] / [(RSS_1 + RSS_2) / (n-2k)]
```

Where:
- RSS: Residual sum of squares
- k: Number of parameters
- n: Total observations

---

## Implementation Details

### Student Model Choices

#### 1. Logistic Regression

**Pros**:
- Fully interpretable
- Fast training
- Linear coefficients

**Cons**:
- Cannot capture non-linear relationships
- Limited flexibility

**Use case**: When linearity assumption holds.

#### 2. Generalized Additive Models (GAMs)

**Pros**:
- Non-linear relationships via splines
- Partially interpretable (can visualize each feature)
- More flexible than linear

**Cons**:
- More complex than logistic regression
- Requires more data
- Harder to communicate

**Use case**: When relationships are known to be non-linear.

### Teacher Model Choices

#### 1. Gradient Boosting (XGBoost, LightGBM)

**Pros**:
- High accuracy
- Handles missing values
- Feature importance

**Cons**:
- Black box
- Computationally expensive

#### 2. Neural Networks

**Pros**:
- Can learn complex patterns
- Flexible architecture

**Cons**:
- Requires more data
- Prone to overfitting
- Hard to interpret

#### 3. Random Forest

**Pros**:
- Robust to overfitting
- Good for feature importance
- Handles non-linearity

**Cons**:
- Can be slow
- Black box

---

## Hyperparameters

### Key Hyperparameters and Recommended Values

| Parameter | Description | Default | Range | Tuning Advice |
|-----------|-------------|---------|-------|---------------|
| **Temperature (T)** | Softens probability distributions | 2.0 | [1, 5] | Higher for harder tasks |
| **α (KD weight)** | Weight on distillation loss | 0.5 | [0.3, 0.7] | Balance with hard loss |
| **β (Constraint weight)** | Weight on constraint penalty | 0.3 | [0.1, 0.5] | Higher if constraints violated |
| **γ (Hard loss weight)** | Weight on classification loss | 0.2 | [0.1, 0.4] | Ensure adequate accuracy |
| **n_bootstrap** | Bootstrap samples for stability | 500 | [100, 1000] | More = better CI, slower |
| **window_size** | Rolling window for breaks | 500 | [200, 1000] | Depends on data frequency |

### Tuning Strategy

1. **Start with defaults**
2. **Grid search**:
   ```python
   params = {
       'T': [1, 2, 3, 5],
       'alpha': [0.3, 0.5, 0.7],
       'beta': [0.1, 0.3, 0.5]
   }
   ```
3. **Optimize for**:
   - Accuracy (AUC-ROC)
   - Constraint compliance
   - Coefficient stability (CV)

4. **Validation**:
   - Use cross-validation
   - Check multiple metrics
   - Verify on holdout test set

---

## Computational Complexity

### Time Complexity

| Component | Complexity | Notes |
|-----------|-----------|-------|
| Teacher training | O(n·m·d·T) | n=samples, m=trees, d=depth, T=iterations |
| Distillation | O(n·d·E) | E=epochs |
| Bootstrap | O(B·n·d·E) | B=bootstrap samples |
| Break detection | O(W·n/w·d·E) | W=windows, w=window size |

**Typical Total Time**:
- German Credit (n=1K): ~2-3 minutes
- Adult Income (n=50K): ~3-5 minutes

### Space Complexity

- Training data: O(n·d)
- Bootstrap storage: O(B·d) for coefficients
- Model storage: O(d) for linear, O(d·k) for GAMs (k=basis functions)

---

## References

### Key Papers

1. **Knowledge Distillation**:
   - Hinton et al. (2015). "Distilling the Knowledge in a Neural Network"

2. **Economic Constraints**:
   - Mullainathan & Spiess (2017). "Machine Learning: An Applied Econometric Approach"

3. **Interpretable Models**:
   - Hastie & Tibshirani (1987). "Generalized Additive Models"
   - Rudin (2019). "Stop Explaining Black Box Models"

4. **Bootstrap Methods**:
   - Efron & Tibshirani (1994). "An Introduction to the Bootstrap"

5. **Structural Breaks**:
   - Chow (1960). "Tests of Equality Between Sets of Coefficients"

---

## Additional Resources

- **Code**: See `experiments/` for implementations
- **Examples**: See `examples/` for usage examples
- **FAQ**: See [FAQ.md](FAQ.md) for common questions

---

**Last updated**: 2025-12-10
**Authors**: Knowledge Distillation Economics Team
