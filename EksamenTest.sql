
-- Opprett tabellen for brukere
CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,       -- Unik identifikator (auto-inkrement)
    Name VARCHAR(100) NOT NULL,      -- Brukerens navn
    Email VARCHAR(100) UNIQUE NOT NULL, -- Unik e-post for identifikasjon
    Barcode VARCHAR(50) UNIQUE NOT NULL, -- Personlig barkode
    TotalTickets INT DEFAULT 0,      -- Totalt antall lodd opptjent
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Registreringsdato
);

-- Opprett tabellen for resirkuleringsaktiviteter
CREATE TABLE RecyclingActivities (
    ActivityID SERIAL PRIMARY KEY,   
    UserID INT NOT NULL,             
    ContainerID INT NOT NULL,       
    UnitsRecycled INT NOT NULL,    
    ActivityDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ContainerID) REFERENCES Containers(ContainerID)
);

-- Opprett tabellen for konteinere
CREATE TABLE Containers (
    ContainerID SERIAL PRIMARY KEY,  
    Location VARCHAR(255) NOT NULL,  
    Capacity INT NOT NULL,           
    FillLevel DECIMAL(5,2) DEFAULT 0.00, 
    TimesEmptied INT DEFAULT 0,      
    ActivityCount INT DEFAULT 0      
);

-- Opprett tabellen for lodd i pantelotteriet
CREATE TABLE LotteryTickets (
    TicketID SERIAL PRIMARY KEY,     
    UserID INT NOT NULL,             
    DrawID INT NOT NULL,             
    DrawDate DATE NOT NULL,         
    WinnerStatus BOOLEAN DEFAULT FALSE, 
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (DrawID) REFERENCES Draws(DrawID)
);

-- Opprett tabellen for trekninger
CREATE TABLE Draws (
    DrawID SERIAL PRIMARY KEY,       
    DrawDateTime TIMESTAMP NOT NULL, 
    WinnerUserID INT,                
    Prize VARCHAR(255),              
    FOREIGN KEY (WinnerUserID) REFERENCES Users(UserID)
);

-- Opprett tabellen for statistikk
CREATE TABLE Statistics (
    StatID SERIAL PRIMARY KEY,       
    ContainerID INT NOT NULL,        
    Date DATE NOT NULL,              
    TotalUnitsRecycled INT NOT NULL, 
    MostUsedContainer BOOLEAN DEFAULT FALSE, 
    FOREIGN KEY (ContainerID) REFERENCES Containers(ContainerID)
);