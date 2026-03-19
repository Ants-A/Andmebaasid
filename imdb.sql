#select * from imdbta24a.ta24a;
use imdbta24a;

create table genres as
SELECT distinct
  ta24a.tconst,
  SUBSTRING_INDEX(ta24a.genres, ',', numbers.n) test,
  SUBSTRING_INDEX(SUBSTRING_INDEX(ta24a.genres, ',', numbers.n), ',', -1) genres,
  numbers.n,
  CHAR_LENGTH(ta24a.genres) -CHAR_LENGTH(REPLACE(ta24a.genres, ',', '')) + 1 osi
FROM
  (SELECT 1 n UNION ALL SELECT 2
   UNION ALL SELECT 3 UNION ALL SELECT 4) numbers INNER JOIN ta24a
  ON CHAR_LENGTH(ta24a.genres)
     -CHAR_LENGTH(REPLACE(ta24a.genres, ',', ''))>=numbers.n-1
ORDER BY
  tconst, n;
  
alter table genres
add primary key(tconst, genres);

alter table ta24a
drop column genres;