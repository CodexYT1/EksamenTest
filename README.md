# EksamenTest
Har hatt masse problemer med denne oppgaven, men begynte med å lage database modell (noe som tok meg veldig lang tid pga vanskeligheter med tilkobling via database og docker.)

har problemer med å få package.json og package-lock.json


docker har offesielt blitt ødelagt og vil ikke bli åpnet...


endret en god del...

serevren runner på localhost:3000 (Bruker nodemon for automatisk server restarts kan velge om å ikke ha dette på)

* gå inn på terminal og start siden med:
    npm run dev     (For Development) 
    -----------
    
    (Docker runner dette sammen med nodemon på en nettleser: standardnettleser. restarter server hver gang det skjer en endring...)
    
    Eller hvis du ikke trenger å redigere på kode, så kan du eventuelt prøve:

    
    
    npm start       For Production (index.js blir kjørt på din standardnettleser: Google, Edge, Firefox etc...)
    ---------
    
    Nettsiden skal kunne kjøre normalt