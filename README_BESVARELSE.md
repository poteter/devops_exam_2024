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
___

### oppgave 3

- A

        #### docker image
        primussy/devops243b:main
            
        #### sqs url
        https://sqs.eu-west-1.amazonaws.com/244530008913/candidate_2_bedrock_sqs_queue
            
        #### begrunnelse for tag strategi
        Jeg valgte å tagge en image tre ganger for å gjøre det lettere å identifisere hvilken branch og commit en image kommer fra.
    
    
### oppgave 5



