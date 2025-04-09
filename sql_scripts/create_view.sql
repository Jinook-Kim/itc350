CREATE VIEW HousingApplicationPortal AS
SELECT 
    ha.StudentID AS student_id,
    ha.Status AS status,
    sa.DormRoomName AS room_name
FROM 
    HOUSING_APPLICATION ha
JOIN 
    STUDENT_ACCOUNT sa ON ha.StudentID = sa.StudentID;

CREATE VIEW StaffApplicationsView AS
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