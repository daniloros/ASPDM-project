**Nome:** Danilo Rosati

**Matricola:** 310239

# Healty

Healty è un applicazione pensata per il rapporto tra nutrizionista e cliente.
In particolare, al cliente è permesso consultare la propria dieta e tenere traccia dell'analisi della composizione corporea.
Al nutrizionista sarà permesso inserire la dieta e i valori rilevati dal check con il cliente.

<br>
<br>


### Credenziali

Per utilizzare l'applicazione è richiesta una coppia user/password.
Per il testing è possibile utilizzare un qualsiasi account già presente nel database:

|User|Password|Descrizione
| --------------------------- | ----------------- | ----------------- |
| Admin | Admin            | Nutrizionista 
| Danilo        | Danilo              | Cliente
| Stefano        | Stefano              | Cliente
| Rossi         | Test              | Cliente senza dieta

<br>
<br>

### Casi d'uso e Interfaccia Utente

Durante il primo avvio all'utente è mostrata la **pagina di login**, qui è possibile inserire il proprio username e password. Nel caso i dati forniti non siano corretti è mostrato un messaggio d'errore altrimenti l'utente è trasportato nella pagina home e i suoi dati d'accesso sono salvati per la prossima volta.
<p align="center">
    <img src="docs/images/Login.gif" alt="Pagina di login" width=200/>
</p>

Nella **Pagina Home** è possibile vedere i valori della propria composizione corporea relativi all'ultimo check effettuato con il nutrizionista

<p align="center">
    <img src="docs/images/Homepage_normal.gif" width="200"/> <img src="docs/images/homepage_landscape.png" width="300"/>
</p>

Premendo l'icona **Dieta** nella barra di navigazione inferiore l'utente atterra nella pagina dedicata alla propria dieta.
<br>
La pagina presenterà due Tab:
 - Dieta pranzo: dove verrà visualizzata la dieta corrente e, se c'è ne sono, la lista di quelle vecchie ormai archiviate.
   <p align="center"><img src="docs/images/user_lunch_diet.gif" width="200"/> </p>
 - Dieta cena: dove verrà visualizzata la dieta corrente e, se c'è ne sono, la lista di quelle vecchie ormai archiviate.
  <p align="center"><img src="docs/images/user_dinner_lunch.gif" width="200"/></p>


Al tap su una dieta, che sia corrente o archiviata, si aprirà il dettaglio:
<p align="center"><img width="200" src="docs/images/dettaglio_dieta.png"/> </p>

Oppure, girando lo smartphone avendo una visuale landscape si visualizzerà il dettaglio della dieta corrente:
<p align="center"><img width="200" src="docs/images/current_diet_landscape.gif"/> </p>


Premendo l'icona **Esci** verrà effettuato il logout dall'applicazione:
<p align="center"><img width="200" src="docs/images/Logout.gif"/> </p>


<br>
<br>

### Casi d'uso e Interfaccia Nutrizionista

Effettuando il login come **Nutrizionista** atterriamo sulla **Homepage** che presenterà la lista dei clienti e il relativo pulsante che permette la creazione di un nuovo utente:
<p align="center"><img src="docs/images/admin_homepage.png" width="200"/> </p>

La creazione di un nuovo utente porta verso il **form di compilazione dei dati**.
Qui il nutrizionista, attraverso un form a step, inserisce:
- i dati anagrafici del cliente
- username e password per l'accesso
- i dati provenienti dalla bioimpedenza

Terminato l'inserimento dei dati, viene mostrata una **pagina di riepilogo** che permette la modifica dei dati nel caso in cui fossero scorretti, oppure la conferma di creazione del nuovo cliente:
<p align="center"><img src="docs/images/new_user.gif" width="200"/> </p>

<br>

Il nutrizionista può eliminare un cliente effettuando uno swipe verso destra sul nome del cliente presente nella lista:
<p align="center"><img src="docs/images/delete_user.gif" width="200"/> </p>

<br>

Al tap sul cliente, atterriamo nella **pagina di gestione del cliente**.
<p align="center"><img src="docs/images/admin_user_detail.png" width="200"/> </p>

Dove sarà possibile: <br>
**1.** visualizzare i dati anagrafici e i dati dell'analisi della composizione corporea relativi all'ultimo check:
<p align="center"><img src="docs/images/admin_user_info.png" width="200"/> </p>

Cliccando il tasto **Modifica** sarà possibile modificare i dati della composizione corporea con i nuovi dati provenienti dalla bioimpedenza. <br>
Nel caso in cui uno di questi campi risultasse vuoto viene mostrato un messaggio di errore. Altrimenti si prosegue con la modifica dei dati:
<p align="center"><img src="docs/images/admin_modify_user.gif" width="200"/> </p>

<br>

**2**. Visualizzare le diete create per pranzo, con la possibilità di crearne una nuova:
<p align="center"><img src="docs/images/admin_lunch.png" width="200"/> </p>

**3**. Visualiuzzare le diete create per cena, con la possibilità di crearne una nuova:
<p align="center"><img src="docs/images/admin_dinner_page.png" width="200"/> </p>



Nel caso in cui uno dei campi risultasse vuoto viene mostrato un messaggio di errore. Altrimenti si prosegue con la creazione delle dieta.
<br>
Quando viene creata una nuova dieta, nel caso ne fosse presente già una corrente, quest'ultima viene archiviata. In modo tale da poter presentare come dieta corrente quella più nuova.
<p align="center"><img src="docs/images/admin_add_new_diet.gif" width="200"/> </p>

Il procedimento di creazione di una dieta è il medesimo per il pranzo e la cena.

<br>
<br>

## Tecnologia

L'applicazione si appoggia su [restdb.io](restdb.io), un database cloud NoSQL che permette l'accesso ai dati tramite HTTP come se fossero oggetti JSON. <br>
L'acceso ai dati viene protetto tramite chiave API. Il database può essere interrogato tramite chiamate REST


## Pacchetti aggiuntivi

Nell'applicazione sono stati utilizzati diversi pacchetti aggiuntivi dichiarati come `dependencies` e `dev_dependencies`, fra questi quelli più interessanti sono:

- [json_serializable](https://pub.dev/packages/json_serializable) libreria che genera codice per convertire automaticamente una classe dart da/in JSON
- [settings_ui](https://pub.dev/packages/settings_ui) libreria che permette la creazione facilitata della schermata "Impostazioni". Usata per creare la pagina **gestione del cliente**
- [http](https://pub.dev/packages/http) libreria utilizzata per le richieste HTTP