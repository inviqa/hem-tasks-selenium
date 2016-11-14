desc 'Selenium tasks'
namespace :selenium do
  require_relative 'selenium/chromedriver'
  require_relative 'selenium/geckodriver'
  require_relative 'selenium/install'
  require 'hem/lib/selenium/jar'

  desc 'Start Selenium'
  task :start do
    jarPath = Hem::Selenium::Jar::getLocalPath();
    cmd  = [
      'export NSPR_LOG_MODULES=all:3;',
      'java ',
        '-Dwebdriver.firefox.logfile=/tmp/selenium-firefox.log',
        '-Dwebdriver.chrome.driver=./bin/chromedriver',
        '-Dwebdriver.gecko.driver=./bin/geckodriver',
        "-jar '#{jarPath}'",
        '> /tmp/selenium-general.log 2>&1 &',
        'echo $! > /tmp/selenium.pid'
    ].join(' ')
    shell cmd
    Hem.ui.success('Selenium Started (includes Chromedriver).')
  end

  desc 'Stop Selenium'
  task :stop do
    shell '[ -f /tmp/selenium.pid ] && kill -TERM $(cat /tmp/selenium.pid); rm -f /tmp/selenium.pid'
    Hem.ui.success('Selenium Stopped.')
  end

  desc 'Forward selenium connection to VM'
  task :forward do
    require 'tempfile'
    config = ::Tempfile.new 'hem_ssh_config'
    config.write Hem::Lib::Vm::Inspector.new().ssh_config
    config.close

    cmd = [
      # Forward SSH Session
      'ssh',
      "-F #{config.path.shellescape}",
      '-t',
      '-R 4445:localhost:4444',
      'default',
      '-- "cd /vagrant; exec /bin/bash";',
      '[ -f /tmp/selenium.pid ] && kill -TERM $(cat /tmp/selenium.pid); rm -f /tmp/selenium.pid'
    ].join(' ')

    Rake::Task['selenium:install'].invoke
    Rake::Task['selenium:chromedriver:install'].invoke
    Rake::Task['selenium:geckodriver:install'].invoke
    Rake::Task['selenium:start'].invoke

    Hem.ui.success('Selenium connection forwarded into VM.')
    Hem.ui.separator
    Hem.ui.info("You can now run Behat in Firefox or Chrome:")
    Hem.ui.info('   bin/behat -p [firefox|chrome]')
    Hem.ui.separator
    exec cmd
  end
end
