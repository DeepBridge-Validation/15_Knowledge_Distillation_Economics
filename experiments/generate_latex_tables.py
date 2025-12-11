#!/usr/bin/env python3
"""
Generate LaTeX Tables for Paper
================================

Reads experiment results and generates LaTeX tables formatted for inclusion
in the Knowledge Distillation for Economics paper.

Output:
- results/latex_tables.tex: All tables ready for paper
- Individual table files for each experiment
"""

import json
import os
from pathlib import Path

print("="*80)
print("GENERATING LATEX TABLES FOR PAPER")
print("="*80)

results_dir = Path("results")
output_file = results_dir / "latex_tables.tex"

# ============================================================================
# Load Results
# ============================================================================

print("\n1. Loading experiment results...")

german_credit_results = None
adult_income_results = None

german_file = results_dir / "german_credit_results.json"
adult_file = results_dir / "adult_income_results.json"

if german_file.exists():
    with open(german_file, 'r') as f:
        german_credit_results = json.load(f)
    print(f"   ✅ Loaded German Credit results")
else:
    print(f"   ⚠️  German Credit results not found")

if adult_file.exists():
    with open(adult_file, 'r') as f:
        adult_income_results = json.load(f)
    print(f"   ✅ Loaded Adult Income results")
else:
    print(f"   ⚠️  Adult Income results not found")


# ============================================================================
# Generate Tables
# ============================================================================

print("\n2. Generating LaTeX tables...")

latex_content = []

latex_content.append(r"""
% ============================================================================
% LaTeX Tables for Knowledge Distillation for Economics Paper
% Generated automatically from experiment results
% ============================================================================
""")

# ----------------------------------------------------------------------------
# Table 1: German Credit Results
# ----------------------------------------------------------------------------

if german_credit_results:
    latex_content.append(r"""
\begin{table}[h]
\centering
\caption{Resultados Empíricos - German Credit Dataset (Dados Reais)}
\label{tab:german_credit_real}
\begin{tabular}{lcccc}
\toprule
\textbf{Modelo} & \textbf{AUC-ROC} & \textbf{F1-Score} & \textbf{Accuracy} & \textbf{Compliance} \\
\midrule
""")

    models = german_credit_results['models']

    # Teacher
    latex_content.append(
        f"Teacher (GBM) & "
        f"{models['teacher']['test_auc']:.3f} & "
        f"{models['teacher']['test_f1']:.3f} & "
        f"{models['teacher']['test_acc']:.3f} & "
        f"--- \\\\\n"
    )

    # Baseline
    latex_content.append(
        f"Baseline (LR) & "
        f"{models['baseline']['test_auc']:.3f} & "
        f"{models['baseline']['test_f1']:.3f} & "
        f"{models['baseline']['test_acc']:.3f} & "
        f"{models['baseline']['compliance']:.1f}\\% \\\\\n"
    )

    # Standard KD
    latex_content.append(
        f"Standard KD & "
        f"{models['standard_kd']['test_auc']:.3f} & "
        f"{models['standard_kd']['test_f1']:.3f} & "
        f"{models['standard_kd']['test_acc']:.3f} & "
        f"--- \\\\\n"
    )

    # Economic KD
    latex_content.append(
        f"\\textbf{{Economic KD}} & "
        f"\\textbf{{{models['economic_kd']['test_auc']:.3f}}} & "
        f"\\textbf{{{models['economic_kd']['test_f1']:.3f}}} & "
        f"\\textbf{{{models['economic_kd']['test_acc']:.3f}}} & "
        f"\\textbf{{{models['economic_kd']['compliance']:.1f}\\%}} \\\\\n"
    )

    # Trade-offs
    teacher_auc = models['teacher']['test_auc']
    economic_auc = models['economic_kd']['test_auc']
    baseline_auc = models['baseline']['test_auc']

    loss_pct = (1 - economic_auc/teacher_auc) * 100
    gain_pp = (economic_auc - baseline_auc) * 100

    latex_content.append(r"""\midrule
""")
    latex_content.append(
        f"\\multicolumn{{5}}{{l}}{{\\textit{{Perda vs. Teacher: {loss_pct:+.1f}\\%, "
        f"Ganho vs. Baseline: {gain_pp:+.1f} pp}}}} \\\\\n"
    )

    latex_content.append(r"""\bottomrule
\end{tabular}
\end{table}

""")

    print("   ✅ Generated Table: German Credit Results")


# ----------------------------------------------------------------------------
# Table 2: Adult Income Results
# ----------------------------------------------------------------------------

if adult_income_results:
    latex_content.append(r"""
\begin{table}[h]
\centering
\caption{Resultados Empíricos - Adult Income Dataset (Dados Reais)}
\label{tab:adult_income_real}
\begin{tabular}{lcccc}
\toprule
\textbf{Modelo} & \textbf{AUC-ROC} & \textbf{F1-Score} & \textbf{Compliance} & \textbf{Edu. Monotonia} \\
\midrule
""")

    models = adult_income_results['models']

    # Teacher
    latex_content.append(
        f"Teacher (RF) & "
        f"{models['teacher']['test_auc']:.3f} & "
        f"{models['teacher']['test_f1']:.3f} & "
        f"--- & --- \\\\\n"
    )

    # Baseline
    baseline_comp = models['baseline']['compliance']
    latex_content.append(
        f"Baseline (LR) & "
        f"{models['baseline']['test_auc']:.3f} & "
        f"{models['baseline']['test_f1']:.3f} & "
        f"{baseline_comp:.1f}\\% & --- \\\\\n" if baseline_comp else
        f"{models['baseline']['test_auc']:.3f} & "
        f"{models['baseline']['test_f1']:.3f} & "
        f"--- & --- \\\\\n"
    )

    # Economic KD
    economic_comp = models['economic_kd']['compliance']
    monotonic = adult_income_results['marginal_effects']['education_monotonic']

    latex_content.append(
        f"\\textbf{{Economic KD}} & "
        f"\\textbf{{{models['economic_kd']['test_auc']:.3f}}} & "
        f"\\textbf{{{models['economic_kd']['test_f1']:.3f}}} & "
    )

    if economic_comp:
        latex_content.append(f"\\textbf{{{economic_comp:.1f}\\%}} & ")
    else:
        latex_content.append(f"--- & ")

    if monotonic is not None:
        latex_content.append(f"\\textbf{{{'Sim' if monotonic else 'Não'}}} \\\\\n")
    else:
        latex_content.append(f"--- \\\\\n")

    # Trade-offs
    teacher_auc = models['teacher']['test_auc']
    economic_auc = models['economic_kd']['test_auc']

    retention_pct = (economic_auc / teacher_auc) * 100

    latex_content.append(r"""\midrule
""")
    latex_content.append(
        f"\\multicolumn{{5}}{{l}}{{\\textit{{Retenção vs. Teacher: {retention_pct:.1f}\\%}}}} \\\\\n"
    )

    latex_content.append(r"""\bottomrule
\end{tabular}
\end{table}

""")

    print("   ✅ Generated Table: Adult Income Results")


# ----------------------------------------------------------------------------
# Table 3: Comparison with Paper Expected Values
# ----------------------------------------------------------------------------

latex_content.append(r"""
\begin{table}[h]
\centering
\caption{Comparação: Valores Empíricos vs. Esperados do Paper}
\label{tab:comparison_expected}
\begin{tabular}{lccc}
\toprule
\textbf{Métrica} & \textbf{Esperado (Paper)} & \textbf{German Credit} & \textbf{Adult Income} \\
\midrule
""")

if german_credit_results and adult_income_results:
    # Loss vs Teacher
    gc_loss = (1 - german_credit_results['models']['economic_kd']['test_auc'] /
               german_credit_results['models']['teacher']['test_auc']) * 100
    ai_retention = (adult_income_results['models']['economic_kd']['test_auc'] /
                    adult_income_results['models']['teacher']['test_auc']) * 100

    latex_content.append(
        f"Perda vs. Teacher & 2-5\\% & {gc_loss:.1f}\\% & "
        f"{100-ai_retention:.1f}\\% \\\\\n"
    )

    # Compliance
    gc_comp = german_credit_results['models']['economic_kd']['compliance']
    ai_comp = adult_income_results['models']['economic_kd']['compliance']

    latex_content.append(f"Compliance & 95\\%+ & {gc_comp:.1f}\\% & ")
    if ai_comp:
        latex_content.append(f"{ai_comp:.1f}\\% \\\\\n")
    else:
        latex_content.append(f"--- \\\\\n")

    # Stability
    if 'stability' in german_credit_results:
        gc_cv = german_credit_results['stability']['avg_cv']
        latex_content.append(
            f"CV Médio & < 0.15 & {gc_cv:.3f} & --- \\\\\n"
        )

    # Monotonicity
    if 'marginal_effects' in adult_income_results:
        mono = adult_income_results['marginal_effects']['education_monotonic']
        latex_content.append(
            f"Monotonia Educação & 100\\% & --- & "
            f"{'Sim' if mono else 'Não'} \\\\\n"
        )

latex_content.append(r"""\bottomrule
\end{tabular}
\end{table}

""")

print("   ✅ Generated Table: Comparison with Expected Values")


# ============================================================================
# Save Output
# ============================================================================

print("\n3. Saving LaTeX tables...")

latex_text = "".join(latex_content)

with open(output_file, 'w', encoding='utf-8') as f:
    f.write(latex_text)

print(f"   ✅ Saved to: {output_file}")

# Also save individual tables
if german_credit_results:
    with open(results_dir / "table_german_credit.tex", 'w', encoding='utf-8') as f:
        # Extract just German Credit table
        start_idx = latex_text.find(r"\begin{table}[h]")
        end_idx = latex_text.find(r"\end{table}", start_idx) + len(r"\end{table}")
        f.write(latex_text[start_idx:end_idx+1])
    print(f"   ✅ Saved individual table: table_german_credit.tex")

print("\n" + "="*80)
print("LATEX GENERATION COMPLETED")
print("="*80)
print(f"\nGenerated files:")
print(f"  - {output_file}")
print(f"\nTo include in paper:")
print(f"  \\input{{experiments/results/latex_tables.tex}}")
print(f"\nOr use individual tables:")
print(f"  \\input{{experiments/results/table_german_credit.tex}}")
print("="*80)
