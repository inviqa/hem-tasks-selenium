# Selenium Forwarding

Visualise the steps of your Behat features directly on your __host__ browser.

## Supported Browsers

* Firefox
* Chrome

## Installation

Add the following code to your `Hemfile`:

    plugins do
      source 'https://rubygems.org'
      gem 'hem-tasks-selenium'
    end

and if you want to use the latest development version:

    plugins do
      source 'https://rubygems.org'
      gem 'hem-tasks-selenium', git: 'https://github.com/inviqa/hem-tasks-selenium.git'
    end

### Configuration

#### Hem config
Update `tools/hem/config.yaml` with the following settings:

    :selenium:
      :version: [major.minor.patch]
    :chromedriver:
      :download:
        :mac: [Mac chromedriver url]
        :linux: [Linux chromedriver url]
    :geckodriver:
      :download:
        :mac: [Mac geckodriver url]
        :linux: [Linux geckodriver url]
        :windows: [Windows geckodriver url]

Example:

    :selenium:
      :version: 2.53.0
    :chromedriver:
      :download:
        :mac: http://chromedriver.storage.googleapis.com/2.21/chromedriver_mac32.zip
        :linux: http://chromedriver.storage.googleapis.com/2.21/chromedriver_linux64.zip
    :geckodriver:
      :download:
        :mac: https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-macos.tar.gz
        :linux: https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-linux64.tar.gz
        :windows: https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-win64.zip

##### Versions

* Latest Selenium standalone servers:
    http://selenium-release.storage.googleapis.com/index.html
* Latest Chromedrivers:
    http://chromedriver.storage.googleapis.com/index.html

#### Behat config
Update `behat.yaml` with a `Firefox` and `Chrome` profile.

Examples (configs will vary):

    chrome:
      extensions:
        Behat\MinkExtension:
          base_url: 'http://project.dev'
          goutte: ~
          selenium2:
            wd_host: 'http://192.168.10.1:4444/wd/hub'
            browser: chrome
          show_cmd: echo '%s'
          show_tmp_dir: /vagrant

    firefox:
      extensions:
        Behat\MinkExtension:
          base_url: 'http://project.dev'
          goutte: ~
          selenium2:
            wd_host: 'http://192.168.10.1:4444/wd/hub'
            browser: firefox
          show_cmd: echo '%s'
          show_tmp_dir: /vagrant

## Usage

1. Run `hem selenium forward`.
    * __Selenium__ and __Chromedriver__ will be downloaded & installed automatically.
2. Run `bin/behat -p firefox` or `bin/behat -p chrome`.
    * Each step of a feature will now be visualised through your host `Firefox` or `Chrome` browser.
