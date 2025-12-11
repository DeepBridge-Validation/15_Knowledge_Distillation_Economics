#!/bin/bash
###############################################################################
# Run All Experiments for Knowledge Distillation Economics Paper
###############################################################################
#
# This script runs all real-data experiments for the paper:
# "Knowledge Distillation for Economics: Trading Complexity for
#  Interpretability in Econometric Models"
#
# Target Venues: Journal of Econometrics, NeurIPS Economics Track
#
# Usage:
#   ./run_all_experiments.sh
#
# Results will be saved to experiments/results/
###############################################################################

set -e  # Exit on error

echo "========================================================================"
echo "RUNNING ALL EXPERIMENTS - KNOWLEDGE DISTILLATION FOR ECONOMICS"
echo "========================================================================"
echo ""

# Change to experiments directory
cd "$(dirname "$0")"

# Create results directory if it doesn't exist
mkdir -p results figures logs

echo "Experiment directory: $(pwd)"
echo ""

# ============================================================================
# Experiment 1: German Credit (Credit Risk)
# ============================================================================

echo "------------------------------------------------------------------------"
echo "EXPERIMENT 1: German Credit Dataset (Credit Risk)"
echo "------------------------------------------------------------------------"
echo "Paper Section: 5.2 - Case Study 1"
echo "Dataset: UCI German Credit (1000 samples, 20 features)"
echo "Expected time: 2-3 minutes"
echo ""

python3 01_german_credit_experiment.py 2>&1 | tee logs/german_credit.log

if [ $? -eq 0 ]; then
    echo "✅ German Credit experiment completed successfully"
else
    echo "❌ German Credit experiment failed"
    exit 1
fi

echo ""

# ============================================================================
# Experiment 2: Adult Income (Labor Economics)
# ============================================================================

echo "------------------------------------------------------------------------"
echo "EXPERIMENT 2: Adult Income Dataset (Labor Economics)"
echo "------------------------------------------------------------------------"
echo "Paper Section: 5.3 - Case Study 2"
echo "Dataset: UCI Adult/Census Income (48k samples, 14 features)"
echo "Expected time: 3-5 minutes"
echo ""

python3 02_adult_income_experiment.py 2>&1 | tee logs/adult_income.log

if [ $? -eq 0 ]; then
    echo "✅ Adult Income experiment completed successfully"
else
    echo "❌ Adult Income experiment failed"
    exit 1
fi

echo ""

# ============================================================================
# Generate LaTeX Tables and Figures
# ============================================================================

echo "------------------------------------------------------------------------"
echo "GENERATING LATEX TABLES AND FIGURES"
echo "------------------------------------------------------------------------"
echo ""

if [ -f "generate_latex_tables.py" ]; then
    python3 generate_latex_tables.py 2>&1 | tee logs/latex_generation.log

    if [ $? -eq 0 ]; then
        echo "✅ LaTeX tables generated successfully"
    else
        echo "⚠️  LaTeX generation had warnings (check logs)"
    fi
else
    echo "⚠️  generate_latex_tables.py not found, skipping"
fi

echo ""

# ============================================================================
# Summary
# ============================================================================

echo "========================================================================"
echo "ALL EXPERIMENTS COMPLETED"
echo "========================================================================"
echo ""
echo "Results saved to:"
echo "  - results/german_credit_results.json"
echo "  - results/adult_income_results.json"
echo "  - results/latex_tables.tex (if generated)"
echo ""
echo "Logs saved to:"
echo "  - logs/german_credit.log"
echo "  - logs/adult_income.log"
echo ""
echo "Next steps:"
echo "  1. Review results in results/*.json"
echo "  2. Check generated LaTeX tables for paper"
echo "  3. Incorporate results into paper Section 5"
echo "  4. Update paper with empirical validation"
echo ""
echo "For paper submission to Journal of Econometrics / NeurIPS:"
echo "  ✅ Real data experiments completed"
echo "  ✅ Results ready for inclusion"
echo "  ✅ Reproducibility scripts available"
echo ""
echo "========================================================================"
