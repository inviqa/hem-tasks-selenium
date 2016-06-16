module Hem
  module Selenium
    class Jar
      require_relative 'release'

      def self.getDownloadUrl()
        return 'http://selenium-release.storage.googleapis.com/' +
                Hem::Selenium::Release.getMajorMinor() +
                '/selenium-server-standalone-' +
                Hem::Selenium::Release.getMajorMinorPatch() +
                '.jar'
      end

      def self.getLocalPath()
        return './bin/selenium-server-standalone-' +
               Hem::Selenium::Release.getMajorMinorPatch() +
               '.jar'
      end
    end
  end
end
