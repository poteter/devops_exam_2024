# kandidatnummer 2


### oppgave 1
___
- A
     
        #### http url for gateway        

        http endpoint: https://vun0w4syh5.execute-api.eu-west-1.amazonaws.com/Prod/hello/
        
        it expects a request body of type:
            
        {
            "body": "messege"
        }
- B
    
        #### workflow

        https://github.com/poteter/devops_exam_2024/actions/runs/11837824347

### oppgave 2
___
- A

        #### http url for sqs queue
        
        jeg var ikke sikker på om det ble spurt om en http url til sqs-køen, eller om det var spurt om en url hvor du kan sende http spørringer til en sqs-kø så jeg valgte å bruke sqs-url'en 
        https://sqs.eu-west-1.amazonaws.com/244530008913/candidate_2_bedrock_sqs_queue

- B
        
        #### workflow for push to main

        https://github.com/poteter/devops_exam_2024/actions/runs/11892270567
        
        #### workflow for push to develop
        
        https://github.com/poteter/devops_exam_2024/actions/runs/11892446129

### oppgave 3
___

- A

        #### docker image
        primussy/devops243b:main
            
        #### sqs url
        https://sqs.eu-west-1.amazonaws.com/244530008913/candidate_2_bedrock_sqs_queue
            
        #### begrunnelse for tag strategi
        Jeg valgte å tagge en image tre ganger for å gjøre det lettere å identifisere hvilken branch og commit en image kommer fra.
    
    
### oppgave 5
___

 - 1
    
    Det tar lenger tid å utvikle en microservice enn en serverless.  En microservice krever at utvikler konfigruerer alt av OS, stack og nettverking som en service trenger.
For hver service så må en utvikler holde styr på alt av teknologier som en service er avhengig av.  De må passe på at de teknologiene de bruker fremdeles er støttet, og er 
kompatibelt med de andre teknologiene de vil bruke.
    
    Serverless krever mindre utvikling av en utvikler siden det ikke er nødvendig å konfigruere OS, Stack eller nettverking mellom funksjoner.  Dette tillater en utvikler å raskt 
sette opp funksjoner siden alt av konfigruering er håndtert av CSPen.  Serverless funksjoner er også betraktelig mindre enn mikrotjenester siden en serverless funksjon hovedsakelig bare består 
av koden som skal kjøre, hvor mikrotjenester i tillegg inneholder all infrastrukturen tjenesten trenger.

    Forskjellene på størrelse påvirker også hvor raskt en deployment kan være, hvor en utvikler bare trenger å deploye en funksjons kode og ikke hele mikrotjenesten med all dens kode og infrastruktur.
En funksjon vil bare bli opprettet og tilført rettigheter hvor en mikrotjeneste må som oftest bygge og installere infrastruktur og stack før koden kan kompileres, bygees til et image og deployes til 
f.eks kubernetes.
    
    Mikrotjenester krever egenkonfigruert automatisering for å skalere og distribuere. Serverless funksjoner får infrastruktur automatisert fra CSPen som tar seg av skalering og distribusjon gjennom 
tjenester som terraform. 

 - 2

    Siden levetiden til an FaaS funksjon er kortvarig er det vanskelig å samle inn kontinuelig metrikk.  I en mikrotjeneste vil man kunne sample inn kontinuelig metrikk enklere siden det er lang 
levetid, og siden mikrotjenester tillater høy frihet av konfigurasjon kan man installere veldig spesialiserte metrikker i hver tjeneste.
    
    I et mikrotjeneste-system kan alle logger aggregeres i en database for så å bli presentert på en uniform oversiktlig måte.  Man kan implementere sentralisert logging som ELK-stacken 
som lar deg samle inn logger skrevet til stdout i en elastic database.  Siden en tjeneste er langtlevende så er loggingen til tjenesten lang og detaljert og inneholder bare loggene fra 
den ene instansen av den tjenesten.  I en funksjon derimot er levealderen ephemeral siden en funksjon er bygd kun når en funksjon blir kalt, og er destruert rett etter at den er ferdig kjørt.
Dette gjør at logger etter en funksjon vil inneholde veldig korte logger med forkjellige instans-navn som gjør det vanskelig å kartlegge nøyaktig når og hvordan et problem oppsto. 

 - 3
 
    Fordelaktige aspekter ved serverless arkitektur er at du betaler kun for når en funksjon kjører, og skalering er håndtert av CSPen slik at kun resurser som kreves er aktivert.  I mikrotjenester 
må man derimot selv håndtere skalering av resurser, og man betaler kontinuelig siden en resurs vil kjøre konstant.  Manuel konfigruering av skalering tillater derimot for høy konfigruerbarhet 
og gjør det mulig for en utvikler å bestemme hvordan en resurs skal skalere.  Dette utsetter derimot en bedrift for potensielle farer som feilkonfigruering av skalering som kan føre til at det 
blir skalert høyere enn nødvendig, som fører til høyere ugifter.  Feilkonfigruering av skalering kan også føre til for lav skalering som kan føre til lavere responstid på en tjeneste. 

 - 4
 
    I mikrotjenester har utvikleren fullt eierskap av skalering og infrastruktur som nettverking, servere og sikkerhet.  I serverless derimot så er skalering, sikkerhet og annen infrastruktur 
håndtert av CSPen.  Dette gjør at utviklerne kan fokusere på utvikling av funksjonene framfor systemet funksjonen skal være del av.  I mikrotjenester så er ytelse i fullt eierskap av utviklerteamet. 
Det er helt opp til teamets evner til å designe og implementere et system optimalisert for ytelse.  Det er derimot mye lavere eierskap av ytelse hos serverless hvor nettverking, server konfigruering 
og skalering er håndtert av CSPen.  
    
    Det er også høyt eierskap hos mikrotjenesteprosjekter siden det er utviklerteamet som står for server-konfigruering og opprettholding av maskinvare.  Hos serverless prosjekter er derimot eierskapet av 
en tjenestes pålitelighet når det kommer til oppetid av nettverk og servere i CSPens hender iden de besitter maskinvaren og serverene som tjenestene skal kjøre på.  
    
    For et mikrotjenesteprosjekt er det hos utvikleren eierskapet for kostnadene ligger, siden det er de som står for konfigruering av servere og effektivisering av kode.  Utviklerteamet kan også 
kontrollere de løpene utgiftene ved å optimalisere de tjenestene som skal kjøre kontinuelig.  I et serverless prosjekt er eierskapet delt.  Når det kommer til kostnadene assosiert ved skalering er 
all kontroll over hvor effektivt det skalleres hos CSPen, og det er derfor i utviklerteamets beste interesse å utvikle funksjoner med minimal kjøretid.  Det er veldig viktig for begge arkitekturene 
å implementere pålitelig og effektiv kostnadsovervåkning for å forhindre at en resurs bruker unødvendig mye tid på en opperasjon.