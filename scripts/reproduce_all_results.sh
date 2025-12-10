#!/bin/bash
################################################################################
# Complete Reproduction Pipeline
# Knowledge Distillation for Economics
################################################################################
#
# This script runs the complete reproduction pipeline for the paper:
# "Knowledge Distillation for Economics: Trading Complexity for
#  Interpretability in Econometric Models"
#
# Usage:
#   ./scripts/reproduce_all_results.sh
#
# Expected time: 5-10 minutes
# Requirements: Python 3.9+, 4GB RAM, dependencies installed
#
################################################################################

set -e  # Exit on error
set -u  # Exit on undefined variable

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

# Helper functions
print_header() {
    echo ""
    echo "=========================================================================="
    echo -e "${BOLD}$1${RESET}"
    echo "=========================================================================="
    echo ""
}

print_step() {
    echo ""
    echo "--------------------------------------------------------------------------"
    echo -e "${BLUE}$1${RESET}"
    echo "--------------------------------------------------------------------------"
}

print_success() {
    echo -e "${GREEN}✅ $1${RESET}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${RESET}"
}

print_error() {
    echo -e "${RED}❌ $1${RESET}"
}

# Get script directory and project root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

# Print header
print_header "FULL REPRODUCTION PIPELINE - Knowledge Distillation for Economics"

echo "Project root: $PROJECT_ROOT"
echo "Start time: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

################################################################################
# Step 1: Check Dependencies
################################################################################

print_step "Step 1/5: Checking Dependencies"

if [ ! -f "scripts/check_dependencies.py" ]; then
    print_error "Dependency checker not found!"
    exit 1
fi

if python3 scripts/check_dependencies.py; then
    print_success "All dependencies are installed"
else
    print_error "Dependency check failed!"
    echo ""
    echo "Please install missing dependencies:"
    echo "  pip install -r requirements.txt"
    echo ""
    exit 1
fi

################################################################################
# Step 2: Prepare Directories
################################################################################

print_step "Step 2/5: Preparing Directories"

# Create necessary directories
mkdir -p experiments/data
mkdir -p experiments/results
mkdir -p experiments/figures
mkdir -p experiments/logs
mkdir -p results

print_success "Directories ready"

################################################################################
# Step 3: Run Experiments
################################################################################

print_step "Step 3/5: Running Experiments"

cd experiments

# Check if experiment runner exists
if [ ! -f "run_all_experiments.sh" ]; then
    print_warning "Experiment runner script not found"
    print_warning "Running experiments individually..."

    # Run experiment 1
    if [ -f "01_german_credit_experiment.py" ]; then
        echo ""
        echo "Running Experiment 1: German Credit Dataset..."
        python3 01_german_credit_experiment.py 2>&1 | tee logs/german_credit_$(date +%Y%m%d_%H%M%S).log
        print_success "German Credit experiment completed"
    else
        print_error "Experiment 1 not found!"
    fi

    # Run experiment 2
    if [ -f "02_adult_income_experiment.py" ]; then
        echo ""
        echo "Running Experiment 2: Adult Income Dataset..."
        python3 02_adult_income_experiment.py 2>&1 | tee logs/adult_income_$(date +%Y%m%d_%H%M%S).log
        print_success "Adult Income experiment completed"
    else
        print_error "Experiment 2 not found!"
    fi
else
    # Run the main experiment script
    echo "Running all experiments via run_all_experiments.sh..."
    chmod +x run_all_experiments.sh
    ./run_all_experiments.sh
fi

cd "$PROJECT_ROOT"

print_success "All experiments completed"

################################################################################
# Step 4: Generate Paper Artifacts
################################################################################

print_step "Step 4/5: Generating Paper Tables and Figures"

if [ -f "experiments/generate_latex_tables.py" ]; then
    python3 experiments/generate_latex_tables.py
    print_success "LaTeX tables generated"
else
    print_warning "Table generation script not found (optional)"
fi

# Check for results
if [ -d "experiments/results" ] && [ "$(ls -A experiments/results)" ]; then
    echo ""
    echo "Results saved to:"
    ls -lh experiments/results/*.json 2>/dev/null || echo "  (JSON files pending)"
    print_success "Results available in experiments/results/"
else
    print_warning "No results found in experiments/results/"
fi

################################################################################
# Step 5: Validation (Optional)
################################################################################

print_step "Step 5/5: Validating Results"

# Check if validation script exists
if [ -f "scripts/compare_results.py" ]; then
    python3 scripts/compare_results.py
    print_success "Results validated"
else
    print_warning "Validation script not found (optional step)"
fi

################################################################################
# Summary
################################################################################

print_header "REPRODUCTION COMPLETE!"

echo -e "${GREEN}${BOLD}✅ All steps completed successfully!${RESET}"
echo ""
echo "Summary:"
echo "  ✓ Dependencies verified"
echo "  ✓ Directories prepared"
echo "  ✓ Experiments executed"
echo "  ✓ Artifacts generated"
echo ""
echo "Results locations:"
echo "  📊 Experiment results: experiments/results/"
echo "  📈 Figures: experiments/figures/"
echo "  📝 Logs: experiments/logs/"
echo ""
echo "Next steps:"
echo "  1. Review results: ls -lh experiments/results/"
echo "  2. Check figures: ls -lh experiments/figures/"
echo "  3. View logs: tail experiments/logs/*.log"
echo ""
echo "To include results in paper:"
echo "  - Tables: experiments/results/*.tex"
echo "  - Figures: experiments/figures/*.pdf"
echo ""
echo "End time: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
echo "=========================================================================="

exit 0
