DROP DATABASE IF EXISTS school;
CREATE DATABASE school;
USE school;

CREATE TABLE teachers (
    id INT AUTO_INCREMENT,
    `name` VARCHAR(100),
    `subject` VARCHAR(50),
    PRIMARY KEY(id)
);
INSERT INTO teachers (`name`, `subject`) VALUES ('Pak Anton', 'Matematika');
INSERT INTO teachers (`name`, `subject`) VALUES ('Bu Dina', 'Bahasa Indonesia');
INSERT INTO teachers (`name`, `subject`) VALUES ('Pak Eko', 'Biologi');

CREATE TABLE classes (
    id INT AUTO_INCREMENT,
    `name` VARCHAR(50),
    teacher_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);
INSERT INTO classes (`name`, teacher_id) VALUES ('Kelas 10A', 1);
INSERT INTO classes (`name`, teacher_id) VALUES ('Kelas 11B', 2);
INSERT INTO classes (`name`, teacher_id) VALUES ('Kelas 12C', 3);

CREATE TABLE students (
    id INT AUTO_INCREMENT,
    `name` VARCHAR(100),
    age INT,
    class_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY (class_id) REFERENCES classes(id)
);
INSERT INTO students (`name`, age, class_id) VALUES ('Budi', 16, 1);
INSERT INTO students (`name`, age, class_id) VALUES ('Ani', 17, 2);
INSERT INTO students (`name`, age, class_id) VALUES ('Candra', 18, 3);