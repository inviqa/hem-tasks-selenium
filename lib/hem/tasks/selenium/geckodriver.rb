require 'ffi'

desc 'Geckodriver tasks'
namespace :geckodriver do
  desc 'Install Geckodriver'
  task 'install' do

    if FFI::Platform::IS_MAC
      downloadUrl = Hem.project_config.geckodriver.download.mac
    elsif FFI::Platform::IS_LINUX
      downloadUrl = Hem.project_config.geckodriver.download.linux
    elsif FFI::Platform::IS_WINDOWS
      downloadUrl = Hem.project_config.geckodriver.download.windows
    end

    cmd = [
      'test -f ./bin/geckodriver',
      '|| (',
        "wget '#{downloadUrl}' --output-document ./bin/geckodriver.zip",
        '&& sudo yum install unzip tar -y',
        "&& if [[ $(file --mime-type ./bin/chromedriver.zip) == *'application/zip' ]]; then unzip ./bin/chromedriver.zip -d ./bin/; else tar -xvf ./bin/chromedriver.zip -C ./bin/; fi",
        '&& rm --force ./bin/chromedriver.zip',
      ')'
    ].join(' ')

    run_command cmd
    Hem.ui.success('Geckodriver Installed.')
  end
end
