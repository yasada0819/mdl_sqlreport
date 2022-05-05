select
u.username as 学籍番号
, CONCAT(u.lastname, ' ', u.firstname) as 氏名
, max(FROM_UNIXTIME(qr.submitted, '%Y-%m-%d　%H:%i:%s') )as 日時
, u.idnumber as 名簿順

, max(qrt1.response) as 体温

FROM prefix_questionnaire as q 

JOIN prefix_questionnaire_response as qr
on qr.questionnaireid = q.id AND ( q.id = 240 )  

JOIN prefix_user AS u on u.id = qr.userid 

JOIN prefix_questionnaire_response_text as qrt1 
on qrt1.response_id = qr.id
JOIN prefix_questionnaire_question as q5 
on q5.name like '体温' and q5.id = qrt1.question_id

where 1=1
AND MID(u.idnumber, 6,2) like 'M1'
AND DATEDIFF( NOW(),FROM_UNIXTIME(qr.submitted) ) = 0
%%FILTER_SEARCHTEXT:u.username:~%%

GROUP BY 学籍番号,  氏名, 名簿順

ORDER BY 名簿順
