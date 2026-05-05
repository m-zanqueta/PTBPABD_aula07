-- Questão 1
CREATE OR ALTER PROCEDURE dbo.student_grade_points
    @grade VARCHAR(2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        s.name          AS nome_estudante,
        s.dept_name     AS departamento_estudante,
        c.title         AS titulo_curso,
        c.dept_name     AS departamento_curso,
        t.semester      AS semestre_curso,
        t.year          AS ano_curso,
        cr.grade        AS pontuacao_alfanumerica,
        cr.points       AS pontuacao_numerica
    FROM takes t
        INNER JOIN student s ON s.ID = t.ID
        INNER JOIN course c ON c.course_id = t.course_id
        INNER JOIN coeficiente_rendimento cr ON cr.grade = t.grade
    WHERE t.grade = @grade;
END;
GO

-- Questão 2
CREATE OR ALTER FUNCTION dbo.return_instructor_location
(
    @instructor_name VARCHAR(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        i.name          AS nome_instrutor,
        c.title         AS curso_ministrado,
        te.semester     AS semestre_curso,
        te.year         AS ano_curso,
        sec.building    AS predio,
        sec.room_number AS numero_sala
    FROM instructor i
        INNER JOIN teaches te ON te.ID = i.ID
        INNER JOIN course c ON c.course_id = te.course_id
        INNER JOIN section sec
            ON  sec.course_id = te.course_id
            AND sec.sec_id    = te.sec_id
            AND sec.semester  = te.semester
            AND sec.year      = te.year
    WHERE i.name = @instructor_name
);
GO
