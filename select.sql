# 1.查询同时存在1课程和2课程的情况
-- 我的理解是查询学生成绩表同时考了1课程和2课程的学生的行
select sc1.studentId, sc1.courseId, sc2.courseId
from student_course sc1
inner join student_course sc2
	on sc1.studentId = sc2.studentId
	and sc1.courseId = 1
	and sc2.courseId = 2;
# 2.查询同时存在1课程和2课程的情况
select sc1.studentId, sc1.courseId, sc2.courseId
from student_course sc1
inner join student_course sc2
	on sc1.studentId = sc2.studentId
    and sc1.courseId = 1
    and sc2.courseId = 2;
# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
set sql_mode = '';	-- 在MySQL中禁用ONLY_FULL_GROUP_BY，才能在结果集中加与分组无关的字段（这里是s.`name`）
select s.id, s.`name`, avg(sc.score) avgScore
from student s
inner join student_course sc
	on s.id = sc.studentId
group by sc.studentId
having avg(sc.score) >= 60;
# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
-- 我的理解是将某些课程没有成绩的学生以及所有课程都没有成绩的学生一并查出来
select s.id, s.`name`, s.age, s.sex 
from student s 
left join student_course sc 
	on s.id = sc.studentId 
group by sc.studentId 
having count(sc.studentId) < 3;
# 5.查询所有有成绩的SQL
select distinct sc.studentId 
from student_course sc 
inner join student s 
	on sc.studentId = s.id;
# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
select s.id, s.`name`, s.age, s.sex 
from student s 
inner join student_course sc1 
	on s.id = sc1.studentId 
    and sc1.courseId = 1 
inner join student_course sc2 
	on s.id = sc2.studentId
    and sc2.courseId = 2;
# 7.检索1课程分数小于60，按分数降序排列的学生信息
select s.id, s.`name`, s.age, s.sex
from student s
inner join student_course sc
	on s.id = sc.studentId
    and sc.courseId = 1
    and sc.score < 60
order by sc.score desc;
# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
select courseId, avg(score) avgScore
from student_course
group by courseId
order by avgScore desc, courseId asc;
# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
select s.`name`, sc.score mathScore
from student s
inner join student_course sc
	on s.id = sc.studentId
    and sc.score < 60
inner join course c
	on c.`name`	= '数学'
    and sc.courseId = c.id;