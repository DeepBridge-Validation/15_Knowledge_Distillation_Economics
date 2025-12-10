# Datasets

**Complete Description of All Datasets Used**

This document provides comprehensive information about all datasets used in the "Knowledge Distillation for Economics" research.

---

## Table of Contents

- [Overview](#overview)
- [Dataset 1: German Credit](#dataset-1-german-credit)
- [Dataset 2: Adult Income](#dataset-2-adult-income)
- [Data Access and Licensing](#data-access-and-licensing)
- [Data Preprocessing](#data-preprocessing)
- [Ethical Considerations](#ethical-considerations)

---

## Overview

We use **two real-world public datasets** from different economic domains to validate our framework:

| Dataset | Domain | Samples | Features | Target | Source |
|---------|--------|---------|----------|--------|--------|
| German Credit | Credit Risk | 1,000 | 20 | Binary | UCI ML Repository |
| Adult Income | Labor Economics | 48,842 | 14 | Binary | US Census Bureau |

Both datasets are:
- ✅ Publicly available
- ✅ Widely used in research
- ✅ Well-documented
- ✅ Suitable for econometric analysis

---

## Dataset 1: German Credit

### Basic Information

- **Full Name**: Statlog (German Credit Data)
- **Source**: UCI Machine Learning Repository
- **Original Provider**: Professor Dr. Hans Hofmann, University of Hamburg
- **Year**: 1994
- **Samples**: 1,000
- **Features**: 20 (mix of categorical and numerical)
- **Target Variable**: Credit risk (good/bad)
- **Domain**: Credit scoring and risk assessment

### Download Information

**Automatic Download** (recommended):
```python
from sklearn.datasets import fetch_openml
data = fetch_openml('credit-g', version=1, as_frame=True, parser='auto')
```

**Manual Download**:
- URL: https://archive.ics.uci.edu/ml/datasets/statlog+(german+credit+data)
- Format: Data file + names file

### Features Description

#### Numerical Features (7)

| Feature | Description | Range | Unit |
|---------|-------------|-------|------|
| `duration` | Duration of credit in months | 4-72 | months |
| `credit_amount` | Credit amount | 250-18,424 | DM (Deutsche Mark) |
| `installment_commitment` | Installment rate as % of disposable income | 1-4 | % category |
| `residence_since` | Present residence since | 1-4 | years category |
| `age` | Age in years | 19-75 | years |
| `existing_credits` | Number of existing credits at this bank | 1-4 | count |
| `num_dependents` | Number of dependents | 1-2 | count |

#### Categorical Features (13)

| Feature | Description | Categories | Example Values |
|---------|-------------|------------|----------------|
| `checking_status` | Status of checking account | 4 | '<0', '0<=X<200', '>=200', 'no checking' |
| `credit_history` | Credit history | 5 | 'no credits/all paid', 'critical account' |
| `purpose` | Purpose of credit | 10 | 'car', 'furniture/equipment', 'business' |
| `savings_status` | Savings account/bonds status | 5 | '<100', '100<=X<500', '>=1000' |
| `employment` | Present employment since | 5 | 'unemployed', '<1', '1<=X<4', '>=7' |
| `personal_status` | Personal status and sex | 4 | 'male single', 'female div/sep/mar' |
| `other_parties` | Other debtors/guarantors | 3 | 'none', 'co applicant', 'guarantor' |
| `property_magnitude` | Property | 4 | 'real estate', 'car', 'life insurance' |
| `other_payment_plans` | Other installment plans | 3 | 'bank', 'stores', 'none' |
| `housing` | Housing | 3 | 'rent', 'own', 'for free' |
| `job` | Job category | 4 | 'unemp/unskilled', 'skilled', 'management' |
| `own_telephone` | Telephone | 2 | 'yes', 'none' |
| `foreign_worker` | Foreign worker | 2 | 'yes', 'no' |

### Target Variable

- **Variable**: `class`
- **Values**:
  - `good`: Good credit (700 samples, 70%)
  - `bad`: Bad credit (300 samples, 30%)
- **Task**: Binary classification
- **Imbalance**: Moderately imbalanced (70:30 ratio)

### Economic Context

**Historical Background**:
- Collected in Germany in early 1990s
- Represents actual credit decisions from a German bank
- Used for developing automated credit scoring systems

**Economic Significance**:
- Credit risk assessment is fundamental to banking
- Balance between: (1) Approving creditworthy customers, (2) Avoiding defaults
- Regulatory requirements (Basel III) demand interpretable models

### Economic Constraints Applied

Based on economic theory of credit risk:

| Feature | Constraint Type | Direction | Justification |
|---------|-----------------|-----------|---------------|
| `credit_amount` | Sign | Positive | Higher amount → higher risk |
| `duration` | Sign | Positive | Longer duration → higher risk |
| `age` | Monotonicity | U-shaped | Young/old → higher risk, middle-age → lower risk |
| `installment_commitment` | Sign | Positive | Higher % of income → higher risk |
| `savings_status` | Monotonicity | Decreasing | More savings → lower risk |

### Data Quality Issues

**Known Issues**:
1. **Imbalanced classes**: 70:30 ratio (handled via appropriate metrics)
2. **Categorical encoding**: Ordinal vs. nominal categories need careful handling
3. **Cost matrix**: Original task has asymmetric costs (false negative more costly)
4. **Missing values**: None in this dataset

**Our Handling**:
- Use AUC-ROC (handles imbalance)
- Label encoding for ordinal, one-hot for nominal
- Focus on accuracy, but note cost implications
- No missing value imputation needed

### Citation

```bibtex
@misc{uci_german_credit,
  title={{Statlog (German Credit Data)}},
  author={Hofmann, Hans},
  year={1994},
  institution={University of Hamburg},
  url={https://archive.ics.uci.edu/ml/datasets/statlog+(german+credit+data)},
  note={UCI Machine Learning Repository}
}
```

---

## Dataset 2: Adult Income

### Basic Information

- **Full Name**: Adult Income Dataset (Census Income)
- **Source**: UCI Machine Learning Repository / US Census Bureau
- **Original Extraction**: Barry Becker from 1994 Census database
- **Year**: 1994
- **Samples**: 48,842 (32,561 train + 16,281 test in original split)
- **Features**: 14 (mix of continuous and categorical)
- **Target Variable**: Income level (>50K or ≤50K)
- **Domain**: Labor economics and income prediction

### Download Information

**Automatic Download** (recommended):
```python
from sklearn.datasets import fetch_openml
data = fetch_openml('adult', version=2, as_frame=True, parser='auto')
```

**Manual Download**:
- URL: https://archive.ics.uci.edu/ml/datasets/adult
- Files: adult.data (training), adult.test (testing)

### Features Description

#### Continuous Features (6)

| Feature | Description | Range | Mean |
|---------|-------------|-------|------|
| `age` | Age in years | 17-90 | 38.6 |
| `fnlwgt` | Final weight (Census sampling weight) | 12,285-1,490,400 | 189,778 |
| `education-num` | Years of education | 1-16 | 10.1 |
| `capital-gain` | Capital gains | 0-99,999 | 1,078 |
| `capital-loss` | Capital losses | 0-4,356 | 87 |
| `hours-per-week` | Hours worked per week | 1-99 | 40.4 |

#### Categorical Features (8)

| Feature | Description | Categories | Most Common |
|---------|-------------|------------|-------------|
| `workclass` | Employment type | 9 | Private (73%) |
| `education` | Education level | 16 | HS-grad (32%) |
| `marital-status` | Marital status | 7 | Married-civ-spouse (46%) |
| `occupation` | Occupation type | 15 | Craft-repair (13%) |
| `relationship` | Relationship status | 6 | Husband (40%) |
| `race` | Race | 5 | White (85%) |
| `sex` | Gender | 2 | Male (67%) |
| `native-country` | Country of origin | 42 | United-States (90%) |

### Target Variable

- **Variable**: `income`
- **Values**:
  - `≤50K`: Income at or below $50,000 per year (75.9%)
  - `>50K`: Income above $50,000 per year (24.1%)
- **Task**: Binary classification
- **Imbalance**: Imbalanced (76:24 ratio)

### Economic Context

**Background**:
- Extracted from 1994 US Census
- Represents cross-section of US workforce
- $50K threshold was significant in 1994 (≈$100K in 2024 dollars)

**Economic Significance**:
- Labor economics: understanding income determinants
- Policy: education, training, discrimination analysis
- Wage gap research: gender, race, education effects

**Research Applications**:
- Human capital theory validation
- Returns to education estimation
- Gender wage gap analysis
- Discrimination detection

### Economic Constraints Applied

Based on labor economics theory:

| Feature | Constraint Type | Direction | Justification |
|---------|-----------------|-----------|---------------|
| `education-num` | Monotonicity | Increasing | Human capital theory: more education → higher income |
| `age` | Monotonicity | Increasing (then plateau) | Experience premium, diminishes with age |
| `hours-per-week` | Sign | Positive | More hours → higher income |
| `capital-gain` | Sign | Positive | Investment income indicates wealth |

### Data Quality Issues

**Known Issues**:
1. **Missing values**: Denoted as `?` in original data (~7% of samples)
2. **Class imbalance**: 76:24 ratio
3. **Sampling weights**: `fnlwgt` indicates sampling design
4. **Censored income**: Top-coded at $50K (doesn't show actual high incomes)
5. **Dated**: 1994 data may not reflect current labor market

**Our Handling**:
- Remove samples with missing values (or impute if analyzing thoroughly)
- Use AUC-ROC for imbalance
- Ignore sampling weights for initial analysis
- Focus on qualitative relationships (still valid)
- Note limitations in paper discussion

### Preprocessing Pipeline

```python
# Load data
data = fetch_openml('adult', version=2, as_frame=True)

# Handle missing values
data = data[data != '?'].dropna()

# Encode target
y = (data['income'] == '>50K').astype(int)

# Encode categorical features
# - Label encoding for ordinal (education)
# - One-hot encoding for nominal (workclass, occupation, etc.)

# Scale numerical features
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
X_numerical_scaled = scaler.fit_transform(X_numerical)
```

### Citation

```bibtex
@misc{uci_adult,
  title={{Adult Income Dataset}},
  author={Becker, Barry and Kohavi, Ronny},
  year={1996},
  institution={US Census Bureau},
  url={https://archive.ics.uci.edu/ml/datasets/adult},
  note={UCI Machine Learning Repository}
}
```

---

## Data Access and Licensing

### Licensing

Both datasets are:
- **Public domain** or **CC0** (no copyright)
- **Free to use** for research and commercial purposes
- **No attribution required** (but recommended for academic use)

### Responsible Use

We commit to:
- ✅ Citing original sources
- ✅ Documenting data provenance
- ✅ Acknowledging limitations
- ✅ Respecting privacy (no individual identification)
- ✅ Transparent reporting of preprocessing

---

## Data Preprocessing

### Standard Pipeline

Applied to both datasets:

1. **Load data** from OpenML or UCI
2. **Handle missing values**: Remove or impute
3. **Encode categorical variables**: Label encoding or one-hot encoding
4. **Scale numerical features**: StandardScaler
5. **Split data**: Train/test split (80/20) with stratification
6. **Fixed random seed**: `RANDOM_STATE=42` for reproducibility

### Feature Engineering

**German Credit**:
```python
# Create economically meaningful feature
X['monthly_payment'] = X['credit_amount'] / (X['duration'] + 1)
```

**Adult Income**:
```python
# No additional feature engineering in baseline experiments
# (Could add: age groups, education categories, etc.)
```

---

## Ethical Considerations

### Fairness and Bias

**German Credit**:
- Contains sensitive attributes (age, gender via personal_status)
- Historical bias may exist in credit decisions
- **Our approach**: Focus on economic relationships, not protected attributes

**Adult Income**:
- Contains protected attributes (race, sex, native-country)
- Known to exhibit gender and racial wage gaps
- **Our approach**: Document relationships, do not use for discriminatory purposes

### Privacy

- Both datasets are **anonymized**
- No individual identification possible
- Aggregated statistics only

### Limitations and Disclaimers

1. **Historical data**: May not reflect current economic conditions
2. **Structural biases**: Reflect historical discrimination
3. **Not for deployment**: Research purposes only, not production systems
4. **Geographic specificity**: Results may not generalize to other regions
5. **Temporal drift**: Economic relationships change over time

### Our Commitment

- ✅ Transparent reporting of limitations
- ✅ No deployment recommendations without further validation
- ✅ Acknowledge biases in paper discussion
- ✅ Focus on methodological contributions, not policy prescriptions

---

## Future Datasets

We plan to extend our analysis to additional domains:

### Potential Additions

1. **Healthcare**: Medical cost prediction, treatment outcomes
2. **Housing**: Real estate pricing, mortgage risk
3. **Education**: Student performance, retention prediction
4. **Finance**: Stock market prediction, portfolio optimization

**Requirements for new datasets**:
- Public availability or partnerships
- Clear economic interpretation
- Sufficient sample size (n > 500)
- Documented economic constraints
- Ethical approval for use

---

## Dataset Statistics Summary

### German Credit

```
Samples: 1,000
Features: 20 (7 numerical, 13 categorical)
Target distribution: 70% good, 30% bad
Missing values: None
Data type: Cross-sectional
Time period: Early 1990s
Country: Germany
```

### Adult Income

```
Samples: 48,842 (after removing missing)
Features: 14 (6 continuous, 8 categorical)
Target distribution: 75.9% ≤50K, 24.1% >50K
Missing values: ~7% (removed)
Data type: Cross-sectional
Time period: 1994
Country: United States
```

---

## References

### Data Source Papers

1. **German Credit**:
   - Hofmann, H. (1994). "Statlog (German Credit Data) Data Set"

2. **Adult Income**:
   - Kohavi, R. (1996). "Scaling Up the Accuracy of Naive-Bayes Classifiers"

### Related Work Using These Datasets

1. Credit risk: 1000+ papers on Google Scholar
2. Income prediction: 500+ papers on Google Scholar

---

## Contact

For questions about datasets:
- Check [FAQ.md](FAQ.md)
- Open an issue on GitHub
- Email: [contact email]

---

**Last updated**: 2025-12-10
**Maintained by**: Knowledge Distillation Economics Team
