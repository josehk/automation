# Watir Automation Example

## Requirements

- Ruby 2.2 +
- Bundler Gem

```
    gem install bundler
```

Run bundler to install the required gems

## Chrome Driver needed
In order to use Google Chrome you need to install its driver:
https://sites.google.com/a/chromium.org/chromedriver/

download it from here:
http://chromedriver.storage.googleapis.com/index.html


## Run test with RSpec

```
rspec goulet_spec.rb -I . --require environment
```

