-- ==========================================================
-- 1. DATA OVERVIEW
-- Purpose: Understand dataset size and structure
-- ==========================================================

SELECT *
FROM user_funnel
LIMIT 10;

SELECT COUNT(*) AS total_users
FROM user_funnel;

-- ==========================================================
-- 2. FUNNEL STAGE COUNTS
-- Purpose: Count users at each funnel stage
-- ==========================================================

SELECT
    COUNT(*) AS visits,
    SUM(signup) AS signups,
    SUM(profile_completed) AS profiles_completed,
    SUM(applied) AS applications,
    SUM(application_success) AS successful_applications
FROM user_funnel;

-- ==========================================================
-- 3. DROP-OFF & CONVERSION ANALYSIS
-- Purpose: Identify major drop-off points
-- ==========================================================

SELECT
    ROUND(1 - (SUM(signup)*1.0 / COUNT(*)), 2) AS visit_to_signup_dropoff,
    ROUND(1 - (SUM(profile_completed)*1.0 / SUM(signup)), 2) AS signup_to_profile_dropoff,
    ROUND(1 - (SUM(applied)*1.0 / SUM(profile_completed)), 2) AS profile_to_application_dropoff
FROM user_funnel;

-- ==========================================================
-- 4. DEVICE SEGMENTATION
-- Purpose: Compare behavior across devices
-- ==========================================================

SELECT
    device_type,
    COUNT(*) AS users,
    ROUND(SUM(profile_completed)*1.0 / SUM(signup), 2) AS profile_completion_rate
FROM user_funnel
GROUP BY device_type;

-- ==========================================================
-- 5. USER TYPE ANALYSIS
-- Purpose: Compare new vs returning users
-- ==========================================================

SELECT
    user_type,
    COUNT(*) AS users,
    ROUND(SUM(profile_completed)*1.0 / COUNT(*), 2) AS completion_rate
FROM user_funnel
GROUP BY user_type;

-- ==========================================================
-- 6. APPLICATION SUCCESS RATE
-- Purpose: Measure final conversion success
-- ==========================================================

SELECT
    ROUND(SUM(application_success)*1.0 / SUM(applied), 2) AS success_rate
FROM user_funnel;

-- ==========================================================
-- 7. HIGH-INTENT USER ANALYSIS
-- Purpose: Identify users most likely to convert
-- ==========================================================

SELECT
    device_type,
    COUNT(*) AS high_intent_users
FROM user_funnel
WHERE profile_completed = 1
  AND applied = 1
GROUP BY device_type;

