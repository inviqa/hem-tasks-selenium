require 'ffi'

namespace :selenium do
  desc 'Chromedriver tasks'
  namespace :chromedriver do
    desc 'Install Chromedriver'
    task 'install' do

      if FFI::Platform::IS_MAC
        downloadUrl = Hem.project_config.chromedriver.download.mac
      elsif FFI::Platform::IS_LINUX
        downloadUrl = Hem.project_config.chromedriver.download.linux
      end

      cmd = [
        'test -f ./bin/chromedriver',
        '|| (',
          "wget '#{downloadUrl}' --output-document ./bin/chromedriver.zip",
          '&& sudo yum install unzip -y',
          '&& unzip ./bin/chromedriver.zip -d ./bin/',
          '&& rm --force ./bin/chromedriver.zip',
        ')'
      ].join(' ')

      run_command cmd
      Hem.ui.success('Chromedriver Installed.')
    end
  end
end
