# Linear Algebra Foundations & Pseudoinverse-Based Linear Modeling

This project demonstrates two core achievements in classical machine learning theory and numerical linear algebra.

---

## 1. Proving a Fundamental Rank Identity in Linear Models

We establish the important result:

$$
\text{rank}(X) = \text{rank}(X^\top X)
$$

### Why this matters:

- The matrix X and the matrix (X transpose times X) share the same null space.

- If X * v = 0, then:

$$
X^\top X \, v = 0
$$

- If (X transpose X) * v = 0, then:

$$
v^\top X^\top X \, v = \| Xv \|^2 = 0
$$

which implies:

$$
Xv = 0
$$

Because both matrices have the same null space, they have the same nullity, and therefore the same rank (by the rank–nullity theorem). This explains why the normal-equation matrix (X transpose X) preserves the full information content of X.

---

## 2. Implementing the Moore–Penrose Pseudoinverse via SVD

I implemented a custom pseudoinverse function using the singular value decomposition:

$$
X = U \Sigma V^\top
$$

The pseudoinverse is constructed by inverting only the non-zero singular values:

$$
X^{+} = V \Sigma^{+} U^\top
$$

This mirrors the numerical method used in scientific computing libraries and demonstrates full understanding of the underlying linear algebra.

---

## 3. Linear Regression Using the Pseudoinverse

The regression coefficients are computed as:

$$
\hat{\beta} = X^{+} y
$$

Fitted values:

$$
\hat{y} = X \hat{\beta}
$$

Residuals:

$$
r = y - \hat{y}
$$

Because this procedure uses the SVD-based pseudoinverse, it remains valid even when:

- (X transpose X) is singular  
- the columns of X are collinear  
- the system is underdetermined  
- the number of features exceeds the number of observations  

This produces the minimum-norm least-squares solution commonly used in high-dimensional regression.

---

## What This Project Demonstrates

- Strong understanding of linear algebra foundations of ML  
- Ability to prove important matrix identities  
- Ability to implement numerical linear algebra algorithms from scratch  
- Practical skill in fitting linear models when ordinary least squares fails  

---

## Included Components

- Proof of the rank identity  
- Manual SVD-based pseudoinverse implementation  
- Linear regression solver using the pseudoinverse  
- Computation of coefficients, predictions, and residuals  
