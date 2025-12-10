---
name: Reproduction Issue
about: Report problems reproducing paper results
title: '[REPRODUCTION] '
labels: reproduction
assignees: ''
---

## Reproduction Attempt

Which experiment(s) are you trying to reproduce?
- [ ] German Credit (Experiment 1)
- [ ] Adult Income (Experiment 2)
- [ ] All experiments

## Environment

**Operating System:** (e.g., Ubuntu 22.04, macOS 13.0, Windows 11)

**Python Version:**
```
python --version
```

**Dependencies Check:**
```bash
python scripts/check_dependencies.py
# Paste output here
```

## Steps Taken

Describe exactly what you did:
1. Cloned repository
2. Installed dependencies with...
3. Ran command...
4. ...

## Your Results

**Metrics obtained:**
| Metric | Your Value | Paper Value | Difference |
|--------|------------|-------------|------------|
| AUC | ... | ... | ... |
| Compliance | ... | ... | ... |
| CV | ... | ... | ... |

**Result files** (if generated):
- Attach `experiments/results/*.json` files
- Or paste key metrics here

## Expected Results

What results were you expecting based on the paper?

## Difference Analysis

How significant is the difference?
- [ ] Within acceptable range (±2-3%)
- [ ] Slightly outside range (3-5%)
- [ ] Significantly different (>5%)

## Questions

- Is this difference acceptable?
- What might be causing it?
- How can I improve reproduction?

## Logs

If applicable, paste relevant logs:
```
# Paste logs here
```

## Checklist

- [ ] I followed instructions in [REPRODUCIBILITY.md](docs/REPRODUCIBILITY.md)
- [ ] I used fixed random seed (RANDOM_STATE=42)
- [ ] I have correct library versions
- [ ] I have attached/pasted my results
- [ ] I have checked [FAQ](docs/FAQ.md)

## Additional Information

Any other context about the reproduction attempt.
