CREATE DATABASE miniproject;
USE miniproject;

-- BẢNG 1: teams (Đội đua)
CREATE TABLE teams (
    team_id INT AUTO_INCREMENT,
    team_name VARCHAR(100) NOT NULL,
    hq_country VARCHAR(50) NOT NULL,
    budget_cap DECIMAL(15,2) NOT NULL,
    current_rank INT DEFAULT 0,
    CONSTRAINT PK_teams PRIMARY KEY (team_id)
);

-- BẢNG 2: drivers (Tay đua)
CREATE TABLE drivers (
    driver_id INT AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    driver_number INT NOT NULL,
    nationality VARCHAR(50) NOT NULL,
    annual_salary DECIMAL(12,2) NOT NULL,
    team_id INT,
    CONSTRAINT PK_drivers PRIMARY KEY (driver_id),
    CONSTRAINT UQ_driver_number UNIQUE (driver_number),
    CONSTRAINT FK_drivers_teams FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- BẢNG 3: constructors_championship (Giải đội đua)
CREATE TABLE constructors_championship (
    championship_id INT AUTO_INCREMENT,
    season_year YEAR NOT NULL,
    team_id INT,
    total_points DECIMAL(5,1) DEFAULT 0.0,
    CONSTRAINT PK_constructors_championship PRIMARY KEY (championship_id),
    CONSTRAINT FK_constructors_teams FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- BẢNG 4: races (Chặng đua)
CREATE TABLE races (
    race_id INT AUTO_INCREMENT,
    race_name VARCHAR(100) NOT NULL,
    circuit_name VARCHAR(100) NOT NULL,
    race_date DATETIME NOT NULL,
    race_status VARCHAR(30) DEFAULT 'Scheduled',
    CONSTRAINT PK_races PRIMARY KEY (race_id)
);

-- BẢNG 5: race_results (Kết quả chặng đua)
CREATE TABLE race_results (
    result_id INT AUTO_INCREMENT,
    driver_id INT,
    race_id INT,
    grid_position INT NOT NULL,
    finish_position INT NULL, 
    points_earned DECIMAL(4,1) DEFAULT 0.0,
    fastest_lap_speed DECIMAL(5,2) DEFAULT 0.00,
    CONSTRAINT PK_race_results PRIMARY KEY (result_id),
    CONSTRAINT FK_results_drivers FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    CONSTRAINT FK_results_races FOREIGN KEY (race_id) REFERENCES races(race_id)
);

-- 1. Chèn dữ liệu vào bảng teams
INSERT INTO teams (team_name, hq_country, budget_cap, current_rank) VALUES
('Red Bull Racing', 'Austria', 135000000.00, 1),
('Mercedes', 'Germany', 135000000.00, 2),
('Ferrari', 'Italy', 135000000.00, 3),
('McLaren', 'UK', 135000000.00, 4),
('Aston Martin', 'UK', 135000000.00, 5);

-- 2. Chèn dữ liệu vào bảng drivers
INSERT INTO drivers (full_name, driver_number, nationality, annual_salary, team_id) VALUES
('Max Verstappen', 1, 'Dutch', 55000000.00, 1),
('Lewis Hamilton', 44, 'British', 45000000.00, 2),
('Charles Leclerc', 16, 'Monacan', 34000000.00, 3),
('Lando Norris', 4, 'British', 25000000.00, 4),
('Fernando Alonso', 14, 'Spanish', 22000000.00, 5);

-- 3. Chèn dữ liệu vào bảng constructors_championship (Mùa giải 2026)
INSERT INTO constructors_championship (season_year, team_id, total_points) VALUES
(2026, 1, 120.5),
(2026, 2, 95.0),
(2026, 3, 88.0),
(2026, 4, 110.0),
(2026, 5, 45.5);

-- 4. Chèn dữ liệu vào bảng races
INSERT INTO races (race_name, circuit_name, race_date, race_status) VALUES
('Bahrain GP', 'Bahrain International Circuit', '2026-03-02 18:00:00', 'Finished'),
('Monaco GP', 'Circuit de Monaco', '2026-05-24 15:00:00', 'Scheduled'),
('Silverstone GP', 'Silverstone Circuit', '2026-07-05 15:00:00', 'Scheduled'),
('Suzuka GP', 'Suzuka International Racing Course', '2026-04-05 14:00:00', 'Finished'),
('Monza GP', 'Autodromo Nazionale Monza', '2026-09-06 15:00:00', 'Scheduled');

-- 5. Chèn dữ liệu vào bảng race_results (Mô phỏng chặng Bahrain và Suzuka)
INSERT INTO race_results (driver_id, race_id, grid_position, finish_position, points_earned, fastest_lap_speed) VALUES
-- Chặng 1: Bahrain GP
(1, 1, 1, 1, 26.0, 242.50),
(2, 1, 3, 2, 18.0, 238.20), 
(4, 1, 2, 3, 15.0, 239.10), 
(3, 1, 4, 21, 0.0, 230.40),  
(5, 1, 5, NULL, 0.0, 0.00),   
-- Chặng 4: Suzuka GP
(1, 4, 1, 2, 18.0, 235.10),
(4, 4, 3, 1, 25.0, 241.80), 
(2, 4, 2, 4, 12.0, 236.40),
(3, 4, 4, 3, 15.0, 237.90);