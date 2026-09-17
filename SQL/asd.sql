GRANT ALL PRIVILEGES ON hyundai.* TO 'choamung'@'localhost';
FLUSH PRIVILEGES;

SELECT user, host
FROM mysql.user
WHERE user = 'choamung';

GRANT SELECT ON hyundai.* TO 'choamung'@'%';



-- 사용자 계정 발급 

-- 1) 사용자 생성 (사용자 계정 발급)

CREATE USER 'bookuser'@'localhost' IDENTIFIED BY '1234';

-- 2) bookstore 데이터베이스에 생성 
CREATE DATABASE bookstore DEFAULT CHARSET  utf8mb4 COLLATE  utf8mb4_general_ci;
 
-- 3) bookstore에 대한 모든 권한을 사용자 bookuser 에게 부여 
GRANT ALL PRIVILEGES ON bookstore.* TO 'bookuser'@'localhost';
 
-- 4) 권한 정보 즉시 반영
FLUSH PRIVILEGES;
