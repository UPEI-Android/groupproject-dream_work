Dream Work

# Demo server
- server: dream.luobo.ca
- https: yes
- account: demo@upei.ca
- password: demo


[GitHub](https://github.com/UPEI-Android/groupproject-dream_work)
[DockerHub](https://hub.docker.com/repository/docker/wtc133/dream-work)
 
# Feature
- Self-host able server, one command deployment.
- Easy to track progress.
- Easy to track activities.
- Work as a team (under developing)

# Architecture
## App
```shell
$ROOT
├── lib
│   ├── dream_connector   # flutterfire like library
│   │   └── utils        # utils (eg. path resolver, logger)
│   ├── screens           # views of app
│   ├── utils             # utils (eg. functinals deal with raw data)
│   └── widgets        
│       ├── button        # buttons
│       ├── card          # card widgets
│       ├── form          # Forms (eg. signin/register form)
│       └── tab           # Tabs on home screen.
└── test                     
```


### Dream Connector
- A flutterfire like library
- Customized for our backend server
- Easy to connect with backend server
- Provides methods can be easy handle 
- Most of them are return a Future so it can use with `.then()` , `.cathError()`

```dart
Future loginWithEmailAndPassword({
	required String email,
	required String password,
}){...}

Future logout(){...}
```


#### Three main  module:
1. `core` :
```dart
// initialization the service 
// create and assign DreamCore object to DreamAuth, Dreabase.
DreamCore.initializeCore({
serverUrl: 'localhost',
serverPort: '3000',
serverProtocol: 'http',
});

//or 

DreamCore.core({
serverUrl: 'localhost',
serverPort: '3000',
serverProtocol: 'http',
});

/// return server url if server is available
/// throw exception if server is not available 
.state();
```

2. `auth` : 
```dart
// singleton
// register with email and password
await DreamAuth.instance.createUserWithEmailAndPassword({
	name: 'demo',
	email: 'demo@demo.com',
	password: 'demo',
})
.then((e) => print('login'))
.catchError((e) => print('failed'));


// login with email and password, this will fetch the user token.
await DreamAuth.instance.loginUserWithEmailAndPassword({
	email: 'demo@demo.com',
	password: 'demo',
})
.then((e) => print('login'))
.catchError((e) => print('failed'));


// return a JWT auth token
DreamAuth.instance.authToken();

// return a stream contains user informations (eg. email, name)
DreamAuth.instance.authState(); 

/// Return a stream contains the server loading status
DreamAuth.instance.loadingState();

/// and few private methos
```

3. `database` : 
```dart
// Singleton

/// Return a stream contains the connection status
DreamDatabase.instance.connectState();

/// same as auth
DreamDatabase.instance.loadingState();

/// connect to server
/// Read data from database every 10 seconds
DreamDatabase.instance.connect();

/// disconnect from server
DreamDatabase.instance.disconnect();

/// write
/// return future<void>
DreamDatabase.instance.writeOne(Map<String, dynamic> item)
DreamDatabase.instance.writeMany(List<Map<String, dynamic>> items)

// read
// return future<void>
// read method don't need any parameter
// backend service will recognized user by authtoken
DreamDatabase.instance.readMany();

// delete
// return future<void>
DreamDatabase.instance.deleteOne();
DreamDatabase.instance.deleteMany();

/// !!! This is the data get from server that you can use!!!
/// Return a stream contains all the todoitems belong to the user
DreamDatabase.instance.items();

/// To use this stream
return StreamBuilder(
      stream: DreamDatabase.instance.items,
      builder: (BuildContext context, AsyncSnapshot snap) {
      /// if no data in the stream, show a loading
        if (snap.data == null || snap.hasError) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.greenAccent,
            ),
          );
        }
	return ListView.builder(
          itemCount: snap.data.length,
          itemBuilder: (context, index) => print(snap.data[index])
          ),
        );
	
```

Initialize core -> login -> connect API.

#### raw json data process
![[Pasted image 20220406054807.png]]
- Every JSON fetch from server will be convert  into List<Map<String, dynamic>>`.
- Functional programming to deal with them.
- Don't need to transformation data to objects, much more flex, for example:

```dart
// convert json to  List<List<Map<String, dynamic>>>
final List<dynamic> rawData = json.decode(response.body);
final List<Map<T, E>> data = rawData.map((e) => Map<T, E>.from(e)).toList();

/// find all sections in the source data.
rawData.map((e) => e['section']).toSet().toList();


/// calculate the precentage of finished task in a section.
rawData
	.where((element) => element['section'] == section)	
	.map((element) => element['isDone'].toString())
	.toList()
	.where((element) => element == 'true')
	.length /
	rawData.where((element) => element['section'] == section).length;


/// delete all the task items in a give section
rawData
	.where((e) => e['section'] == title)
	.forEach((e) => DreamDatabase.instance.deleteOne(tid: e['tid']);
	
```


## Server
- Write with TypeScript

``` shell
$ROOT
├── prisma                # Database & ORM
└── src                 
    ├── lib             
    │   └── middleware   # Middleware 
    └── pages
        └── api          
            ├── auth      # Auth API
            └── tasks     # Task API
```

#### Library
- `prisma` 
- `next.js` 
- `next-connect` 
- `jsonaccesstoken`
- `sqlite`

#### API
##### AUTH
`http(s)//hostname:port/api/auth/login`
- `POST` login 

`http(s)//hostname:port/api/auth/register`
- `POST` register 

##### DATA
*Required Access Token in request header*

`http(s)//hostname:port/api/tasks`
- `GET` get all todo items for a specific user
- `POST` create a todo items for a specific user
- `DELETE` delete all todo items for a specific user
- `PUT` working on this

`http(s)//hostname:port/api/tasks/[TASK_ID]`
- `GET` get a todo item base on a specific `TASK_ID`
- `DELETE` delete a todo item base on a specific `TASK_ID`
- `UPDATE` update a todo item base on a specific `TASK_ID`
- `PUT` working on this



# Known Issues
- Render issue when change section name
- Bad choice of API method, GraphQL should be more suitable.
- Lack of PUT UPDATE HTTP methods, Updates need to go through DELETE first and then POST. 
- Latency! Too much extra HTTP connection, make a lot extra TCP handshake.
- Sometime app will not reconnect to server after disconnect.


# Future Plan

## More task actions
- Due date
- Attach file
- ...

##  More custom card widgets
- Show other users' activities.
- link with GitHub contributions.
- ...

## Offline and Reduce latency
- Save every active in a local database, then sent those active to server like a queue. 

## Group Work
- Users will be able to join as a group.
- Highlight the change.

## Security
- Add refresh JWT token.
- Obfuscated plan text password into an indiscernible value.

## Optimize API
- Add PUT method for updating data.
- Find a way to reduce the data.
