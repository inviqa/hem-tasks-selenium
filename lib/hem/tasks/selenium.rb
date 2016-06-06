desc 'Selenium tasks'
namespace :selenium do
  desc 'Install Selenium'
  task :install do
    cmd = [
      "test -f ./bin/selenium-server-standalone.jar",
      "|| wget '#{Hem.project_config.selenium.download}' --output-document ./bin/selenium-server-standalone.jar"
    ].join(' ')
    run_command cmd
    Hem.ui.success('Selenium Installed.')
  end

  desc 'Start Selenium'
  task :start do
    cmd  = [
      'export NSPR_LOG_MODULES=all:3;',
      "java -jar './bin/selenium-server-standalone.jar'",
        '-Dwebdriver.firefox.logfile=/tmp/selenium-firefox.log',
        '-Dwebdriver.chrome.driver=./bin/chromedriver',
        '-trustAllSSLCertificates',
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
    Rake::Task['selenium:start'].invoke

    Hem.ui.success('Selenium connection forwarded into VM.')
    Hem.ui.separator
    Hem.ui.info("You can now run Behat in Firefox or Chrome:")
    Hem.ui.info('   bin/behat -p [firefox|chrome]')
    Hem.ui.separator
    exec cmd
  end
end
