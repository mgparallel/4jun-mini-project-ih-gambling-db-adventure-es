CREATE TABLE student (
	student_id INT,
	student_name VARCHAR(30),
	city VARCHAR(30),
	school_id INT,
	GPA FLOAT
);

INSERT INTO student VALUES
	(1001, 'Peter Brebec', 'New York', 1, '4'),
	(1002, 'John Goorgy', 'San Francisco', 2, '3.1'),
	(2003, 'Brad Smith', 'New York', 3, '2.9'),
	(1004, 'Fabian Johns', 'Boston', 5, '2.1'),
	(1005, 'Brad Cameron', 'Stanford', 1, '2.3'),
	(1006, 'Geoff Firby', 'Boston', 5, '1.2'),
	(1007, 'Johnny Blue', 'New Haven', 2, '3.8'),
	(1008, 'Johse Brook', 'Miami', 2, '3.4')
;

CREATE TABLE school (
	school_id INT,
    school_name VARCHAR(30),
    city VARCHAR(30)
);

INSERT INTO school VALUES
	(1, 'Stanford', 'Stanford'),
	(2, 'University of California', 'San Francisco'),
	(3, 'Harvard University', 'New York'),
	(4, 'MIT', 'Boston'),
	(5, 'Yale', 'New Haven'),
	(6, 'University of Westminster', 'London'),
	(7, 'Corvinus University', 'Budapest')
;