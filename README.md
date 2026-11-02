# edge-probabilistic-ts

Investigating whether model compression (quantization from 8 down to 2 bits) breaks probabilistic calibration in time-series foundation models for edge deployment.

## Research Question
When you quantize or prune probabilistic time-series foundation models (Chronos-Bolt, TimesFM-2.5, Moirai, Tiny Time Mixers), do their prediction intervals stay trustworthy, and can you fix them cheaply?

## Contributions
- **Systematic Study:** Evaluates CRPS, empirical coverage, and interval width across bit-widths.
- **Mitigation:** Calibration-aware PTQ objectives (preserving pinball loss) or lightweight conformal correction.
- **Theory:** Bounds the coverage gap as a function of quantization error.

## Context
Extends recent findings on point-accuracy quantization ([arXiv:2609.05408](https://arxiv.org/pdf/2609.05408)) to probabilistic calibration and outer quantile distortion in edge forecasting.