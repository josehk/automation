# Watir Automation Example

## Requirements

- Ruby 2.0 +
- DevKit if using Windows
- Bundler Gem

```
    gem install bundler
```

## Chrome
In order to use Google Chrome you need to install its driver:
https://sites.google.com/a/chromium.org/chromedriver/

download it from here:
http://chromedriver.storage.googleapis.com/index.html


## Run test with RSpec

```
rspec goulet_spec.rb -I . --require environment
```

