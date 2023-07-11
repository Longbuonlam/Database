/*Câu 1*/

Select * form subject where subject.credits >=5
/*Câu 2*/
select * from student,clazz where student.clazz_id=clazz.clazz_id and clazz.name='CNTT 2 K58'
/*Câu 3*/
select * from student,clazz where student.clazz_id=clazz.clazz_id and clazz.name like '%CNTT%'
/*Câu 4*/

SELECT *
FROM student 

JOIN enrollment e1 ON student.student_id = e1.student_id 
JOIN subject c1 ON e1.subject_id = c1.subject_id
JOIN enrollment e2 ON student.student_id  = e2.student_id 
JOIN subject c2 ON e2.subject_id = c2.subject_id
WHERE c1.name ='Lập trình Java'
AND c2.name = 'Lập trình nhúng';
/*Câu 5*/
SELECT *
FROM student 

JOIN enrollment e1 ON student.student_id = e1.student_id 
JOIN subject c1 ON e1.subject_id = c1.subject_id
JOIN enrollment e2 ON student.student_id  = e2.student_id 
JOIN subject c2 ON e2.subject_id = c2.subject_id
WHERE c1.name ='Lập trình Java'
OR c2.name = 'Lập trình hướng đối tượng';



/*Cau 5*/

select s.*  from student s 
inner join enrollment e on s.student_id=e.student_id
inner join subject sub on sub.subject_id=e.subject_id
where sub.name in ('Tin học đại cương','Cơ sở dữ liệu');

/*Cau 6*/

select * from subject where subject_id not in (select distinct subject_id from enrollment)
/*Cau 7 */
select * from subject sub where  sub.subject_id in(select subject_id from enrollment e
	join student s on s.student_id=e.student_id 
	where s.first_name='Nhật Cường' and s.last_name='Nguyễn' and e.semester='20171');

/*Câu 8
Show the list of students who enrolled in 'Cơ sở dữ liệu' in semesters = '20172').
 This list contains student id, student name, midterm score, final exam score and subject score. 
 Subject score is calculated by the weighted average of midterm score and final exam score : subject score = 
 midterm score * (1-percentage_final_exam/100)  
 + final score *percentage_final_exam/100.
*/

select  s.student_id,concat(s.last_name,' ',s.first_name) as fullname, e.midterm_score,e.final_score,e.midterm_score*(1-sub.percentage_final_exam/100)+e.final_score*(sub.percentage_final_exam) as subjectscore
from student s 
inner join enrollment e on s.student_id=e.student_id
inner join subject sub on e.subject_id=sub.subject_id
where e.semester='20172' and sub.name='Cơ sở dữ liệu';
/* Cau 9

Display IDs of students who failed the subject with code 'IT1110' in semester '20171'. 
Note: a student failed a subject if his midterm score or his final exam score is below 3 ;
 or his subject score is below 4.
*/

select distinct student_id from enrollment e inner join subject sub on e.subject_id =sub.subject_id
where e.subject_id='IT1110' and e.semester='20171' and e.final_score<3 and(e.midterm_score*(1-sub.percentage_final_exam/100)+e.final_score*(sub.percentage_final_exam))<4;

/* Cau 10*/

select distinct concat(s.last_name,' ',s.first_name) as fullname, c.name,concat(s.last_name,' ',s.first_name)
from student s  
inner join clazz c on s.clazz_id=c.clazz_id;


