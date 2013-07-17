# PathHelper

A helper library for generating complete CSS selector paths

## Usage

```javascript
el = document.getElementById('main')
path_helper = new PathHelper()
path_helper.get_path(el)
#=> "body.books:nth-child(2) > div.navbar.navbar-inverse.navbar-static-top:nth-child(1) ~ div#main.container:nth-child(2)"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
