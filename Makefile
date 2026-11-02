.PHONY: help init dirs install clean test

SHELL := /bin/bash

help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

init: dirs install ## Initialize the entire project (directories + virtualenv + dependencies)

dirs: ## Create the project directory structure
	@echo "Creating project directory structure..."
	@mkdir -p configs docs data models evaluation scripts tests
	@touch configs/base_config.yaml configs/quant_sweep.yaml configs/calibration_fixes.yaml
	@touch data/__init__.py data/dataloaders.py data/preprocessing.py
	@touch models/__init__.py models/loaders.py models/quantizers.py models/calibration.py
	@touch evaluation/__init__.py evaluation/metrics.py evaluation/analysis.py
	@touch scripts/01_baseline_eval.py scripts/02_quantization_sweep.py scripts/03_apply_calibration_fix.py scripts/04_generate_paper_plots.py
	@touch tests/test_metrics.py tests/test_quantizers.py
	@touch docs/novelty_memo.md
	@if [ ! -f pyproject.toml ]; then touch pyproject.toml; fi
	@if [ ! -f README.md ]; then echo "# Quantization Calibration Time-Series" > README.md; fi
	@echo "Directory structure created successfully!"

install: ## Set up virtual environment and install dependencies via uv
	@echo "Setting up Python environment and installing dependencies with uv..."
	@uv venv --python 3.11
	@uv sync
	@echo "Environment setup complete! Run 'source .venv/bin/activate' to activate."

clean: ## Remove build artifacts, cache, and temporary files
	@echo "Cleaning up caches and build artifacts..."
	@rm -rf .pytest_cache .ruff_cache __pycache__ .venv
	@find . -type d -name "__pycache__" -exec rm -r {} +
	@find . -type f -name "*.pyc" -delete
	@echo "Cleanup complete."