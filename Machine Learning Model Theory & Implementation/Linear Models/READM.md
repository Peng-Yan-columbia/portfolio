# Linear Algebra Foundations & Pseudoinverse-Based Linear Modeling

This project demonstrates two core achievements in classical machine learning theory and implementation:

---

## 🚀 1. Proving a Fundamental Rank Identity in Linear Models

I show that for any real matrix \(X\):

\[
\mathrm{rank}(X) = \mathrm{rank}(X^\top X)
\]

This result is essential in understanding why linear regression works even when solving the normal equations:

\[
X^\top X \, \beta = X^\top y
\]

Key insights established:

- \(X\) and \(X^\top X\) share the **same null space**, which implies equal rank via the **rank–nullity theorem**.
- The matrix \(X^\top X\) cannot reduce the dimensionality of the problem; it preserves the effective information contained in \(X\).
- This property justifies using \(X^\top X\) in theoretical derivations (e.g., least squares, projection operators, identifiability).

---

## 🧮 2. Implementing the Moore–Penrose Pseudoinverse via SVD

I implemented a custom function `pinv()` using the singular value decomposition (SVD):

- Performs full SVD:  
  \[
  X = U \Sigma V^\top
  \]
- Inverts only non-zero singular values.
- Constructs the pseudoinverse:  
  \[
  X^+ = V \Sigma^+ U^\top
  \]

This mirrors the method used in numerical linear algebra libraries, but coded manually to demonstrate understanding.

---

## 📈 3. Building a Linear Regression Solver That Works Even When \(X^\top X\) Is Singular

Using `pinv()`, I built a fully functional linear regression routine that:

- Computes coefficients using  
  \[
  \hat{\beta} = X^+ y
  \]
- Produces fitted values and residuals.
- Works reliably in cases where:

  - Columns of \(X\) are collinear  
  - The system is underdetermined (more features than observations)  
  - The normal equations have **no standard inverse**

This approach reproduces the minimum-norm least-squares solution used in high-dimensional regression and modern ML models.

---

## 🎯 What This Project Demonstrates

- Mastery of key linear algebra concepts behind machine learning.
- Ability to prove structural properties of matrices used in statistical models.
- Ability to build numerical algorithms from scratch (SVD → pseudoinverse → regression).
- Practical understanding of how to solve linear models in singular, ill-conditioned, or high-dimensional settings.

---

## 📁 Included Components

- Proof of the rank identity  
- Custom pseudoinverse implementation  
- Linear regression function using SVD-based pseudoinverse  
- Example fits, residual calculation, and validation  

---

If you’d like, I can also help you write:

✅ A README for the entire folder (“Machine Learning Model Theory”)  
✅ A unified summary for OLS, LASSO, Kalman filter, etc.  
✅ Clean naming or restructuring for your GitHub repo  

Just tell me — I’d be thrilled to help polish the whole thing!

