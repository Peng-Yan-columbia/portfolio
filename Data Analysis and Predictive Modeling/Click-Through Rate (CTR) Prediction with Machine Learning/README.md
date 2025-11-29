# Click-Through Rate (CTR) Prediction – Summary

This project builds a predictive model for Click-Through Rate (CTR) using a structured, two-stage machine-learning pipeline. The goal is to produce accurate CTR predictions for a Kaggle competition evaluated by RMSE.

---

## 🔍 1. Exploratory Data Analysis (EDA)

I performed a detailed exploration of the dataset to understand variable behavior and modeling challenges:

### Data Understanding & Structure
- Reviewed predictor descriptions and variable types (numeric, categorical, binary).
- Inspected missing values, outliers, and skewed distributions.
- Checked correlations and potential multicollinearity.

### Visual Insights
- Histograms and KDE plots to detect skew and heavy tails.
- Boxplots to compare distributions across categories.
- Correlation heatmaps to identify important relationships.

### Key Findings
- CTR is highly imbalanced: the majority of records have **CTR = 0**.
- Non-zero CTR values are small and continuous, requiring a specialized approach.
- Many predictors benefit from transformations:
  - mean-centering  
  - scaling  
  - log/sqrt transforms  
- Some categorical variables required encoding and cardinality reduction.

---

## 🧱 2. Feature Engineering
- Imputed missing values where appropriate.  
- Standardized or transformed skewed numeric variables.  
- One-hot encoded categorical variables.  
- Removed non-informative or redundant features.  
- Created transformed features for nonlinear patterns.  

---

## 🤖 3. Final Two-Stage Embedding Model

Because CTR has many zeros and a small subset of positive values, I used a **two-stage modeling framework**:

### **Stage 1 — Binary Model: Predict CTR = 0 or CTR > 0**
- Trained a classification model to predict the probability of a non-zero CTR.
- Handled imbalance using class weighting / sampling if needed.
- Output:  
  **P(non-zero CTR)**

### **Stage 2 — Regression Model: Predict Numeric CTR for Non-Zero Observations**
- Trained a regression model **only on rows with CTR > 0**.
- Predicted the continuous CTR level (for positive CTR ads).
- Output:  
  **Predicted CTR value (conditional on CTR > 0)**

### **Final CTR Prediction**
$$
\text{Final CTR} = P(\text{non-zero}) \cdot \hat{CTR}_{positive}
$$

This embedding (hurdle-style) model improves performance by:
- Separating classification of engagement from continuous CTR magnitude  
- Reducing the effect of extreme imbalance  
- Allowing different algorithms to specialize for each task  

---

## 📉 4. Model Tuning & Comparison
- Evaluated multiple models (linear, tree-based, boosting).
- Used cross-validation to avoid overfitting.
- Tuned hyperparameters targeting RMSE.
- Selected the best combination for the two-stage pipeline.

---

## 🚀 5. Kaggle Submission
- ranked 17th in public and 19th in private.
https://www.kaggle.com/competitions/predicting-clicks/leaderboard?
- Generated predictions for the scoring dataset using the final embedding model.
- Formatted results into `submission.csv`.
- Submitted to Kaggle leaderboard for RMSE evaluation.

---

## 📦 6. Outcome
A complete CTR prediction workflow including:
- Full EDA  
- Feature engineering  
- A two-stage model separating zero vs non-zero prediction  
- A regression model for positive CTR  
- Final combined embedding model used for Kaggle scoring  

This project demonstrates strong predictive modeling skills and handling of imbalanced, mixed-type real-world data.
