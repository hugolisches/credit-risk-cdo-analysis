# Credit Risk and CDO Structuring

## Project Overview

This project was developed as part of a quantitative risk management course.

The goal was to analyze the credit risk of a bond portfolio and design a collateralized debt obligation (CDO) structure based on expected loss, Credit Value-at-Risk and tranche subordination.

The project combines credit risk modelling, portfolio analysis and structured finance.

## Main Topics

The project covers:

- expected loss calculations
- probability of default and recovery rates
- Credit Value-at-Risk
- portfolio diversification
- CDO tranche structuring
- attachment and detachment points
- credit enhancement
- AAA tranche design
- tranche pricing and risk compensation

## Expected Loss

The expected loss of each bond is calculated based on:

Exposure × Probability of Default × (1 − Recovery Rate)

The individual expected losses are then aggregated to obtain the expected loss of the full bond portfolio.

The analysis also considers how losses should be allocated across the different CDO tranches, with the equity tranche acting as the first-loss position.

## Credit Value-at-Risk

The portfolio's default risk is assessed using Credit Value-at-Risk at different confidence levels.

The analysis considers:

- default probabilities
- recovery rates
- sector diversification
- portfolio concentration
- extreme portfolio loss scenarios

Credit VaR is then used as an input for determining how much subordination is required to protect the senior tranches.

## CDO Structure

A CDO structure is proposed by dividing the bond portfolio into:

- Equity Tranche
- Mezzanine Tranches
- Senior / AAA Tranche

The attachment and detachment points are chosen so that junior tranches absorb losses before they reach the senior tranche.

The objective is to create a senior tranche with strong credit protection while keeping it as large as reasonably possible.

## AAA Tranche

The project discusses several conditions required for a highly rated senior tranche, including:

- sufficient credit enhancement
- protection against extreme portfolio losses
- strong portfolio diversification
- clear payment priority
- robust legal and structural design

The size of the junior tranches is therefore linked to the tail risk of the underlying bond portfolio.

## Tranche Pricing

The project also considers how investors in the different tranches should be compensated for the risks they take.

Higher-risk tranches require higher expected returns, while the senior tranche can offer lower spreads due to its stronger protection against losses.

The analysis also considers compensation for:

- first-loss risk
- structuring
- modelling
- monitoring
- capital at risk

## Data

The bond portfolio used for the analysis is stored in:

```text
data/
└── BondPortfolio.xls
