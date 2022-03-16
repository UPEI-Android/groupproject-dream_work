# For development
run ```yarn install``` to install all the modules
run ```yarn prisma db push``` to init the database
run ```yarn prisma generate``` to generate prisma client
run ```yarn run dev``` to start the server

# File structure
```
$root
├── prisma                  # database & database scheme
└── src
    ├── lib                 
    │   ├── handler         
    │   └── middleware      
    └── pages
        └── api             
            ├── auth       
            └── todos

```

# Modules
```prisma```
```uuid```
```next.js```
```next-connect```
```jsonaccesstoken```


# URI
## Todo item
```http(s)//hostname:port/api/todos```
- ```GET```  get all todo items for a specific user
- ```POST``` create a todo items for a specific user
- ```DELETE``` delete all todo items for a specific user

```http(s)//hostname:port/api/todos/[TODOITEM_ID]```
- ```GET``` get a todo item base on a specific ```TODOITEM_ID```
- ```DELETE``` delete a todo item base on a specific ```TODOITEM_ID```
- ```UPDATE``` update a todo item base on a specific ```TODOITEM_ID```

## Auth
```http(s)//hostname:port/api/auth/login```
- ```POST``` login api

```http(s)//hostname:port/api/auth/register```
- ```register``` register api