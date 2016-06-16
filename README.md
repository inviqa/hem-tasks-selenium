# hem-tasks-selenium


## Hem config
Update `tools/hem/config.yaml` with the following settings:

    :selenium:
      :version: [major.minor.patch]
    :chromedriver:
      :download:
        :mac: [Mac chromedriver url]
        :linux: [Linux chromedriver url]

Example:

    :selenium:
      :version: 2.53.0
    :chromedriver:
      :download:
        :mac: http://chromedriver.storage.googleapis.com/2.21/chromedriver_mac32.zip
        :linux: http://chromedriver.storage.googleapis.com/2.21/chromedriver_linux64.zip

## Behat config
Update `behat.yaml` with a `Firefox` and a `Chrome` profile:

Example (configs will vary):

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