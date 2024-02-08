![Logo](https://quikke.vercel.app/assets/logo.svg)

Quikke is a lightweight online todo application built with the MEAN stack, offering users an intuitive interface for task management. With features like task filtering and secure authentication, Quikke enhances productivity while prioritizing user experience and data security.

Backend link: [<img src="https://img.shields.io/badge/Backend-grey?logo=express&logoColor=green" />](https://quikke.onrender.com)
<br>
Frontend link: [<img src="https://img.shields.io/badge/Frontend-grey?logo=angular&logoColor=red" />](https://quikke.vercel.app/auth)

# Design

The design of Quikke was implemented using 
[<img src="https://img.shields.io/badge/Figma-grey?logo=figma&logoColor=blue" />](https://www.figma.com/file/XDRAtG9MBa7O2k3JQ9zA0I/quikke---solo?type=design&node-id=211%3A279&mode=dev&t=WHc8fwiU0yCPDP7M-1) (<i>click for preview)</i>

 ## Color Reference

| Color             | Hex                                                                |
| ----------------- | ------------------------------------------------------------------ |
| Base Color | ![#101010](https://via.placeholder.com/10/101010?text=+) #101010 |
| Main Color | ![#3FB5E8](https://via.placeholder.com/10/3FB5E8?text=+) #3FB5E8 |
| First Color | ![#FFFFFF](https://via.placeholder.com/10/FFFFFF?text=+) #FFFFFF |
| Second Color | ![#878787](https://via.placeholder.com/10/878787?text=+) #878787 |


# Backend 

The backend of Quikke was implemented using Express.js and Mongoose, ensuring robust API development and efficient database interaction for seamless data management and retrieval.

## Scripts

<kbd>build</kbd> - Build the application

```bash
$ npx tsc
``` 

<kbd>start</kbd> - Start the production version of the application

```bash
$ node dist/index.js
```

<kbd>dev</kbd> - Start the development version of the application

```bash
$ npx tsc -w & nodemon dist/index.js
```

## API endpoints

#### Register a new user

```http
  POST /auth/register
```

| Body | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `login` | `string` | **Required**. Login of user |
| `password` | `string` | **Required**. Password of user |

#### Login a user

```http
  POST /auth/login
```

| Body | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `login` | `string` | **Required**. Login of user |
| `password` | `string` | **Required**. Password of user |

#### Check user authorization 

```http
  GET /auth/me
```

| Auth | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Bearer token` | `string` | **Required**. User token |

#### Get all user tasks 

```http
  GET /tasks
```

| Auth | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Bearer token` | `string` | **Required**. User token |

#### Get all user unique tags 

```http
  GET /tasks/tags
```

| Auth | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Bearer token` | `string` | **Required**. User token |

#### Filter tasks by a search string

```http
  GET /tasks/filtered/:search
```

| Auth | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Bearer token` | `string` | **Required**. User token |

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `search` | `string` | **Required**. Requested string based on which filtering will be performed |

#### Create a new task

```http
  POST /tasks
```

| Auth | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Bearer token` | `string` | **Required**. User token |

| Body | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `title`| `string` | **Required**. Title of task |
| `tag` | `string` | Tag of task |

#### Delete a task

```http
  DELETE /tasks/:taskId
```

| Auth | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `Bearer token` | `string` | **Required**. User token |

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `taskId`| `string` | **Required**. Id of task |

# Frontend

The frontend of Quikke was implemented using Angular 15 and SASS, providing a modern and responsive user interface for seamless task management.

## Scripts

<kbd>start</kbd> - Start the development version of the application

```bash
$ ng serve
``` 

<kbd>build</kbd> - Build the application

```bash
$ node dist/index.js
```

# Contacts
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/teapotka/)
[![gmail](https://img.shields.io/badge/gmail-1DA1F2?style=for-the-badge&logo=gmail&logoColor=red)](mailto:tymofii.sukhariev@gmail.com)
