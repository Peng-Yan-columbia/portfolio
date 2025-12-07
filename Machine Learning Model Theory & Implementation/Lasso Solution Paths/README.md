# LASSO Solution Path via Coordinate Descent and Model Validation

This project showcases the full implementation of the LASSO solution path from scratch using cyclic coordinate descent, along with validation against the benchmark glmnet package.

---

## 1. Implementing the LASSO Solution Path

The goal is to compute the LASSO coefficient path across a sequence of regularization parameters (lambda values). The objective minimized is:

$$
\frac{1}{2N} \| y - X\beta \|_2^2 + \lambda \|\beta\|_1
$$

### Key achievements:

- Implemented **cyclic coordinate descent**, updating one coefficient at a time.
- Used the **soft-thresholding operator** for each coordinate update:

$$
S(z, \lambda) = \text{sign}(z) \cdot \max(|z| - \lambda, 0)
$$

- Computed the full solution path for a grid of lambda values.
- Added major **speed improvements**:
  - Precomputed X_j^T y for every column j.
  - Precomputed inner products X_j^T X_k.
  - Avoided recomputing full residuals inside the loop.

These optimizations replicate the approach used in glmnet and dramatically accelerate convergence.

---

## 2. Simulating Data From a Known Linear Model

To validate the implementation, I generated a synthetic dataset of 1000 observations from a linear model with known coefficients:

$$
y = 3x_1 - 2x_4 + x_7 + \epsilon
$$

where epsilon is Gaussian noise.

### Achievements in this step:

- Created data with a controlled sparse coefficient pattern.
- Ensured reproducibility with a fixed random seed.
- Used the simulated dataset to test whether the algorithm correctly recovers the coefficient path as lambda varies.

---

## 3. Verifying the Solution Path Against glmnet

The glmnet package (Hastie, Tibshirani, Friedman) is a widely accepted implementation of coordinate descent for LASSO.

### Validation results:

- The coefficient paths produced by my implementation match those of glmnet (up to numerical tolerance).
- The shrinkage behavior, sparsity pattern, and coefficient trajectories match exactly.
- This confirms that:
  - The coordinate descent updates were implemented correctly.
  - The soft-thresholding operator behaves as expected.
  - The precomputation speedup matches the design of glmnet.

---

## What This Project Demonstrates

- Ability to implement LASSO from first principles.
- Understanding of coordinate descent optimization for L1-regularized models.
- Ability to generate synthetic data tailored to model evaluation.
- Skill in validating algorithms against industry-standard implementations.
- Practical understanding of sparsity, regularization paths, and numerical optimization.

---

## Included Components

- Coordinate descent LASSO solver  
- Efficient implementation using precomputed quantities  
- Full solution path across lambda values  
- Simulation of a sparse linear model  
- Side-by-side comparison with glmnet path results  
