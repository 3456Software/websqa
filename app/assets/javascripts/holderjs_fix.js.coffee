# Fix holder.js with turbolinks
$(document).bind 'page:change', ->
  Holder.run()
