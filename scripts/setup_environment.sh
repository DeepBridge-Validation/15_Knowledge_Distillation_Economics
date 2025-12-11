#!/bin/bash
################################################################################
# Automated Environment Setup
# Knowledge Distillation for Economics
################################################################################
#
# This script automates the complete environment setup process.
#
# Usage:
#   ./scripts/setup_environment.sh
#
################################################################################

set -e  # Exit on error

# Colors
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
    echo -e "${BLUE}▶ $1${RESET}"
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

print_header "Environment Setup - Knowledge Distillation for Economics"

echo "Project root: $PROJECT_ROOT"
echo "Python: $(which python3)"
echo ""

################################################################################
# Step 1: Check Python Version
################################################################################

print_step "Step 1/6: Checking Python Version"

PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
PYTHON_MAJOR=$(echo $PYTHON_VERSION | cut -d. -f1)
PYTHON_MINOR=$(echo $PYTHON_VERSION | cut -d. -f2)

echo "Detected Python version: $PYTHON_VERSION"

if [ "$PYTHON_MAJOR" -lt 3 ] || ([ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 9 ]); then
    print_error "Python 3.9+ required. Found $PYTHON_VERSION"
    echo "Please upgrade Python: https://www.python.org/downloads/"
    exit 1
fi

print_success "Python version OK ($PYTHON_VERSION)"

################################################################################
# Step 2: Choose Environment Type
################################################################################

print_step "Step 2/6: Choose Environment Type"

echo "How would you like to set up the environment?"
echo "  1) venv (built-in, recommended)"
echo "  2) conda (if you have conda installed)"
echo "  3) Skip (I'll handle it manually)"
echo ""
read -p "Enter choice [1-3]: " ENV_CHOICE

case $ENV_CHOICE in
    1)
        ENV_TYPE="venv"
        ;;
    2)
        ENV_TYPE="conda"
        ;;
    3)
        print_warning "Skipping environment setup"
        ENV_TYPE="skip"
        ;;
    *)
        print_warning "Invalid choice, using venv"
        ENV_TYPE="venv"
        ;;
esac

################################################################################
# Step 3: Create Environment
################################################################################

if [ "$ENV_TYPE" != "skip" ]; then
    print_step "Step 3/6: Creating Virtual Environment"

    if [ "$ENV_TYPE" == "venv" ]; then
        # Create venv
        if [ -d "venv" ]; then
            print_warning "venv directory already exists"
            read -p "Remove and recreate? [y/N]: " RECREATE
            if [ "$RECREATE" == "y" ] || [ "$RECREATE" == "Y" ]; then
                rm -rf venv
                python3 -m venv venv
                print_success "venv recreated"
            else
                print_warning "Using existing venv"
            fi
        else
            python3 -m venv venv
            print_success "venv created"
        fi

        # Activate venv
        source venv/bin/activate
        print_success "venv activated"

    elif [ "$ENV_TYPE" == "conda" ]; then
        # Check if conda is available
        if ! command -v conda &> /dev/null; then
            print_error "conda not found"
            echo "Please install conda or use venv instead"
            exit 1
        fi

        # Create conda environment
        if conda env list | grep -q econ-distillation; then
            print_warning "conda environment 'econ-distillation' already exists"
            read -p "Remove and recreate? [y/N]: " RECREATE
            if [ "$RECREATE" == "y" ] || [ "$RECREATE" == "Y" ]; then
                conda env remove -n econ-distillation -y
                conda env create -f environment.yml
                print_success "conda environment recreated"
            else
                print_warning "Using existing environment"
            fi
        else
            conda env create -f environment.yml
            print_success "conda environment created"
        fi

        # Activate conda
        eval "$(conda shell.bash hook)"
        conda activate econ-distillation
        print_success "conda environment activated"
    fi
else
    print_warning "Skipping environment creation (Step 3/6)"
fi

################################################################################
# Step 4: Upgrade pip
################################################################################

if [ "$ENV_TYPE" != "skip" ]; then
    print_step "Step 4/6: Upgrading pip"
    python3 -m pip install --upgrade pip --quiet
    print_success "pip upgraded"
else
    print_warning "Skipping pip upgrade (Step 4/6)"
fi

################################################################################
# Step 5: Install Dependencies
################################################################################

if [ "$ENV_TYPE" != "skip" ]; then
    print_step "Step 5/6: Installing Dependencies"

    echo "This may take 2-3 minutes..."
    if pip install -r requirements.txt --quiet; then
        print_success "Dependencies installed"
    else
        print_error "Failed to install some dependencies"
        echo "Try manually: pip install -r requirements.txt"
        exit 1
    fi
else
    print_warning "Skipping dependency installation (Step 5/6)"
    echo "Install manually: pip install -r requirements.txt"
fi

################################################################################
# Step 6: Verify Installation
################################################################################

print_step "Step 6/6: Verifying Installation"

if python3 scripts/check_dependencies.py; then
    print_success "All dependencies verified"
else
    print_warning "Some dependencies may be missing"
    echo "Check output above for details"
fi

################################################################################
# Create Necessary Directories
################################################################################

print_step "Creating Directories"

mkdir -p experiments/data
mkdir -p experiments/results
mkdir -p experiments/figures
mkdir -p experiments/logs
mkdir -p results
mkdir -p notebooks

print_success "Directories created"

################################################################################
# Summary
################################################################################

print_header "Setup Complete!"

echo -e "${GREEN}${BOLD}✅ Environment successfully set up!${RESET}"
echo ""
echo "Configuration:"
echo "  - Environment type: $ENV_TYPE"
echo "  - Python version: $PYTHON_VERSION"
echo "  - Project root: $PROJECT_ROOT"
echo ""
echo "Next steps:"
if [ "$ENV_TYPE" == "venv" ]; then
    echo "  1. Activate environment: source venv/bin/activate"
elif [ "$ENV_TYPE" == "conda" ]; then
    echo "  1. Activate environment: conda activate econ-distillation"
fi
echo "  2. Run experiments: ./scripts/reproduce_all_results.sh"
echo "  3. Or individual: python experiments/01_german_credit_experiment.py"
echo ""
echo "Documentation:"
echo "  - Quick start: README.md"
echo "  - Reproduction guide: docs/REPRODUCIBILITY.md"
echo "  - FAQ: docs/FAQ.md"
echo ""
echo "=========================================================================="

exit 0
