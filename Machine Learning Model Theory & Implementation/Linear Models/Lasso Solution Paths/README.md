# LASSO Solution Path via Coordinate Descent & Simulation Validation

This project demonstrates the ability to implement the full LASSO solution path from scratch using cyclic coordinate descent, apply algorithmic optimizations for computational efficiency, and validate the implementation against the industry-standard `glmnet` package.

---

## 🚀 1. Implementing the LASSO Solution Path via Cyclic Coordinate Descent

I implemented a complete LASSO solver that computes the coefficient path for a sequence of regularization values \( \lambda \).

The algorithm optimizes:

$$
\min_{\beta} \; \frac{1}{2N} \| y - X\beta \|_2^2 + \lambda \|\beta\|_1
$$

### Key achievements:

- Implemented **cyclic coordinate descent**, updating one coefficient at a time.
- Used the **soft-thresholding operator** for the coordinate update:

$$
\beta_j \leftarrow S\!\left( \frac{1}{N} X_j^\top \left( y - X_{-j}\beta_{-j} \right), \lambda \right),
$$

where

$$
S(z, \lambda) = \text{sign}(z) \cdot \max(|z| - \lambda, 0).
$$

- Computed the **full solution path** across a grid of \( \lambda \) values.
- Implemented the **speedup via precomputation**:

  - Stored \( X_j^\top X_j \) and \( X_j^\top y \) for all coordinates.
  - Avoided repeatedly recomputing residuals or dot-products.

These enhancements significantly reduce computation time and match the optimization strategy used in `glmnet`.

---

## 🧪 2. Simulating Data from a Known Linear Model

To test the correctness of the implementation, I generated synthetic data from a known sparse linear model:

$$
y = 3x_1 - 2x_4 + x_7 + \epsilon,
$$

with noise \( \epsilon \sim N(0, 1) \), and \( N = 1000 \) samples.

### Achievements:

- Created controlled data with known ground-truth coefficients.
- Ensured reproducibility via a random seed.
- Generated predictors and response variables consistent with the theoretical model.

---

## 📈 3. Verifying the Solution Path Against `glmnet`

I compared my cyclic coordinate descent solution path with the path produced by the `glmnet` package (Hastie, Tibshirani, Friedman).

### Results:

- Both solution paths matched (up to numerical tolerance).
- Demonstrated that the custom implementation:
  - Correctly performs soft-thresholding updates.
  - Handles shrinking of coefficients as \( \lambda \) increases.
  - Produces the same sparsity pattern as `glmnet`.
  - Tracks coefficient evolution across the entire regularization path.

This confirms that the coordinate-descent implementation is correct and follows the same algorithmic principles used in state-of-the-art software.

---

## 🎯 What This Project Demonstrates

- Ability to implement the LASSO from first principles.
- Understanding of coordinate descent optimization for \( L_1 \)-regularized models.
- Use of efficient computation strategies (precomputed cross-products).
- Ability to generate synthetic datasets from a known model.
- Validation of algorithmic correctness by comparison with `glmnet`.

---

## 📁 Included Components

- Full cyclic coordinate descent implementation
- Precomputation-based speed improvement
- LASSO solution path generator across a sequence of \( \lambda \)
- Simulation of a known linear model
- Side-by-side comparison with `glmnet` solution paths

