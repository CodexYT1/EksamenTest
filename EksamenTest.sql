# Use an official base image
FROM node:16

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the rest of the application files
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]


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
    ActivityID SERIAL PRIMARY KEY,   -- Unik identifikator for aktivitet
    UserID INT NOT NULL,             -- Fremmednøkkel til Users
    ContainerID INT NOT NULL,        -- Fremmednøkkel til Containers
    UnitsRecycled INT NOT NULL,      -- Antall enheter resirkulert
    ActivityDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Tidspunkt for aktivitet
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ContainerID) REFERENCES Containers(ContainerID)
);

-- Opprett tabellen for konteinere
CREATE TABLE Containers (
    ContainerID SERIAL PRIMARY KEY,  -- Unik identifikator for konteiner
    Location VARCHAR(255) NOT NULL,  -- Adresse eller GPS-koordinater
    Capacity INT NOT NULL,           -- Total kapasitet
    FillLevel DECIMAL(5,2) DEFAULT 0.00, -- Fyllingsgrad i prosent
    TimesEmptied INT DEFAULT 0,      -- Antall tømminger
    ActivityCount INT DEFAULT 0      -- Antall ganger brukt
);

-- Opprett tabellen for lodd i pantelotteriet
CREATE TABLE LotteryTickets (
    TicketID SERIAL PRIMARY KEY,     -- Unik identifikator for lodd
    UserID INT NOT NULL,             -- Fremmednøkkel til Users
    DrawID INT NOT NULL,             -- Fremmednøkkel til Draws
    DrawDate DATE NOT NULL,          -- Trekningens dato
    WinnerStatus BOOLEAN DEFAULT FALSE, -- Om loddet er et vinnerlodd
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (DrawID) REFERENCES Draws(DrawID)
);

-- Opprett tabellen for trekninger
CREATE TABLE Draws (
    DrawID SERIAL PRIMARY KEY,       -- Unik identifikator for trekning
    DrawDateTime TIMESTAMP NOT NULL, -- Når trekningen skjer
    WinnerUserID INT,                -- Fremmednøkkel til Users for vinner
    Prize VARCHAR(255),              -- Premien som deles ut
    FOREIGN KEY (WinnerUserID) REFERENCES Users(UserID)
);

-- Opprett tabellen for statistikk
CREATE TABLE Statistics (
    StatID SERIAL PRIMARY KEY,       -- Unik identifikator for statistikk
    ContainerID INT NOT NULL,        -- Fremmednøkkel til Containers
    Date DATE NOT NULL,              -- Dato for statistikk
    TotalUnitsRecycled INT NOT NULL, -- Totalt antall enheter resirkulert
    MostUsedContainer BOOLEAN DEFAULT FALSE, -- Om konteiner er mest brukt
    FOREIGN KEY (ContainerID) REFERENCES Containers(ContainerID)
);