CREATE TABLE book_price_audit( 
title_id char(6),
type char(12),
old_price numeric(6,2),
new_price numeric(6,2)
) ENGINE InnoDB;

drop trigger audit_book_price_BUR;

delimiter $$
CREATE TRIGGER audit_book_price_BUR
BEFORE UPDATE 
ON title
FOR EACH ROW
BEGIN
	IF (new.price / old.price >= 1.1) THEN
		INSERT INTO book_price_audit 
	VALUES(new.title_id, new.type, old.price, new.price);
END IF;
END$$
delimiter ;


UPDATE title 
SET price = 21.00  
WHERE title_id = 'PC8888';

UPDATE title 
SET price = 25.00
WHERE title_id = 'BU1032';

UPDATE title 
SET price = 25.00  
WHERE title_id = 'BU1032';

ALTER TABLE book_price_audit
ADD COLUMN audit_nbr int NOT NULL PRIMARY KEY;

delimiter $$
create trigger generate_audit_nbr_BIR
before insert 	
on book_price_audit
for each row
BEGIN 

SET new.audit_nbr = (SELECT audit_nbr FROM book_price_audit)+1;
END$$

create trigger generate_audit_nbr_BIR
before insert 
on BOOK_PRICE_AUDIT
for each row
BEGIN
%% Find the current sequence number 
%% Set the new number. 
END;


delimiter $$
CREATE TRIGGER audit_book_price_BUR
BEFORE UPDATE 
ON title
FOR EACH ROW
BEGIN
	IF (new.price / old.price >= 1.1) THEN
insert into book_price_audit
values (new.title_id, new.type, old.price, new.price);
END IF;
END$$
delimiter ; 

UPDATE title 
SET price = 100.00  
WHERE title_id = 'TC7777';

SELECT price, ytd_sales, total_income 
FROM title
WHERE title_id equals 'BU1111';
DROP PROCEDURE add_author;

delimiter $$
CREATE PROCEDURE add_author
(
   IN id CHAR(11),
   IN last VARCHAR(40), 
   IN first VARCHAR(20)
)
BEGIN
INSERT INTO author (au_id, au_lname, au_fname) 
        VALUES (id, last, first);
END$$
delimiter ;



