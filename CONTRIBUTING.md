# Contributing to Knowledge Distillation for Economics

Thank you for your interest in contributing to our research! We welcome contributions from the community.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Contribution Guidelines](#contribution-guidelines)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Enhancements](#suggesting-enhancements)
- [Code Style](#code-style)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)

---

## Code of Conduct

This project adheres to a code of professional conduct. By participating, you are expected to:

- Be respectful and inclusive
- Focus on constructive criticism
- Accept feedback gracefully
- Prioritize the community's best interests

---

## How Can I Contribute?

### Types of Contributions We Welcome

1. **Bug Reports**: Found an issue? Let us know!
2. **Documentation Improvements**: Typos, clarifications, translations
3. **Code Improvements**: Bug fixes, optimizations, refactoring
4. **New Features**: Additional experiments, datasets, or methods
5. **Testing**: Platform testing, edge case discovery
6. **Examples**: Jupyter notebooks, tutorials, use cases

### What We're Particularly Interested In

- Additional real-world datasets (economics domains)
- Alternative student model implementations (GAMs, GLMs)
- Visualization improvements
- Performance optimizations
- Cross-platform testing
- Documentation in other languages

---

## Development Setup

### 1. Fork and Clone

```bash
# Fork the repository on GitHub, then:
git clone https://github.com/YOUR_USERNAME/knowledge-distillation-economics.git
cd knowledge-distillation-economics
git remote add upstream https://github.com/ORIGINAL_OWNER/knowledge-distillation-economics.git
```

### 2. Create Development Environment

```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Install development dependencies (optional)
pip install black pytest flake8 mypy
```

### 3. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

---

## Contribution Guidelines

### Before You Start

1. **Check existing issues**: Your idea might already be discussed
2. **Open an issue first**: For major changes, discuss before coding
3. **Keep scope focused**: One issue/feature per pull request
4. **Follow conventions**: Match existing code style

### Development Workflow

1. **Branch naming**:
   - `feature/description` - New features
   - `fix/description` - Bug fixes
   - `docs/description` - Documentation
   - `refactor/description` - Code refactoring
   - `test/description` - Test additions

2. **Keep commits atomic**: One logical change per commit

3. **Test your changes**:
   ```bash
   # Run experiments
   python experiments/01_german_credit_experiment.py

   # Check dependencies
   python scripts/check_dependencies.py
   ```

4. **Update documentation**: If you change behavior, update relevant docs

---

## Reporting Bugs

### Before Submitting a Bug Report

- Check the [FAQ](docs/FAQ.md)
- Search existing issues
- Try to reproduce with latest version
- Verify it's not a platform-specific issue

### How to Submit a Good Bug Report

Use our [bug report template](.github/ISSUE_TEMPLATE/bug_report.md) and include:

**Required Information**:
- Operating System (with version)
- Python version
- Library versions (`pip freeze`)
- Complete error message
- Minimal reproduction code

**Example**:
```markdown
**Environment**:
- OS: Ubuntu 22.04
- Python: 3.9.7
- scikit-learn: 1.0.2

**Description**:
German Credit experiment fails with KeyError on line 156.

**To Reproduce**:
1. Run `python experiments/01_german_credit_experiment.py`
2. Error occurs after "Loading dataset..."

**Error Message**:
```
KeyError: 'credit_amount'
```

**Expected Behavior**:
Experiment should run successfully and generate results.
```

---

## Suggesting Enhancements

We love new ideas! For enhancements:

1. **Open an issue** with tag `enhancement`
2. **Describe the motivation**: Why is this useful?
3. **Provide examples**: How would it work?
4. **Consider alternatives**: What else could solve this?

### Enhancement Proposal Template

```markdown
**Title**: Add support for [feature]

**Motivation**:
This would help researchers who need to [use case].

**Proposed Solution**:
Implement [description] by [approach].

**Alternatives Considered**:
- Option A: [pros/cons]
- Option B: [pros/cons]

**Additional Context**:
- Related papers: [citations]
- Similar implementations: [links]
```

---

## Code Style

### Python Code Style

We follow **PEP 8** with some modifications:

```python
# Good: Clear, documented, type-hinted
def calculate_economic_compliance(
    model: BaseEstimator,
    constraints: Dict[str, Any],
    X: pd.DataFrame
) -> float:
    """
    Calculate compliance rate with economic constraints.

    Args:
        model: Trained student model
        constraints: Dictionary of economic constraints
        X: Feature matrix for evaluation

    Returns:
        Compliance rate (0-1)

    Example:
        >>> compliance = calculate_economic_compliance(model, constraints, X_test)
        >>> print(f"Compliance: {compliance:.2%}")
    """
    # Implementation
    pass
```

**Key Points**:
- Use type hints (Python 3.9+)
- Write docstrings (Google or NumPy style)
- Maximum line length: 88 characters (black default)
- Use meaningful variable names
- Add comments for complex logic

### Formatting Tools

```bash
# Auto-format code
black experiments/your_file.py

# Check style
flake8 experiments/your_file.py

# Type checking
mypy experiments/your_file.py
```

### Documentation Style

- Use Markdown for all documentation
- Keep line length reasonable (~80-100 chars)
- Use clear section headers
- Include code examples
- Add links to related docs

---

## Commit Messages

### Format

```
type(scope): brief description

Detailed explanation of what changed and why.

- Additional point 1
- Additional point 2

Fixes #123
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Formatting, no code change
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance tasks

### Examples

**Good**:
```
feat(experiments): add Lending Club dataset experiment

Implement new experiment for credit risk using Lending Club data.
Includes economic constraints for loan pricing and default risk.

- Add data loading pipeline
- Implement constraint validator
- Add result visualization

Closes #45
```

**Good**:
```
fix(distillation): correct temperature scaling in loss function

The temperature parameter was not being applied correctly in the
KL divergence calculation, leading to suboptimal distillation.

Fixed by moving temperature division inside softmax.

Fixes #67
```

**Bad**:
```
fixed stuff
```

---

## Pull Request Process

### 1. Preparation

Before submitting:

- [ ] Code follows style guidelines
- [ ] Comments added for complex parts
- [ ] Documentation updated
- [ ] Experiments run successfully
- [ ] No new warnings or errors
- [ ] Commit messages are clear

### 2. Create Pull Request

1. Push to your fork:
   ```bash
   git push origin feature/your-feature
   ```

2. Open PR on GitHub with our template

3. Fill in the PR template completely

### 3. PR Template

Your PR should include:

```markdown
## Description
Brief description of changes.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring

## Testing
- [ ] Tested on Linux
- [ ] Tested on macOS
- [ ] Tested on Windows
- [ ] Experiments run successfully
- [ ] Results validated

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] No breaking changes
- [ ] Ready for review

## Related Issues
Closes #123
Related to #456
```

### 4. Review Process

- Maintainers will review within 1 week
- Address feedback in new commits
- Once approved, we'll merge

### 5. After Merge

- Delete your branch
- Pull latest main:
  ```bash
  git checkout main
  git pull upstream main
  ```

---

## Testing Contributions

### Manual Testing

```bash
# Test specific experiment
python experiments/01_german_credit_experiment.py

# Test full reproduction
./scripts/reproduce_all_results.sh

# Check dependencies
python scripts/check_dependencies.py
```

### What to Test

- Does code run without errors?
- Are results within expected range?
- Does documentation match behavior?
- Does it work on different platforms?

---

## Documentation Contributions

### Types of Documentation Improvements

1. **Fixing typos/grammar**
2. **Clarifying explanations**
3. **Adding examples**
4. **Translating to other languages**
5. **Improving code comments**

### Documentation Standards

- Clear and concise
- Include code examples
- Use proper formatting
- Link to related sections
- Test all code snippets

---

## Adding New Experiments

To add a new experiment:

1. **Propose in an issue first**
2. **Follow existing structure**:
   ```
   experiments/
   └── 03_your_dataset/
       ├── README.md
       ├── run_experiment.py
       └── config.yaml
   ```
3. **Include**:
   - Dataset description and source
   - Economic constraints justification
   - Expected results
   - Comprehensive README

4. **Update main docs**:
   - Add to experiments/README.md
   - Update main README.md
   - Add dataset info to docs/DATASETS.md

---

## Questions?

- Check the [FAQ](docs/FAQ.md)
- Search [existing issues](https://github.com/USERNAME/knowledge-distillation-economics/issues)
- Open a [new issue](https://github.com/USERNAME/knowledge-distillation-economics/issues/new) with tag `question`

---

## Recognition

Contributors will be:
- Listed in README.md
- Mentioned in CHANGELOG.md
- Acknowledged in paper revisions (if substantial contributions)

---

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing to advancing economic research with machine learning!** 🎓

---

Last updated: 2025-12-10
