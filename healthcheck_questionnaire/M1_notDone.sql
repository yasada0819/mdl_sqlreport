select 
u.username as 学籍番号
, CONCAT(u.lastname, ' ', u.firstname) as 氏名
, MID(u.idnumber, 6,2) as 学年
, u.idnumber as 名簿順

FROM prefix_user as u

LEFT JOIN prefix_questionnaire_response as qr  on u.id = qr.userid
 AND DATEDIFF( NOW(),FROM_UNIXTIME(qr.submitted) ) = 0
 AND ( qr.questionnaireid = 240
	 -- OR q.id = 426
	 )  
LEFT JOIN prefix_questionnaire as q on qr.questionnaireid = q.id
LEFT JOIN prefix_questionnaire_response_text as qrt1 
 on qrt1.response_id = qr.id

LEFT JOIN prefix_questionnaire_question as q5 
 on q5.name like '体温' and q5.id = qrt1.question_id


WHERE 
 (qr.id is null
  OR qrt1.response is null
 ) 
AND MID(u.idnumber, 6,2) like 'M1'
AND u.suspended = 0


ORDER BY 名簿順
