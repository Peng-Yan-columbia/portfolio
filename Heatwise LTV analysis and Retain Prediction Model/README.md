# Heatwise Yoga Studio — Retention, LTV, Hierarchical Modeling, and Churn Prediction

This README documents what I built for the Heatwise project: a full retention + Lifetime Value (LTV) analysis, an extension using hierarchical (multi-level) modeling to separate studio effects from studio-age/seasonality noise, and a churn (retention-risk) prediction model that produces action-ready customer risk scores.

---

## 1) What I analyzed (end-to-end)

### 1.1 Core business questions
1. **Retention:** Where do customers drop off in the lifecycle (especially early churn)?
2. **Value:** Which segments produce higher LTV (Age Group, Studio Location, and their interaction)?
3. **Attribution:** Are observed studio differences “real,” or explained by **studio age (new vs. mature studio)** and time effects?
4. **Action:** Can we predict who will churn soon to prioritize outreach, offers, and operational interventions?

### 1.2 Data sources used
I built the analysis around three operational exports:
- **Customer file**: join date / first check-in, AgeGroup, Home Location (studio), membership indicators, etc.
- **Reservations / class attendance**: customer activity history (dates, location, attendance/cancel if available).
- **Orders / purchases**: spend history (dates, amount, location, product type if available).

These were merged at the customer level to create:
- A **customer lifecycle table** (timeline + segment labels)
- A **monthly activity / spend panel** for retention and LTV computation
- A **feature matrix** for churn prediction

---

## 2) Retention analysis (what I did)

### 2.1 Defined “activity” and lifecycle windows
I standardized retention measures using repeatable rules:
- A customer is **active** in a period if they have at least one attendance / reservation event in that period (or within a rolling window).
- I computed:
  - **First activity date** (cohort start)
  - **Monthly activity flags** (active in month t)
  - **Recency** (days since last activity)
  - **Frequency** (check-in counts over windows)

This enabled consistent comparisons across customers who joined at different times.

### 2.2 Cohort retention curves
I created retention curves using cohorts defined by join month / first check-in month:
- For each cohort, I computed the fraction of customers active after 1 month, 2 months, 3 months, etc.
- I produced:
  - **Overall retention curve**
  - Retention curves by **AgeGroup**
  - Retention curves by **Home Location**
  - (When sample sizes allowed) retention by **AgeGroup × Location**

**Why this matters:** it makes early churn visible and quantifies the “retention cliff” after onboarding.

### 2.3 Retention segmentation (behavioral buckets)
To support interpretation and downstream actions, I assigned customers to segments such as:
- **Early churn / one-and-done** (drops shortly after first month)
- **At-risk** (recent drop in check-ins / increasing inactivity)
- **Stable active** (consistent check-ins)
- **High engagement** (high frequency, often higher spend)

These segments were used to summarize LTV and to design intervention logic.

---

## 3) LTV analysis (what I did)

### 3.1 Built customer-level LTV metrics
I computed customer value using order data and mapped value into comparable metrics:
- **Total spend** (observed)
- **Spend in early lifecycle windows** (e.g., first 30/60/90 days)
- **Monthly spend rate** = total spend / months active (or observed months)
- **Lifetime duration proxies**:
  - months active
  - time between first and last activity
  - retention length based on inactivity rule

This supports segment comparisons that are not biased solely by tenure.

### 3.2 Segment-level comparisons
I produced LTV tables/charts comparing:
- **AgeGroup → LTV**
- **Home Location → LTV**
- **AgeGroup × Home Location → LTV**

For each segment, I reported:
- customer count
- mean/median LTV
- spread (e.g., quantiles)
- revenue concentration (share of total spend)

**Primary insight style:** older groups often show higher LTV; locations differ, but raw differences can be confounded by studio maturity.

### 3.3 Addressed confounding: studio maturity
A critical issue is that newer studios naturally have:
- shorter customer histories
- different marketing ramp
- different seasonal timing
- smaller samples

So I incorporated **studio open dates** (where available) and created:
- `Studio_Age_Years = (analysis_date - studio_open_date) / 365.25`

This became an explicit explanatory variable to avoid mislabeling “new studio” as “bad studio.”

---

## 4) Hierarchical (multi-level) modeling (what I did and why)

### 4.1 Motivation
Stakeholders asked questions like:
- “Is Studio A actually worse than Studio B?”
- “Or is Studio A newer / has fewer long-tenure customers / joined in a different season?”

A hierarchical model is ideal because:
- It **separates** population-level effects (age, season, studio age) from studio-to-studio variation.
- It **shrinks** noisy studio estimates toward the global mean when sample sizes are small.
- It improves interpretability and prevents overreacting to random fluctuations.

### 4.2 Conceptual model structure
I treated customers as nested within studios:

- **Level 1 (customer-level):** value depends on customer features (e.g., AgeGroup), lifecycle variables, and time/season proxies.
- **Level 2 (studio-level):** each studio has its own baseline effect, but studio effects are assumed to come from a shared distribution.

A typical structure I used conceptually:

- Outcome: `LTV` or `log1p(LTV)` (log transform improves stability due to heavy tails)
- Fixed effects:
  - AgeGroup indicators
  - `Studio_Age_Years`
  - season/time controls (month/quarter or join cohort controls)
- Random effects:
  - studio random intercept (studio baseline)
  - optionally studio random slope (if modeling age effect varying by studio)

### 4.3 What “splitting location vs age” means in practice
Without hierarchy, you might conclude:
- “Studio X has lower LTV”
But that could happen because:
- Studio X opened recently → customers have shorter observed lifetimes
- Studio X customers joined during lower-demand season
- small sample size → noisy mean

The hierarchical model lets me decompose:
- **AgeGroup effect**: how LTV shifts with age, averaged across studios
- **Studio effect**: how a studio differs after controlling for age and maturity
- **Studio-age effect**: how maturity changes expected LTV (ramp effect)

The output is:
- a **cleaner studio ranking** (posterior/estimated studio effects with shrinkage)
- uncertainty-aware comparisons (confidence/credible intervals if Bayesian; standard errors if frequentist mixed model)

### 4.4 Deliverables from the hierarchical component
- A table of **studio random effects** (baseline lift/dip vs global mean)
- Visual comparison:
  - raw mean LTV by studio vs adjusted studio effect
- Clear narrative:
  - “Some apparent studio differences shrink substantially after controlling for studio age and season”
  - “This indicates maturity confounds raw LTV comparisons”

---

## 5) Churn / retention prediction model (what I built)

### 5.1 Target definition (label)
I defined a churn label suitable for operational action:
- `status = 1` (churn) if customer becomes inactive beyond a chosen horizon
- `status = 0` (active) otherwise

This label was generated from reservation activity and an inactivity rule (e.g., no activity in the next N days/months).

### 5.2 Feature engineering (behavior + trends)
I engineered features capturing both level and change over time, especially early signals:

Core features used in my modeling notebook:
- `ratio_check_in`
- `ratio_spend`
- `second_month_checkin_days`
- `last_month_checkin_days`
- `last_month_spend`
- `second_month_spend`

Why these work:
- Churn is usually driven by **declining engagement**, not just low totals.
- Comparing second month vs last month captures **trajectory**.

I also applied basic cleaning:
- replace inf with NaN
- fill remaining missing with 0 (or controlled imputation)
- consistent window alignment per customer

### 5.3 Train/test methodology
- Split into train/test with **stratification** (preserve churn rate)
- Addressed imbalance using:
  - `scale_pos_weight` (neg/pos ratio)
- Trained a tree-based model (e.g., XGBoost) as the primary model due to:
  - non-linearity
  - strong performance on tabular behavioral features
  - ability to handle feature interactions

### 5.4 Evaluation outputs
I reported model performance using:
- **ROC curve / AUC**
- (Optionally) precision-recall curves (recommended when churn is rare)
- Confusion matrix at a chosen probability threshold

### 5.5 Thresholding and operational use
Instead of “predict churn yes/no,” the key deliverable is:
- a **churn probability** per customer

Then I selected thresholds based on capacity and goals:
- High-risk bucket: top X% risk (for calls/1:1 outreach)
- Medium-risk bucket: light-touch nudges (SMS/email)
- Low-risk bucket: no action / normal marketing

This creates an actionable workflow: allocate retention resources where ROI is highest.

### 5.6 Interpretability and “what to do next”
I prepared the modeling outputs to support action:
- Identify which features drive risk (trend in check-ins/spend)
- Recommend interventions aligned with drivers:
  - low check-ins → class reminders, beginner series, schedule matching
  - spend drop → targeted credit / bundle offer
  - early lifecycle decline → onboarding improvements, first-month challenge

(If SHAP is included, it becomes a strong stakeholder-facing explanation layer.)

---

## 6) What this project enabled for stakeholders

### 6.1 Diagnostic clarity
- Quantified early churn patterns and when retention breaks down
- Provided segment-level LTV summaries aligned with business questions

### 6.2 Better studio comparisons
- Avoided misleading “studio rankings” by adjusting for studio maturity
- Used hierarchical shrinkage to reduce noise and overinterpretation

### 6.3 Actionable retention operations
- Produced customer churn risk scores
- Created risk buckets suitable for marketing/ops execution
- Tied model drivers to concrete intervention ideas

---

## 7) How to present the story (one slide narrative)

1. **Retention:** early lifecycle drop is steep; retention stabilizes among customers who survive month 1–2.  
2. **Value:** older segments tend to generate higher long-term value; locations differ but raw comparisons are confounded.  
3. **Hierarchy:** controlling for studio age/season shrinks many studio differences—maturity is a major factor.  
4. **Prediction:** a churn risk model using engagement/spend trajectory features identifies at-risk customers early; outputs support targeted interventions.

---
