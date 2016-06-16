module Hem
  module Selenium
    class Release
      @@version = ''

      def self.getMajorMinor()
          extractVersion()
          return @@version['major_minor']
      end

      def self.getMajorMinorPatch()
          extractVersion()
          return @@version['major_minor_patch']
      end

      private

      def self.extractVersion()
          @@version=/^(?<major_minor_patch>(?<major_minor>\d+\.\d+)\.\d+)$/.match("#{Hem.project_config.selenium.version}")

          if !@@version
            Hem.ui.error('Selenium version format is invalid (see config.yaml)!');
            Hem.ui.error("  Invalid format: #{Hem.project_config.selenium.version}");
            Hem.ui.error('    Valid format: major.minor.patch (e.g. 2.53.0)');
            exit!
          end
      end
    end
  end
end
