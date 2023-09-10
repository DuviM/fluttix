const jsonServer = require('json-server')
const app = jsonServer.create()
const router = jsonServer.router('db.json')
const middlewares = jsonServer.defaults()
const auth = require('json-server-auth')

router.db._.mixin({
  getById(collection, id) {
    if (! id) return

    const idProp = this.__id()

    if (Array.isArray(id)) {
      const ids = id.map(_id => _id.toString())

      return this.filter(collection, doc => {
        if (this.has(doc, idProp)) {
          return ids.includes(doc[idProp].toString())
        }
      })
    }

    return this.find(collection, doc => {
      if (this.has(doc, idProp)) {
        return doc[idProp].toString() === id.toString()
      }
    })
  }
})

app.use(middlewares).use(auth).use(jsonServer.bodyParser).use((req, res, next) => {
  if (req.method === 'POST') {
    req.body.createdAt = Date.now()
  }

  next()
}).use(router)

app.listen(3000, () => {
  console.log('Serveur démarré (http://localhost:3000/) !')
})
