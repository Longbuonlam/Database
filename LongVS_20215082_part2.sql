/*Câu 11 Students aged 25 and above. Given information: student name, age*/

select * from student where date_part('year',dob::date)>=25;

/* Câu 12 Students were born in June 1999.*/
select * from student where extract (month from dob)='6' and extract (year from dob)='1999';


/* Câu 13 Display class name and number of students corresponding in each class. 
Sort the result in descending order by the number of students.*/

select c.name, count(s.student_id) from student s
inner join clazz c on s.clazz_id=c.clazz_id
group by c.clazz_id order by count(student_id) desc ;

/* Câu 14 :Display the lowest, highest and average scores 
on the mid-term test of "Mạng máy tính" in semester '20172'.
*/

select min(midterm_score),max(midterm_score),avg(midterm_score)
from enrollment e inner join subject sub on e.subject_id=sub.subject_id
where sub.name='Tin học đại cương' and e.semester='20172';

/* Câu 15 Give number of subjects that each lecturer can teach. 
List must contain:lecturer id, lecturer's fullname, number of subjects.*/

SELECT l.lecturer_id,concat(l.last_name,' ',l.first_name) as fullname ,count(subject_id)
FROM lecturer l
inner JOIN teaching te ON te.lecturer_id = l.lecturer_id
GROUP BY l.lecturer_id;

/*Cau 16.List of subjects which have at least 2 lecturers in charge.*/

select subject_id,count(*) from teaching group by  subject_id having count(*)>=2;
/*Cau 17 :List of subjects which have less than 2 lecturers in charge.*/

select subject_id , count(*) as lecturer_in_charge
from teaching group by (subject_id) having  count(*)< 2;

/*Câu 18: List of students who obtained the highest score in subject whose id is 'IT3080', 
in the semester '20172'.*/
 select student_id, concat (first_name,' ',last_name) as full_name
from subject join (select * from student join enrollment using (student_id)) as ses using (subject_id)
where midterm_score *(100-percentage_final_exam)/100 + final_score*percentage_final_exam/100 
=(select max(midterm_score *(100-percentage_final_exam)/100 + final_score*percentage_final_exam/100) as score
from subject join  enrollment as se using (subject_id));



