USE school;

-- 1
SELECT s.name AS student_name, s.age AS student_age, c.name AS class_name, t.name AS teachers_name
FROM classes c
JOIN students s ON s.class_id = c.id
JOIN teachers t ON c.teacher_id = t.id;

-- 2
SELECT c.name AS class_name, t.name AS teacher_name
FROM classes c 
JOIN teachers t ON c.teacher_id = t.id
GROUP BY c.teacher_id
HAVING COUNT(*) > 1;

-- 3
CREATE VIEW student_class_teacher AS
SELECT s.name AS student_name, c.name AS class_name, t.name AS teacher_name
FROM students s
INNER JOIN classes c ON s.class_id = c.id
INNER JOIN teachers t ON c.teacher_id = t.id;

-- 4
DELIMITER //
CREATE PROCEDURE GetStudentClassTeacher()
BEGIN
	SELECT s.name AS student_name, c.name AS class_name, t.name AS teacher_name
	FROM students s
	INNER JOIN classes c ON s.class_id = c.id
	INNER JOIN teachers t ON c.teacher_id = t.id;
END //
DELIMITER ;
-- use stored procs
CALL GetStudentClassTeacher(); 

-- 5
-- addStudent stored procs
DELIMITER $$
CREATE PROCEDURE addStudent (
	IN s_name VARCHAR(100),
	IN s_age INT,
	IN s_class INT
)
BEGIN
	IF EXISTS (SELECT * FROM students WHERE `name` = s_name) 
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate entry for student';
	ELSE
		INSERT INTO students (`name`, age, class_id) VALUES (s_name, s_age, s_class);
	END IF;
COMMIT;
END $$
DELIMITER ;

-- addClass stored procs
DELIMITER $$
CREATE PROCEDURE addClass (
	IN c_name VARCHAR(100),
	IN c_teacher INT
)
BEGIN
	IF EXISTS (SELECT * FROM classes WHERE `name` = c_name) 
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate entry for class';
	ELSE
		INSERT INTO classes (`name`, teacher_id) VALUES (c_name, c_teacher);
	END IF;
COMMIT;
END $$
DELIMITER ;

-- addTeacher stored procs
DELIMITER $$
CREATE PROCEDURE addTeacher (
	IN t_name VARCHAR(100),
	IN t_subject VARCHAR(100) 
)
BEGIN
	IF EXISTS (SELECT * FROM teachers WHERE `name` = t_name AND `subject` = t_subject) 
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate entry for teacher';
	ELSE
		INSERT INTO teachers (`name`, `subject`) VALUES (t_name, t_subject);
	END IF;
COMMIT;
END $$
DELIMITER ;

CALL addStudent('Ayu', 10, 1);
CALL addClass('Kelas 10B', 2);
CALL addTeacher('Bu Yeni', 'Bahasa Inggris');
