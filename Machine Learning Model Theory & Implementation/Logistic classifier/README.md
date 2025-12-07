# Logistic Regression Optimization: Gradient Descent, Newton’s Method, and Convergence Analysis

This project explores numerical optimization methods for logistic regression. I implemented both gradient descent (with backtracking line search) and Newton’s method, visualized their optimization trajectories, and compared their convergence behavior.

---

## 1. Implementing Gradient Descent With Backtracking Line Search

I coded a custom gradient descent optimizer for logistic regression.  
The logistic loss minimized is:

$$
L(w) = -\frac{1}{N} \sum_{i=1}^N \left[ y_i \log(\sigma(w^\top x_i)) + (1 - y_i)\log(1 - \sigma(w^\top x_i)) \right]
$$

where:

$$
\sigma(z) = \frac{1}{1 + e^{-z}}
$$

### Key achievements:

- Implemented gradient computation analytically.
- Implemented backtracking line search to automatically select a stable step size.
- Ensured monotonic decrease of the logistic loss.
- Collected all intermediate weight vectors at each iteration.

The optimizer successfully converges toward the same solution found in the reference file “logistic-regression.pdf.”

---

## 2. Matching the Solution From the Reference Implementation

Using my gradient descent implementation:

- The final weight vector closely matches the solution obtained via **fmin_tnc**.
- The loss value at convergence matches to numerical precision.
- The weight trajectories show clean, stable progress toward the optimum.

This confirms that the custom implementation is correct and numerically reliable.

---

## 3. Visualizing Optimization Paths on Loss Contours

I plotted:

- The contours of the logistic loss function  
- The sequence of weight vectors produced by gradient descent  

### Achievements:

- The plotted path shows steady, smooth movement toward the minimum.
- Early steps are larger, while later steps shrink as the optimizer approaches the optimum.
- Backtracking line search prevents overshooting and ensures stability.

These visualizations illustrate how gradient descent explores the landscape of the logistic loss.

---

## 4. Implementing Newton’s Method Using the Exact Hessian

Newton’s update is:

$$
w_{\text{new}} = w - H^{-1} \nabla L(w)
$$

where:

- \( \nabla L(w) \) is the gradient  
- \( H \) is the exact Hessian of the logistic loss  

### Key achievements:

- Derived and coded the Hessian for logistic regression.
- Implemented stable numerical inversion of the Hessian.
- Generated a full sequence of Newton updates and plotted them on the same contour plot.

---

## 5. Comparing Gradient Descent and Newton’s Method

### Convergence behavior:

- **Newton’s method converges significantly faster** than gradient descent.
- Gradient descent required many small steps, while Newton’s method reached the optimum in only a few iterations.
- Newton’s method finds the same final weight vector as gradient descent and fmin_tnc.

### Effect of backtracking:

- Backtracking **helps gradient descent** by stabilizing step sizes.
- For Newton’s method:
  - Backtracking can prevent divergence when far from the optimum.
  - Once close to the optimum, Newton’s method prefers full steps and achieves quadratic convergence.

### Overall conclusion:

- Gradient descent is simple and reliable, but slow.  
- Newton’s method is dramatically faster when the Hessian is well-conditioned and accurately computed.  
- Both methods reach the correct logistic regression solution, but their paths and efficiency differ substantially.

---

## What This Project Demonstrates

- Ability to implement custom optimization algorithms for logistic regression.  
- Understanding of gradient-based updates, backtracking line search, and convergence criteria.  
- Ability to derive and use the exact Hessian in Newton’s method.  
- Skill in visualizing optimization paths on contour plots.  
- Insight into the strengths and weaknesses of first-order vs. second-order optimization.

---

## Included Components

- Gradient descent optimizer with backtracking line search  
- Newton’s method with exact Hessian  
- Visualization of optimization steps on contour plots  
- Comparison of convergence speed, stability, and accuracy  
- Final conclusions on the numerical behavior of both methods  
