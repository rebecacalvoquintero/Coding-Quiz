 Healthforge Quiz test consists in two parts
 ### 1.  Question One
 
 In this section, there is an input field where you could search by name, last name or data of birth         and you will be given the name of the patients that match your search. For stylying purposes, only 10 results will be shown in each page. You could also sort the patients alphabetically or by age.
     If you want to go to the next page, please click the button next. If on the contrary, you want to go to a previous page, click previous.
     For more details on the patients, click on the patient's row, and you will be redirected to another page with more information about the client
     
  ### How to run Question One in your computer    
  
  Copy the following commands in your terminal:
  
   ``` 
      git clone git@github.com:rebecacalvoquintero/Coding-Quiz.git
      
      cd Question_One
 
     elm-live src/Main.elm --open --pushstate --output=elm.js
 ```
 And finally go to ```localhost/8000```
     
  ### 2.  Question Two

To access to the table mentioned in Question One, you should login with the correct credentials. Once login yo will be given a token with which you will be able to send a request to the authentificated api to get the patients' data in our table
 
 
 ## Instructions of how to run it
 
 Copy the following in your terminal
 
 ``` 
     cd Question_Two
     npm install
     npm start
     
 ```
 go to ```localhost/4444```
 
 ## HOW?
 
 * Elm: One of the advantages of doing it in Elm is that I do not feel that guilty for not having tests. If there is an error, the code will not compile. This is the beauty of Elm. Also, I do not have to worry about the browsers incompatibility as Elm will translate all my code.
 * Node: For my server I am using express.
 * Tachyons for stylying as they take less space than normal css and I wont have to worry that much about refactoring the css file.
 
