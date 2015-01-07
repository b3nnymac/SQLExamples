select s_last, f_last 
from student, faculty 
where student.f_id= faculty.f_id

select faculty.f_id, f_last, count(student.f_id) 
from student, faculty 
where faculty.f_id = student.f_id 
group by faculty.f_id;

select course.course_id, course_name, max_enrl 
from course, course_section 
where course.course_id = course_section.course_id 
group by c_sec_id;

select course.course_id, course.course_name, sum(max_enrl) 
from course, course_section 
where course.course_id=course_section.course_id 
group by course.course_id;

select course_id, sum(max_enrl) 
from course_section 
group by course_id 
having sum(max_enrl) > 200;

select course_section.loc_id, bldg_code, room, count(course_section.loc_id) 
from course_section, location 
where course_section.loc_id = location.loc_id 
group by course_section.loc_id 
order by course_section.loc_id;

select course_name, term_desc, f_last, room 
from faculty, term, course, course_section, location 
where course_section.course_id = course.course_id and course_section.term_id = term.term_id and course_section.f_id = faculty.f_id and  course_section.loc_id = location.loc_id;


Insert INTO course_section  VALUE (14, 3, 4, 3, 2, 'M', "8:00 am", "50 minutes", null, 25);

No
