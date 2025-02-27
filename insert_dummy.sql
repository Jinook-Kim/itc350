INSERT INTO DORM_ROOM (DormRoomName, NumberOfRoomOccupants, AvailableSpots) VALUES
('North101', 2, 1),
('North102', 2, 0),
('East201', 3, 1),
('East202', 3, 2),
('South301', 1, 0),
('South302', 2, 1),
('West401', 4, 2);

INSERT INTO COLLEGE_STAFF_ACCOUNT (StaffID, FirstName, LastName, EmailAddress, Username, PasswordHash) VALUES
(1, 'John', 'Doe', 'john.doe@surendra.edu', 'jdoe', 'hashedpassword1'),
(2, 'Jane', 'Smith', 'jane.smith@surendra.edu', 'jsmith', 'hashedpassword2'),
(3, 'Emily', 'Johnson', 'emily.johnson@surendra.edu', 'ejohnson', 'hashedpassword3'),
(4, 'Michael', 'Brown', 'michael.brown@surendra.edu', 'mbrown', 'hashedpassword4'),
(5, 'Jessica', 'Davis', 'jessica.davis@surendra.edu', 'jdavis', 'hashedpassword5'),
(6, 'David', 'Wilson', 'david.wilson@surendra.edu', 'dwilson', 'hashedpassword6'),
(7, 'Sarah', 'Martinez', 'sarah.martinez@surendra.edu', 'smartinez', 'hashedpassword7');

INSERT INTO Administrates (DormRoomName, StaffID) VALUES
('North101', 1),
('North102', 2),
('East201', 3),
('East202', 4),
('South301', 5),
('South302', 6),
('West401', 7);

INSERT INTO STUDENT_ACCOUNT (Phone, StudentID, EmailAddress, FirstName, LastName, Username, PasswordHash, DormRoomName) VALUES
(1234567890, 101, 'alex.jones@surendra.edu', 'Alex', 'Jones', 'ajones', 'hashedpassword101', 'North101'),
(2345678901, 102, 'emma.williams@surendra.edu', 'Emma', 'Williams', 'ewilliams', 'hashedpassword102', 'North102'),
(3456789012, 103, 'daniel.brown@surendra.edu', 'Daniel', 'Brown', 'dbrown', 'hashedpassword103', 'East201'),
(4567890123, 104, 'lucas.davis@surendra.edu', 'Lucas', 'Davis', 'ldavis', 'hashedpassword104', 'East202'),
(5678901234, 105, 'olivia.garcia@surendra.edu', 'Olivia', 'Garcia', 'ogarcia', 'hashedpassword105', 'South301'),
(6789012345, 106, 'sophia.martin@surendra.edu', 'Sophia', 'Martin', 'smartin', 'hashedpassword106', 'South302'),
(7890123456, 107, 'jack.miller@example.com', 'Jack', 'Miller', 'jmiller', 'hashedpassword107', 'West401');

INSERT INTO HOUSING_APPLICATION (ApplicationID, Status, SubmissionDate, StudentID, StaffID) VALUES
(201, 1, '2023-01-01', 101, 1),
(202, 2, '2023-02-10', 102, 2),
(203, 3, '2023-03-15', 103, 3),
(204, 1, '2023-04-20', 104, 4),
(205, 2, '2023-05-25', 105, 5),
(206, 1, '2023-06-30', 106, 6),
(207, 3, '2023-07-05', 107, 7);