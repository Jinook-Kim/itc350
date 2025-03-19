CREATE VIEW StudentAccountsView AS
SELECT 
    StudentID AS student_id,
    FirstName AS first_name,
    LastName AS last_name,
    Phone AS phone_num,
    EmailAddress AS email,
    Username AS username,
    DormRoomName AS room_name
FROM STUDENT_ACCOUNT;

CREATE VIEW StaffAccountsView AS
SELECT 
    StaffID AS staff_id,
    FirstName AS first_name,
    LastName AS last_name,
    EmailAddress AS email,
    Username AS username
FROM COLLEGE_STAFF_ACCOUNT;

CREATE VIEW LoginAuthView AS
SELECT 
    Username AS username,
    PasswordHash AS password_hash,
    'Student' AS account_type,
    StudentID AS account_id
FROM STUDENT_ACCOUNT
UNION ALL
SELECT 
    Username,
    PasswordHash,
    'Staff',
    StaffID
FROM COLLEGE_STAFF_ACCOUNT;

CREATE VIEW HousingApplicationsView AS
SELECT 
    HA.ApplicationID AS application_id,
    DATE_FORMAT(HA.SubmissionDate, '%m/%d/%Y') AS submission_date,
    HA.Status AS status,
    HA.StudentID AS student_id,
    SA.FirstName AS student_first_name,
    SA.LastName AS student_last_name,
    SA.EmailAddress AS student_email,
    SA.Phone AS student_phone,
    SA.DormRoomName AS room_name,
    HA.StaffID AS staff_id,
    CSA.FirstName AS staff_first_name,
    CSA.LastName AS staff_last_name,
    CSA.EmailAddress AS staff_email
FROM HOUSING_APPLICATION HA
JOIN STUDENT_ACCOUNT SA ON HA.StudentID = SA.StudentID
JOIN COLLEGE_STAFF_ACCOUNT CSA ON HA.StaffID = CSA.StaffID;

CREATE VIEW DormRoomAvailabilityView AS
SELECT 
    DormRoomName AS room_name,
    NumberOfRoomOccupants AS occupants,
    AvailableSpots AS available_spots
FROM DORM_ROOM;