INSERT INTO roles (name) VALUES
('admin'),
('judge');

INSERT INTO users (full_name, email, role_id)
SELECT 
    'Judge ' || i,
    'judge' || i || '@mail.com',
    (SELECT id FROM roles WHERE name = 'judge')
FROM generate_series(1,5) AS s(i);

INSERT INTO participants (first_name, last_name, email)
SELECT 
    'User' || i,
    'Test',
    'user' || i || '@mail.com'
FROM generate_series(1,100) AS s(i);


INSERT INTO stages (name, order_number) VALUES
('Stage 1', 1),
('Stage 2', 2),
('Final', 3);

INSERT INTO criteria (name, max_score) VALUES
('Accuracy', 10),
('Creativity', 10),
('Completeness', 10);


INSERT INTO participant_stage (participant_id, stage_id, status)
SELECT 
    p.id,
    (SELECT id FROM stages WHERE order_number = 1),
    'active'
FROM participants p;

INSERT INTO submissions (participant_id, stage_id, content, status)
SELECT 
    p.id,
    (SELECT id FROM stages WHERE order_number = 1),
    'Submission content ' || p.id,
    'submitted'
FROM participants p
LIMIT 50;

INSERT INTO evaluations (submission_id, judge_id, feedback)
SELECT 
    s.id,
    (SELECT id FROM users LIMIT 1),
    'Good work'
FROM submissions s
LIMIT 20;

INSERT INTO scores (evaluation_id, criteria_id, score)
SELECT 
    e.id,
    c.id,
    FLOOR(RANDOM() * 10)
FROM evaluations e
CROSS JOIN criteria c;
