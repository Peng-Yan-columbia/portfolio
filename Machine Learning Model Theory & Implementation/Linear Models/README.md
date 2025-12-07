# Linear Algebra Foundations & Pseudoinverse-Based Linear Modeling

This project demonstrates two core achievements in classical machine learning theory and numerical linear algebra.

---

## 🚀 1. Proving a Fundamental Rank Identity in Linear Models

I demonstrate the important result:

$$
\text{rank}(X) = \text{rank}(X^\top X)
$$

### Why this matters:

-$$\(X\)$$ and \(X^\top X\) share the **same null space**.
- If \(Xv = 0\), then \(X^\top X v = 0\).
- If \(X^\top X v = 0\), then:

$$
v^\top X^\top X v = \|Xv\|^2 = 0 \quad \Rightarrow \quad Xv = 0
$$

Since they share the same null space, they have identical nullity, and therefore the same rank (via the rank–nullity theorem).

This explains why the normal-equation matrix \(X^\top X\) preserves the information content of \(X\).

---

## 🧮 2. Implementing the Moore–Penrose Pseudoinverse via SVD

I implemented a custom pseudoinverse function using the singular value decomposition:

$$
X = U \Sigma V^\top
$$

The pseudoinverse is constructed by inverting only the non-zero singular values:

$$
X^{+} = V \Sigma^{+} U^\top
$$

This reproduces the behavior of numerical linear algebra libraries while showing full control of the underlying math.

---

## 📈 3. Linear Regression Using the Pseudoinverse

The regression coefficients are computed using:

$$
\hat{\beta} = X^{+} y
$$

The fitted values:

$$
\hat{y} = X \hat{\beta}
$$

The residuals:

$$
r = y - \hat{y}
$$

Because this relies on the SVD-based pseudoinverse, the method works even when:

- \(X^\top X\) is **singular**
- Columns of \(X\) are **collinear**
- The system is **underdetermined**
- The design matrix is **high-dimensional**

This yields the **minimum-norm least-squares solution** used widely in modern ML.

---

## 🎯 What This Project Demonstrates

- Strong understanding of linear algebra foundations in ML.
- Ability to prove matrix identities relevant to regression.
- Ability to implement numerical algorithms (SVD → pseudoinverse → regression).
- Practical skill in solving linear models when standard OLS fails.

---

## 📁 Included Components

- Proof of the rank identity  
- Custom pseudoinverse implementation  
- Regression solver based on SVD  
- Computation of fitted coefficients, predictions, and residuals  
