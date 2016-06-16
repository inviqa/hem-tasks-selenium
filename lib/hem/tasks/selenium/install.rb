desc 'Install Selenium'
task :install do
  require 'hem/lib/selenium/jar';

  downloadUrl = Hem::Selenium::Jar.getDownloadUrl();
  jarPath = Hem::Selenium::Jar::getLocalPath();

  if !File.exists?(jarPath)
    if !Hem::Url.exists(downloadUrl)
      Hem.ui.error('Unable to download selenium standalone server!');
      Hem.ui.error("Version #{Hem.project_config.selenium.version} does not exist, please choose a different version.");
      exit!
    end

    Hem.ui.info('Downloading selenium...');
    run_command "wget '#{downloadUrl}' --output-document #{jarPath}"
  end

  Hem.ui.success('Selenium Installed.')
end
