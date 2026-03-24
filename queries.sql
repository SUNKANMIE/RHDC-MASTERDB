SELECT id, first_name, last_name, email, created_at
FROM participants
ORDER BY created_at DESC;

SELECT 
    s.id,
    p.first_name,
    p.last_name,
    st.name AS stage,
    s.status,
    s.submitted_at
FROM submissions s
JOIN participants p ON s.participant_id = p.id
JOIN stages st ON s.stage_id = st.id
ORDER BY s.submitted_at DESC;

SELECT *
FROM submissions
WHERE status = 'pending';

SELECT 
    e.id,
    u.full_name AS judge,
    s.id AS submission_id,
    e.feedback,
    e.created_at
FROM evaluations e
JOIN users u ON e.judge_id = u.id
JOIN submissions s ON e.submission_id = s.id;

SELECT 
    e.id AS evaluation_id,
    c.name AS criteria,
    sc.score
FROM scores sc
JOIN evaluations e ON sc.evaluation_id = e.id
JOIN criteria c ON sc.criteria_id = c.id;

SELECT 
    p.id,
    p.first_name,
    p.last_name,
    AVG(sc.score) AS average_score
FROM participants p
JOIN submissions s ON p.id = s.participant_id
JOIN evaluations e ON s.id = e.submission_id
JOIN scores sc ON e.id = sc.evaluation_id
GROUP BY p.id
ORDER BY average_score DESC;

CREATE VIEW leaderboard AS
SELECT 
    p.id,
    p.first_name,
    p.last_name,
    ROUND(AVG(sc.score),2) AS average_score,
    COUNT(e.id) AS total_reviews
FROM participants p
JOIN submissions s ON p.id = s.participant_id
JOIN evaluations e ON s.id = e.submission_id
JOIN scores sc ON e.id = sc.evaluation_id
GROUP BY p.id
ORDER BY average_score DESC;

SELECT * FROM leaderboard;

SELECT 
    st.name AS stage,
    ps.status,
    COUNT(*) AS total
FROM participant_stage ps
JOIN stages st ON ps.stage_id = st.id
GROUP BY st.name, ps.status
ORDER BY st.name;

SELECT 
    u.full_name,
    COUNT(e.id) AS total_reviews
FROM users u
JOIN evaluations e ON u.id = e.judge_id
GROUP BY u.full_name
ORDER BY total_reviews DESC;

SELECT 
    s.id,
    p.first_name,
    p.last_name
FROM submissions s
JOIN participants p ON s.participant_id = p.id
LEFT JOIN evaluations e ON s.id = e.submission_id
WHERE e.id IS NULL;

SELECT 
    action,
    table_name,
    record_id,
    created_at
FROM audit_logs
ORDER BY created_at DESC;

SELECT * FROM leaderboard
LIMIT 10;

SELECT 
    st.name,
    COUNT(s.id) AS total_submissions
FROM stages st
LEFT JOIN submissions s ON st.id = s.stage_id
GROUP BY st.name;

