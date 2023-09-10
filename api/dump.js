const fs = require('fs')
const { $fetch } = require('ofetch')
const bcrypt = require('bcryptjs')
const dotenv = require('dotenv')
dotenv.config()

const baseUrl = 'https://api.themoviedb.org/3'

const getGenres = async () => {
  const { genres } = await $fetch(`${baseUrl}/genre/movie/list?api_key=${process.env.MOVIE_DB_API_KEY}&language=fr-FR`)

  return genres.map(genre => ({ ...genre }))
}

const getMoviesOrActors = async (pages = 2) => {
  let actors = []
  let movies = []

  for (let page = 1; page <= pages; page++) {
    const { results } = await $fetch(`${baseUrl}/movie/now_playing?api_key=${process.env.MOVIE_DB_API_KEY}&language=fr-FR&page=${page}`)

    movies = movies.concat(await Promise.all(results.map(async (movie) => {
      const result = await $fetch(`${baseUrl}/movie/${movie.id}?api_key=${process.env.MOVIE_DB_API_KEY}&language=fr-FR&append_to_response=videos,credits`)
      const { genres, videos } = result
      const actorsMovie = result.credits.cast.slice(0, 5)

      actorsMovie.forEach(async (actor) => {
        let existing = actors.find(a => a.id === actor.id)

        if (existing) {
          existing.moviesId.push(movie.id)
        } else {
          const result = await $fetch(`${baseUrl}/person/${actor.id}?api_key=${process.env.MOVIE_DB_API_KEY}&language=fr-FR`)

          actors.push({
            ...actor,
            ...(delete result.also_known_as && result),
            profile_path: result.profile_path ? `https://image.tmdb.org/t/p/w500${result.profile_path}` : null,
            moviesId: [movie.id]
          })
        }
      })

      return {
        ...(delete result.genres && delete result.credits && delete result.videos && delete result.spoken_languages
          && delete result.belongs_to_collection && delete result.production_companies && delete result.production_countries && result),
        backdrop_path: `https://image.tmdb.org/t/p/original${result.backdrop_path}`,
        poster_path: `https://image.tmdb.org/t/p/w500${result.poster_path}`,
        youtube: videos.results[0]?.key,
        genreId: genres[0].id,
        actorsId: actorsMovie.map(actor => actor.id),
      }
    })))
  }

  return { actors, movies }
}

(async () => {
  const { movies, actors } = await getMoviesOrActors(2)
  const now = Date.now() - 100000000

  const data = {
    genres: await getGenres(),
    movies,
    actors,
    comments: [
      { id: 1, message: 'Super film', createdAt: now, movieId: 346698, userId: 3 },
      { id: 2, message: 'Encore un super film', createdAt: now + 2567000, movieId: 346698, userId: 2 },
      { id: 3, message: 'Et encore un super film', createdAt: now + 5164000, movieId: 346698, userId: 1 },
    ],
    users: [
      { id: 1, name: 'Fiorella', email: 'fiorella@boxydev.com', password: bcrypt.hashSync('password') },
      { id: 2, name: 'Matthieu', email: 'matthieu@boxydev.com', password: bcrypt.hashSync('password') },
      { id: 3, name: 'Marina', email: 'marina@boxydev.com', password: bcrypt.hashSync('password') },
    ],
  }

  fs.writeFileSync('db.json', JSON.stringify(data))
})()
