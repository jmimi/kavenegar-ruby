module KaveRestApi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates KaveRestApi initializer for your application"

      def copy_initializer
        template "kavenegar-ruby_initializer.rb", "config/initializers/kavenegar-ruby.rb"
        
         puts <<~EOF
        \e[36mInstall complete 👻 \e[0m
          For report issues or suggest feature contact me on twitter/github: \e[32m@mm580486\e[0m 
         EOF
      end

    end
  end
end