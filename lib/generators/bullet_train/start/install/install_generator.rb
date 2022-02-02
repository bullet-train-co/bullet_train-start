# frozen_string_literal: true

require "rails/generators"
require "rails/generators/actions"

require 'byebug'

module BulletTrain
  module Start
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Create start script inside bin folder"

      def create_start_script
        puts("Creating \"start\" script inside \"bin\" folder\n")

        copy_file "start", "bin/start"

        puts("Success 🎉🎉\n\n")
      end

      desc "Create Procfile inside application root folder"

      def create_procfile
        puts("Creating Procfile inside application root")

        file_exists = File.exist?(Rails.root.join('Procfile'))

        if file_exists
          # add only processes that are different
          append_new_processes_to_procfile
        else
          copy_file("Procfile", "Procfile")

          puts("Success 🎉🎉\n\n")
        end
      end

      private

      def append_new_processes_to_procfile
        template_procfile_lines = `cat #{source_paths.first}/Procfile`.lines
        existing_procfile_location = Rails.root.join('Procfile')
        existing_procfile_lines = `cat #{existing_procfile_location}`.lines

        lines_to_append = template_procfile_lines - existing_procfile_lines

        if lines_to_append.blank?
          puts("\nExisting Procfile looks good 👍\n")
        else
          puts("\nAppending new processes to existing Procfile\n")

          append_file(existing_procfile_location, "\n#{lines_to_append.join}\n")

          puts("Success 🎉🎉\n\n")
        end
      end
    end
  end
end
