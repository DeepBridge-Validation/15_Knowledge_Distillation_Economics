#!/usr/bin/env python3
"""
Dependency Checker for Knowledge Distillation Economics
========================================================

Verifies that all required packages are installed with correct versions.

Usage:
    python scripts/check_dependencies.py

Exit codes:
    0 - All dependencies OK
    1 - Some dependencies missing or outdated
"""

import importlib
import sys
from typing import Dict, Tuple

# ANSI color codes for terminal output
GREEN = '\033[92m'
YELLOW = '\033[93m'
RED = '\033[91m'
RESET = '\033[0m'
BOLD = '\033[1m'

REQUIRED_PACKAGES = {
    'numpy': '1.21.0',
    'pandas': '1.3.0',
    'scipy': '1.7.0',
    'sklearn': '1.0.0',  # Note: import name is 'sklearn', package is 'scikit-learn'
    'xgboost': '1.5.0',
    'statsmodels': '0.13.0',
    'matplotlib': '3.4.0',
    'seaborn': '0.11.0',
    'openml': '0.12.0',
    'joblib': '1.1.0',
    'tqdm': '4.62.0',
}

OPTIONAL_PACKAGES = {
    'yaml': '5.4.0',  # PyYAML
    'jupyter': '1.0.0',
}


def parse_version(version_str: str) -> Tuple[int, ...]:
    """Parse version string to tuple of integers for comparison."""
    try:
        return tuple(int(x) for x in version_str.split('.')[:3])
    except (ValueError, AttributeError):
        return (0, 0, 0)


def check_package(package_name: str, min_version: str, optional: bool = False) -> bool:
    """
    Check if package is installed and meets minimum version.

    Args:
        package_name: Name of the package to import
        min_version: Minimum required version
        optional: Whether package is optional

    Returns:
        True if package meets requirements, False otherwise
    """
    # Special handling for scikit-learn
    if package_name == 'sklearn':
        package_display = 'scikit-learn'
    elif package_name == 'yaml':
        package_display = 'PyYAML'
    else:
        package_display = package_name

    try:
        module = importlib.import_module(package_name)

        # Get version
        if hasattr(module, '__version__'):
            installed_version = module.__version__
        elif hasattr(module, 'VERSION'):
            installed_version = module.VERSION
        else:
            print(f"{YELLOW}⚠️  {package_display}: installed (version unknown){RESET}")
            return True

        # Compare versions
        installed_tuple = parse_version(installed_version)
        required_tuple = parse_version(min_version)

        if installed_tuple >= required_tuple:
            status = "✅" if not optional else "✓"
            print(f"{GREEN}{status} {package_display}: {installed_version} "
                  f"(>= {min_version}){RESET}")
            return True
        else:
            print(f"{YELLOW}⚠️  {package_display}: {installed_version} "
                  f"(requires >= {min_version}){RESET}")
            return False

    except ImportError:
        if optional:
            print(f"{YELLOW}○  {package_display}: NOT INSTALLED (optional){RESET}")
            return True
        else:
            print(f"{RED}❌ {package_display}: NOT INSTALLED "
                  f"(requires >= {min_version}){RESET}")
            return False
    except Exception as e:
        print(f"{YELLOW}⚠️  {package_display}: ERROR - {str(e)}{RESET}")
        return False


def check_python_version():
    """Check Python version."""
    version = sys.version_info
    version_str = f"{version.major}.{version.minor}.{version.micro}"

    print(f"\n{BOLD}Python Version:{RESET}")
    if version >= (3, 9):
        print(f"{GREEN}✅ Python {version_str} (>= 3.9.0){RESET}")
        return True
    elif version >= (3, 7):
        print(f"{YELLOW}⚠️  Python {version_str} (3.9+ recommended){RESET}")
        return True
    else:
        print(f"{RED}❌ Python {version_str} (requires >= 3.7){RESET}")
        return False


def print_header():
    """Print header."""
    print("=" * 80)
    print(f"{BOLD}Knowledge Distillation for Economics - Dependency Check{RESET}")
    print("=" * 80)


def print_summary(all_ok: bool, python_ok: bool):
    """Print summary and recommendations."""
    print("\n" + "=" * 80)

    if all_ok and python_ok:
        print(f"{GREEN}{BOLD}✅ ALL DEPENDENCIES OK{RESET}")
        print(f"\n{GREEN}You're ready to run experiments!{RESET}")
        print("\nNext steps:")
        print("  1. Run experiments: cd experiments && ./run_all_experiments.sh")
        print("  2. Or run individual experiment: python experiments/01_german_credit_experiment.py")
    else:
        print(f"{RED}{BOLD}❌ SOME DEPENDENCIES MISSING OR OUTDATED{RESET}")
        print(f"\n{YELLOW}To install missing dependencies:{RESET}")
        print("  pip install -r requirements.txt")
        print("\nOr install specific package:")
        print("  pip install package-name>=version")

        if not python_ok:
            print(f"\n{YELLOW}Python version issue:{RESET}")
            print("  Please upgrade to Python 3.9 or higher")
            print("  Download from: https://www.python.org/downloads/")

    print("=" * 80)


def main():
    """Main function."""
    print_header()

    # Check Python version
    python_ok = check_python_version()

    # Check required packages
    print(f"\n{BOLD}Required Dependencies:{RESET}")
    required_ok = all(
        check_package(pkg, ver, optional=False)
        for pkg, ver in REQUIRED_PACKAGES.items()
    )

    # Check optional packages
    print(f"\n{BOLD}Optional Dependencies:{RESET}")
    optional_ok = all(
        check_package(pkg, ver, optional=True)
        for pkg, ver in OPTIONAL_PACKAGES.items()
    )

    # Print summary
    all_ok = required_ok and optional_ok
    print_summary(all_ok, python_ok)

    # Return exit code
    return 0 if (all_ok and python_ok) else 1


if __name__ == '__main__':
    sys.exit(main())
