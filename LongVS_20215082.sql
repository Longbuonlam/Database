/* Mid Term */
/*Câu 1*/
CREATE TABLE Book (
  book_id CHAR(10) PRIMARY KEY,
  title CHAR(50) NOT NULL,
  publisher CHAR(20) NOT NULL,
  published_year INTEGER CHECK (published_year > 1900),
  total_number_of_copies INTEGER CHECK (total_number_of_copies >= 0),
  current_number_of_copies INTEGER CHECK (current_number_of_copies >= 0 AND current_number_of_copies <= total_number_of_copies)
);

CREATE TABLE Borrower (
  borrower_id CHAR(10) PRIMARY KEY,
  name CHAR(50) NOT NULL,
  address TEXT,
  telephone_number CHAR(12)
);

CREATE TABLE BorrowCard (
  card_id SERIAL PRIMARY KEY,
  borrower_id CHAR(10),
  borrow_date DATE NOT NULL,
  expected_return_date DATE NOT NULL,
  actual_return_date DATE,
  FOREIGN KEY (borrower_id) REFERENCES Borrower(borrower_id)
);

CREATE TABLE BorrowCardItem (
  card_id INT,
  book_id CHAR(10),
  number_of_copies INTEGER,
  PRIMARY KEY (card_id, book_id),
  FOREIGN KEY (card_id) REFERENCES BorrowCard(card_id),
  FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

/*Câu 2*/
select * from book
where published_year = 2020
and publisher = 'Wiley';

/*Câu 3*/
select publisher, sum(total_number_of_copies) as total
from Book
group by publisher;

/*Câu 4*/
SELECT book_id
FROM BorrowCardItem
WHERE card_id IN (
	SELECT card_id FROM BorrowCard WHERE EXTRACT(YEAR FROM borrow_date) = 2020
)
GROUP BY book_id
ORDER BY COUNT(card_id) DESC
LIMIT 5;

/*Câu 5*/
SELECT Borrower.borrower_id, Borrower.name, Borrower.telephone_number, Borrower.address
FROM Borrower 
JOIN BorrowCard ON Borrower.borrower_id = BorrowerCard.borrower_id
WHERE BorrowerCard.actual_return_date IS NULL;

/*Câu 6*/
SELECT Borrower.borrower_id, Borrower.name, Borrower.telephone_number, Borrower.address
FROM Borrower 
JOIN BorrowCard ON Borrower.borrower_id = BorrowerCard.borrower_id
WHERE BorrowerCard.actual_return_date > BorrowerCard.expected_return_date
ORDER BY Borrower.name ASC;

/*Câu 7*/
DELETE FROM Book
WHERE book_id NOT IN (
    SELECT DISTINCT book_id
    FROM BorrowCardItem
);

/*Câu 8*/
UPDATE Book
SET total_number_of_copies = total_number_of_copies + 10,
    current_number_of_copies = current_number_of_copies + 10
WHERE book_id IN (
    SELECT BorrowCardItem.book_id
    FROM BorrowCardItem
    JOIN Book ON BorrowCardItem.book_id = Book.book_id
    WHERE Book.publisher = 'Wiley'
    GROUP BY BorrowCardItem.book_id
    ORDER BY COUNT(*) DESC
    LIMIT 5
);

/*Câu 9*/
SELECT DISTINCT Borrower.borrower_id, Borrower.name
FROM Borrower
JOIN BorrowCard ON Borrower.borrower_id = BorrowCard.borrower_id
JOIN BorrowCardItem ON BorrowCard.card_id = BorrowCardItem.card_id
JOIN Book ON BorrowCardItem.book_id = Book.book_id
WHERE Book.publisher IN ('Wiley', 'Addison-Wesley')
GROUP BY Borrower.borrower_id, Borrower.name
HAVING COUNT(DISTINCT Book.publisher) = 2;



