exports.post = (req, res)->
  throw 422 unless req.body.content

  req.db.collection('tweets').insert
    content: req.body.content.slice 0,140
    created_at: new Date