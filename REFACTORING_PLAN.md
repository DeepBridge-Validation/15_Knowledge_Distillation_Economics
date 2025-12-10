# 📋 Plano de Refatoração - Knowledge Distillation Economics Repository

**Objetivo**: Transformar o repositório em um exemplo de excelência para reprodução científica, seguindo as melhores práticas de publicação de papers com código.

**Status Atual**: Estrutura básica funcional, mas precisa de organização, documentação e melhorias para publicação.

**Target**: Repositório pronto para acompanhar submissão ao Journal of Econometrics e NeurIPS Economics Track.

---

## 🎯 Princípios Orientadores

### Standards de Reprodutibilidade Científica
1. **Completude**: Tudo necessário para reproduzir os resultados deve estar no repo
2. **Clareza**: Documentação clara e passo-a-passo
3. **Automatização**: Scripts automatizados para reproduzir tudo
4. **Versionamento**: Dependencies e versões explícitas
5. **Validação**: Checksums e testes de sanidade
6. **Acessibilidade**: Instruções claras para diferentes níveis de expertise

### Referências de Excelência
- Papers com código bem estruturado no Papers With Code
- Repositórios de papers aceitos no NeurIPS/ICML com "Outstanding Paper" tags
- Guidelines do Journal of Econometrics para material suplementar
- ACM Artifact Evaluation guidelines

---

## 📁 Estrutura Proposta (Nova Organização)

```
knowledge-distillation-economics/
│
├── README.md                          # ⭐ README principal (inglês)
├── README_PT.md                       # README em português
├── LICENSE                            # Licença MIT
├── CITATION.bib                       # Como citar o paper
├── .gitignore                         # Já existe, revisar
├── requirements.txt                   # Dependencies Python
├── environment.yml                    # Conda environment (alternativa)
├── setup.py                           # Instalação do pacote (opcional)
│
├── paper/                             # 📄 Paper LaTeX
│   ├── README.md                      # Como compilar o paper
│   ├── main.tex
│   ├── main.pdf                       # PDF compilado
│   ├── acmart.cls
│   ├── compile.sh
│   ├── sections/
│   │   ├── 01_introduction.tex
│   │   ├── 02_background.tex
│   │   ├── 03_design.tex
│   │   ├── 04_implementation.tex
│   │   ├── 05_evaluation.tex
│   │   ├── 06_discussion.tex
│   │   └── 07_conclusion.tex
│   ├── bibliography/
│   │   └── references.bib
│   ├── figures/                       # Figuras do paper
│   │   ├── architecture.pdf
│   │   └── results_*.pdf
│   └── tables/                        # Tabelas geradas
│       └── generated_tables.tex
│
├── experiments/                       # 🔬 Experimentos principais
│   ├── README.md                      # Documentação dos experimentos
│   ├── requirements.txt               # Dependencies específicas
│   │
│   ├── 01_german_credit/              # Experimento 1 (modularizado)
│   │   ├── README.md
│   │   ├── run_experiment.py
│   │   ├── config.yaml                # Configurações
│   │   ├── data/
│   │   │   ├── README.md              # Como baixar dados
│   │   │   ├── download_data.sh       # Script automático
│   │   │   └── .gitkeep
│   │   ├── results/
│   │   │   ├── metrics.json
│   │   │   ├── models.pkl
│   │   │   └── plots/
│   │   └── logs/
│   │       └── .gitkeep
│   │
│   ├── 02_adult_income/               # Experimento 2 (modularizado)
│   │   ├── README.md
│   │   ├── run_experiment.py
│   │   ├── config.yaml
│   │   ├── data/
│   │   ├── results/
│   │   └── logs/
│   │
│   ├── shared/                        # Código compartilhado
│   │   ├── __init__.py
│   │   ├── data_loaders.py
│   │   ├── preprocessing.py
│   │   ├── economic_constraints.py
│   │   ├── distillation_engine.py
│   │   ├── evaluation.py
│   │   ├── visualization.py
│   │   └── utils.py
│   │
│   ├── run_all_experiments.sh         # ⚡ Runner principal
│   ├── generate_paper_artifacts.py    # Gera tabelas/figuras p/ paper
│   └── validate_results.py            # Valida resultados esperados
│
├── src/                               # 📦 Código fonte reutilizável (opcional)
│   ├── economic_distillation/
│   │   ├── __init__.py
│   │   ├── constraints.py
│   │   ├── distiller.py
│   │   ├── stability.py
│   │   └── metrics.py
│   └── setup.py
│
├── notebooks/                         # 📓 Jupyter notebooks exploratórios
│   ├── README.md
│   ├── 01_exploratory_analysis.ipynb
│   ├── 02_constraint_visualization.ipynb
│   └── 03_results_analysis.ipynb
│
├── docs/                              # 📚 Documentação adicional
│   ├── METHODOLOGY.md                 # Detalhes metodológicos
│   ├── DATASETS.md                    # Descrição detalhada dos datasets
│   ├── REPRODUCIBILITY.md             # Guia de reprodução completo
│   ├── FAQ.md                         # Perguntas frequentes
│   └── TROUBLESHOOTING.md             # Solução de problemas comuns
│
├── tests/                             # 🧪 Testes automatizados (opcional)
│   ├── test_constraints.py
│   ├── test_distillation.py
│   └── test_metrics.py
│
├── scripts/                           # 🛠️ Scripts utilitários
│   ├── setup_environment.sh           # Setup completo do ambiente
│   ├── download_all_data.sh           # Download de todos os datasets
│   ├── reproduce_all_results.sh       # Reprodução completa
│   ├── check_dependencies.py          # Verifica se tudo está instalado
│   └── compare_results.py             # Compara resultados com baseline
│
├── results/                           # 📊 Resultados pré-computados
│   ├── README.md                      # Explicação dos resultados
│   ├── baseline_results.json          # Resultados esperados (checksums)
│   ├── german_credit_results.json
│   ├── adult_income_results.json
│   └── figures/                       # Figuras prontas
│       ├── figure1_architecture.pdf
│       ├── figure2_results.pdf
│       └── ...
│
├── docker/                            # 🐳 Docker para reprodução (opcional)
│   ├── Dockerfile
│   ├── docker-compose.yml
│   └── README.md
│
└── .github/                           # GitHub specific
    ├── workflows/
    │   └── run_experiments.yml        # CI/CD para rodar experimentos
    └── ISSUE_TEMPLATE/
        └── reproduction_issue.md
```

---

## 📝 Tarefas Detalhadas

### Fase 1: Organização e Estruturação (Alta Prioridade)

#### 1.1 Reorganizar Estrutura de Diretórios
- [ ] Renomear `POR/` → `paper/`
- [ ] Mover `experiments/` para nova estrutura modularizada
- [ ] Criar `01_german_credit/` e `02_adult_income/` como subpastas
- [ ] Criar pasta `shared/` para código compartilhado
- [ ] Extrair código comum dos experimentos para módulos reutilizáveis
- [ ] Criar pasta `docs/` para documentação
- [ ] Criar pasta `scripts/` para utilitários
- [ ] Criar pasta `results/` para resultados pré-computados

#### 1.2 Refatorar Código dos Experimentos
- [ ] Separar `01_german_credit_experiment.py` em:
  - `run_experiment.py` (script principal)
  - `config.yaml` (parâmetros configuráveis)
  - Funções movidas para `shared/`
- [ ] Separar `02_adult_income_experiment.py` similarmente
- [ ] Criar `shared/data_loaders.py` para funções de carregamento
- [ ] Criar `shared/preprocessing.py` para pré-processamento
- [ ] Criar `shared/economic_constraints.py` para restrições econômicas
- [ ] Criar `shared/distillation_engine.py` para lógica de distilação
- [ ] Criar `shared/evaluation.py` para métricas e avaliação
- [ ] Criar `shared/visualization.py` para gráficos
- [ ] Adicionar docstrings completas a todas as funções
- [ ] Adicionar type hints (Python 3.9+)

#### 1.3 Criar Arquivos de Configuração
- [ ] `requirements.txt` completo com versões específicas
- [ ] `environment.yml` para conda
- [ ] `config.yaml` para cada experimento
- [ ] `.gitattributes` para Git LFS (se necessário para dados grandes)

---

### Fase 2: Documentação (Alta Prioridade)

#### 2.1 README Principal (README.md)
- [ ] Título e badges (Paper, License, Python Version, etc.)
- [ ] Abstract do paper
- [ ] Ilustração visual (arquitetura do framework)
- [ ] Quick start (instalação em 3 passos)
- [ ] Estrutura do repositório
- [ ] Como reproduzir resultados
- [ ] Como citar o paper
- [ ] Links para paper, arXiv, documentação
- [ ] Seção de contribuidores
- [ ] Licença

**Template Inspiração**:
```markdown
# Knowledge Distillation for Economics

[![Paper](https://img.shields.io/badge/Paper-PDF-red)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)]()
[![Python 3.9+](https://img.shields.io/badge/python-3.9+-blue.svg)]()

> **Trading Complexity for Interpretability in Econometric Models**

Official implementation of "Knowledge Distillation for Economics" (Journal of Econometrics, 2025).

[Paper] | [arXiv] | [Docs] | [Demo]

![Framework Overview](docs/images/architecture.png)

## 🚀 Quick Start

```bash
# Clone repository
git clone https://github.com/yourusername/knowledge-distillation-economics.git
cd knowledge-distillation-economics

# Install dependencies
pip install -r requirements.txt

# Run experiments
cd experiments
./run_all_experiments.sh
```

## 📊 Results

Our framework achieves:
- ✅ 97.8% accuracy retention vs. complex teacher models
- ✅ 95%+ economic constraint compliance
- ✅ Coefficient stability (CV < 0.15)

...
```

#### 2.2 Documentação dos Experimentos
- [ ] `experiments/README.md` completo
- [ ] `experiments/01_german_credit/README.md`
- [ ] `experiments/02_adult_income/README.md`
- [ ] Documentar cada dataset (fonte, features, preprocessing)
- [ ] Documentar restrições econômicas implementadas
- [ ] Documentar métricas de avaliação
- [ ] Adicionar tempo estimado de execução
- [ ] Adicionar requisitos de hardware

#### 2.3 Guias de Reprodução
- [ ] `docs/REPRODUCIBILITY.md` - Guia completo passo-a-passo
  - Seção 1: Requisitos de sistema
  - Seção 2: Instalação do ambiente
  - Seção 3: Download dos dados
  - Seção 4: Execução dos experimentos
  - Seção 5: Validação dos resultados
  - Seção 6: Troubleshooting
- [ ] `docs/DATASETS.md` - Descrição detalhada de cada dataset
- [ ] `docs/METHODOLOGY.md` - Detalhes metodológicos adicionais
- [ ] `docs/FAQ.md` - Perguntas frequentes

#### 2.4 Documentação do Paper
- [ ] `paper/README.md` - Como compilar o LaTeX
- [ ] Documentar dependências do LaTeX
- [ ] Adicionar script de compilação automática

---

### Fase 3: Automatização e Scripts (Média Prioridade)

#### 3.1 Scripts de Setup
- [ ] `scripts/setup_environment.sh`
  - Verifica versão do Python
  - Cria virtualenv
  - Instala dependencies
  - Verifica instalação
- [ ] `scripts/download_all_data.sh`
  - Download de German Credit via OpenML
  - Download de Adult Income
  - Validação de checksums
  - Preprocessing inicial
- [ ] `scripts/check_dependencies.py`
  - Verifica todas as bibliotecas
  - Verifica versões
  - Reporta problemas

#### 3.2 Scripts de Reprodução
- [ ] Melhorar `run_all_experiments.sh`
  - Adicionar logging mais detalhado
  - Adicionar timestamps
  - Salvar logs estruturados
  - Progress bars
  - Validação de resultados
  - Comparação com baseline
- [ ] `scripts/reproduce_all_results.sh` (wrapper completo)
  - Setup do ambiente
  - Download dos dados
  - Execução dos experimentos
  - Geração de artefatos do paper
  - Validação final

#### 3.3 Geração de Artefatos do Paper
- [ ] Melhorar `generate_latex_tables.py`
  - Adicionar mais tabelas
  - Formatação LaTeX melhorada
  - Suporte para diferentes journals
- [ ] Criar `generate_paper_figures.py`
  - Gera todas as figuras do paper
  - Formato PDF/EPS de alta qualidade
  - Estilos consistentes
- [ ] `experiments/generate_paper_artifacts.py` (consolidado)

#### 3.4 Validação de Resultados
- [ ] `experiments/validate_results.py`
  - Compara resultados com baseline esperado
  - Tolerâncias para variação estatística
  - Reporta diferenças significativas
  - Gera relatório de validação
- [ ] `scripts/compare_results.py`
  - Versão standalone para comparação

---

### Fase 4: Melhorias de Código (Média Prioridade)

#### 4.1 Modularização
- [ ] Extrair classes reutilizáveis
- [ ] Criar `EconomicDistiller` class
- [ ] Criar `ConstraintValidator` class
- [ ] Criar `StabilityAnalyzer` class
- [ ] Criar `ResultsReporter` class

#### 4.2 Configuração via YAML
- [ ] Criar `experiments/01_german_credit/config.yaml`:
```yaml
experiment:
  name: "German Credit - Credit Risk"
  random_state: 42

data:
  source: "openml"
  dataset_id: "credit-g"
  test_size: 0.2

teacher:
  model: "GradientBoosting"
  params:
    n_estimators: 100
    max_depth: 5

student:
  model: "LogisticRegression"
  params:
    max_iter: 1000

constraints:
  - feature: "income"
    type: "sign"
    value: -1
    justification: "Higher income -> Lower default risk"
  - feature: "age"
    type: "monotonicity"
    direction: "decreasing"
    bounds: [18, 65]

evaluation:
  metrics: ["auc", "accuracy", "f1"]
  bootstrap_samples: 500
  stability_threshold: 0.15
```

#### 4.3 Logging e Debugging
- [ ] Adicionar logging estruturado (Python `logging`)
- [ ] Criar diferentes níveis de verbosidade
- [ ] Salvar logs em arquivos estruturados
- [ ] Adicionar timestamps em todos os logs

#### 4.4 Tratamento de Erros
- [ ] Try-catch adequados
- [ ] Mensagens de erro claras
- [ ] Fallbacks quando possível
- [ ] Validação de inputs

---

### Fase 5: Resultados e Visualizações (Média Prioridade)

#### 5.1 Resultados Pré-computados
- [ ] Rodar todos os experimentos e salvar resultados
- [ ] Criar `results/baseline_results.json` com resultados esperados
- [ ] Documentar variação esperada (devido a randomness)
- [ ] Adicionar checksums para validação

#### 5.2 Visualizações
- [ ] Criar visualizações de alta qualidade
- [ ] Gráficos de comparação de modelos
- [ ] Plots de estabilidade de coeficientes
- [ ] Heatmaps de compliance
- [ ] ROC curves
- [ ] Marginal effects plots
- [ ] Salvar em formato vetorial (PDF/SVG)

#### 5.3 Notebooks Exploratórios
- [ ] `notebooks/01_exploratory_analysis.ipynb`
  - Análise exploratória dos datasets
  - Estatísticas descritivas
  - Visualizações iniciais
- [ ] `notebooks/02_constraint_visualization.ipynb`
  - Visualização das restrições econômicas
  - Análise de compliance
- [ ] `notebooks/03_results_analysis.ipynb`
  - Análise detalhada dos resultados
  - Comparações entre modelos
  - Análise de sensibilidade

---

### Fase 6: Extras e Polimento (Baixa Prioridade)

#### 6.1 Docker Support
- [ ] Criar `Dockerfile`
- [ ] Criar `docker-compose.yml`
- [ ] Documentar uso do Docker
- [ ] Testar reprodução completa via Docker

#### 6.2 CI/CD
- [ ] Configurar GitHub Actions
- [ ] Workflow para rodar experimentos
- [ ] Workflow para build do paper LaTeX
- [ ] Workflow para testes (se houver)

#### 6.3 Testes Automatizados
- [ ] Unit tests para funções principais
- [ ] Integration tests para pipeline completo
- [ ] Smoke tests para validação rápida

#### 6.4 Website/Demo
- [ ] Criar página web simples (GitHub Pages)
- [ ] Demo interativa (Streamlit/Gradio)
- [ ] Documentação online (MkDocs)

#### 6.5 Licença e Citação
- [ ] Adicionar LICENSE file (MIT)
- [ ] Criar CITATION.bib
- [ ] Adicionar instruções de citação
- [ ] Criar CITATION.cff (GitHub citation)

---

## 🎨 Melhorias Estéticas

### README.md
- [ ] Adicionar badges (Paper, License, Python, Stars, etc.)
- [ ] Adicionar GIF/imagem de demonstração
- [ ] Usar emojis para seções (de forma moderada e profissional)
- [ ] Adicionar tabela de conteúdos
- [ ] Highlight dos principais resultados

### Código
- [ ] Formatação consistente (black, isort)
- [ ] Docstrings em formato Google/NumPy
- [ ] Type hints completos
- [ ] Comentários explicativos

### Documentação
- [ ] Diagramas de arquitetura
- [ ] Flowcharts de processos
- [ ] Screenshots de resultados
- [ ] Tabelas comparativas

---

## 📊 Checklist de Publicação Científica

### Essencial para Journals de Econometria
- [ ] Código fonte completo e comentado
- [ ] Dados públicos ou sintéticos com mesma estrutura
- [ ] Scripts para reproduzir TODAS as tabelas do paper
- [ ] Scripts para reproduzir TODAS as figuras do paper
- [ ] Documentação de versões de software
- [ ] Seed fixo para reprodutibilidade
- [ ] Tempo estimado de execução
- [ ] Requisitos de hardware

### Boas Práticas ACM/IEEE
- [ ] README com quick start
- [ ] Documentação completa
- [ ] Licença clara (MIT recomendado)
- [ ] CITATION file
- [ ] Testes automatizados (se aplicável)
- [ ] Issue templates
- [ ] Contributing guidelines (se aceitar contribuições)

### Papers With Code Standards
- [ ] README.md com badges
- [ ] requirements.txt
- [ ] Resultados reproduzíveis
- [ ] Instruções de execução claras
- [ ] Link para paper/arXiv

---

## 🚀 Ordem de Execução Recomendada

### Sprint 1: Essencial para Submissão (1-2 dias)
1. Criar README.md principal completo
2. Criar requirements.txt com versões
3. Melhorar documentation dos experimentos
4. Criar scripts/reproduce_all_results.sh
5. Testar reprodução completa
6. Adicionar CITATION.bib e LICENSE

### Sprint 2: Organização e Modularização (2-3 dias)
1. Refatorar estrutura de diretórios
2. Modularizar código dos experimentos
3. Criar configurações YAML
4. Extrair código compartilhado
5. Adicionar logging estruturado

### Sprint 3: Documentação Avançada (1-2 dias)
1. Criar docs/REPRODUCIBILITY.md
2. Criar docs/DATASETS.md
3. Criar docs/METHODOLOGY.md
4. Criar docs/FAQ.md
5. Melhorar READMEs individuais

### Sprint 4: Automação e Validação (1-2 dias)
1. Scripts de setup automatizado
2. Scripts de download de dados
3. Script de validação de resultados
4. Melhorar geração de artefatos do paper

### Sprint 5: Visualizações e Resultados (1 dia)
1. Gerar visualizações de alta qualidade
2. Criar notebooks exploratórios
3. Pré-computar resultados baseline
4. Documentar resultados esperados

### Sprint 6: Polimento e Extras (opcional, 1-2 dias)
1. Docker support
2. CI/CD
3. Testes automatizados
4. Website/Demo

---

## 📈 Métricas de Sucesso

### Reprodutibilidade
- [ ] Outra pessoa consegue reproduzir resultados em < 30 minutos
- [ ] Reprodução funciona em 3 sistemas diferentes (Windows, Mac, Linux)
- [ ] Resultados estão dentro de 5% dos valores reportados no paper

### Documentação
- [ ] README principal tem < 100 linhas mas cobre tudo essencial
- [ ] Todas as seções do README respondem pergunta "Como faço X?"
- [ ] Documentação técnica cobre edge cases e troubleshooting

### Código
- [ ] Código modular e reutilizável
- [ ] Docstrings completas em todas as funções
- [ ] Zero warnings ao executar experimentos
- [ ] Logging adequado em todos os passos

### Profissionalismo
- [ ] Repositório passa impressão de trabalho sério e profissional
- [ ] Commits bem estruturados com mensagens claras
- [ ] Issues e PRs bem documentados (se houver)
- [ ] Resposta rápida a perguntas (se público)

---

## 🎯 Resultado Final Esperado

Um repositório que:

1. **Qualquer pesquisador** consegue clonar e reproduzir resultados em < 30 min
2. **Reviewers** encontram tudo que precisam para validar o paper
3. **Praticantes** conseguem adaptar o código para seus problemas
4. **Comunidade** pode construir em cima do framework
5. **Você** se orgulha de compartilhar e usar como portfolio

---

## 📚 Referências e Inspirações

### Repositórios Exemplares
- [facebookresearch/fairseq](https://github.com/facebookresearch/fairseq)
- [openai/gpt-2](https://github.com/openai/gpt-2)
- [google-research/bert](https://github.com/google-research/bert)
- [Papers With Code - Best Practices](https://paperswithcode.com/about)

### Guidelines
- [NeurIPS Code Submission Guidelines](https://neurips.cc/Conferences/2024/CallForPapers)
- [ACM Artifact Review and Badging](https://www.acm.org/publications/policies/artifact-review-and-badging-current)
- [Journal of Econometrics Replication Policy](https://www.journals.elsevier.com/journal-of-econometrics)

---

**Autor do Plano**: Claude Code
**Data**: 2025-12-10
**Versão**: 1.0
**Status**: 📋 Planejamento Completo - Pronto para Execução
