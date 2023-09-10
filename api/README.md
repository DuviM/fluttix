# API de Vueflix

Ceci est l'API de Vueflix basée sur les données de [TMDB](https://www.themoviedb.org).

## Installation et lancement

```bash
npm install
cp .env.example .env
node index.js
```

Il faut mettre votre clé TMDB dans la variable `MOVIE_DB_API_KEY`.

Et voilà, vous avez l'API sur `http://localhost:3000` en local ou `https://api.vueflix.boxydev.com`.

J'utilise la base de [Json Server](https://github.com/typicode/json-server), sur la documentation tout est indiqué pour réaliser les requêtes en GET, POST, PUT ou DELETE. J'ai aussi ajouté la partie authentification avec ce [middleware](https://github.com/jeremyben/json-server-auth). On peut donc s'inscrire ou se connecter sur cette API.

Voici les URLs de l'API :

| URL                                                              | Fonctionnalité(s)                                                            |
| ---------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| http://localhost:3000/movies                                     | Tous les films                                                               |
| http://localhost:3000/movies?_expand=genre&_expand=actors        | Tous les films avec leur catégorie et leurs acteurs                          |
| http://localhost:3000/movies/346698                              | Un film                                                                      |
| http://localhost:3000/movies/346698?_expand=genre&_expand=actors | Un film avec sa catégorie et ses acteurs                                     |
| http://localhost:3000/genres/28                                  | Une catégorie                                                                |
| http://localhost:3000/genres/28?_embed=movies                    | Une catégorie et ses films                                                   |
| http://localhost:3000/movies/346698/comments?_expand=user        | Les commentaires d'un film et le créateur                                    |
| http://localhost:3000/movies/346698/comments (en POST)           | Créer un commentaire sur un film (Il faut un message et un ID d'utilisateur) |
