SELECT DISTINCT
	pi.Req AS [Record #],
	pi.[Patient First] + ' ' + ISNULL(pi.[Patient Middle] + ' ', '') + pi.[Patient Last] AS [Patient Name],
	FORMAT(a.Date, 'MM/dd/yyyy HH:mm') AS [Audit Date],
	ISNULL(u.FirstName + ' ' + u.LastName, a.UserName) AS [User Name],
	a.Audit AS [Audit Description],
	l.Name AS [Facility],
	'AbbaDox' AS [Audit Source]
FROM PatientInfo pi
INNER JOIN OrderSchedule os ON os.PatientID = pi.Req
INNER JOIN Audit a ON os.JobID = a.Jobid
LEFT JOIN Location l ON a.Location = l.Location
LEFT JOIN Global.dbo.Users u ON (u.LastName + ', ' + u.FirstName) = a.UserName OR (u.FirstName + ' ' + u.LastName) = a.UserName
WHERE pi.isVIP = 1
UNION ALL
SELECT DISTINCT
	pi.Req AS [Record #],
	pi.[Patient First] + ' ' + ISNULL(pi.[Patient Middle] + ' ', '') + pi.[Patient Last] AS [Patient Name],
	FORMAT(a.Date, 'MM/dd/yyyy HH:mm') AS [Audit Date],
	ISNULL(u.FirstName + ' ' + u.LastName, a.UserName) AS [User Name],
	a.Audit AS [Audit Description],
	l.Name AS [Facility],
	'Scheduler' AS [Audit Source]
FROM PatientInfo pi
JOIN SchedulerResources sr ON pi.AutoCount = sr.ResourceID AND sr.ResourceType = 2
INNER JOIN SchedulerAudit a ON a.AppointmentId = sr.AppointmentID
LEFT JOIN Location l ON a.Location = l.Location
LEFT JOIN Global.dbo.Users u ON u.UserId = a.UserName
WHERE pi.isVIP = 1
UNION ALL
SELECT DISTINCT
	pi.Req AS [Record #],
	pi.[Patient First] + ' ' + ISNULL(pi.[Patient Middle] + ' ', '') + pi.[Patient Last] AS [Patient Name],
	FORMAT(a.Date, 'MM/dd/yyyy HH:mm') AS [Audit Date],
	ISNULL(u.FirstName + ' ' + u.LastName, a.UserName) AS [User Name],
	a.Audit AS [Audit Description],
	l.Name AS [Facility],
	'EHR' AS [Audit Source]
FROM PatientInfo pi
JOIN VisitEHRAudit a ON a.PatientId = pi.AutoCount
LEFT JOIN Location l ON a.Location = l.Location
LEFT JOIN Global.dbo.Users u ON (u.LastName + ', ' + u.FirstName) = a.UserName OR (u.FirstName + ' ' + u.LastName) = a.UserName
WHERE pi.isVIP = 1