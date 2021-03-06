# coding: utf-8
require 'imap-filter'

include ImapFilter::DSL

module ImapFilter
  module Cli
    class Main < Thor
      class_option :verbose, type: :numeric, banner: '[1|2|3|4]', aliases: '-v', default: 0
      @@default_script = ENV['IMAPF_IMAP_FILE'] || 'default.imap'
      
      desc 'filter [script]', "Run the powerplay script. Default #{@@default_script}"
      option :dryrun, type: :boolean, aliases: '-u', desc: "Dry run, do not actually execute."
      option :test, type: :boolean, aliases: '-t', desc: "Test IMAP accounts only."
      option :filters, type: :array,   aliases: '-f', banner: %(<FILT1>[ FILT2 FILT3...]), 
                                                      desc: "Run specified filters. The default is to run all of them."
      def filter(script = @@default_script)
        _global[:options] = options
        puts "script %s " % [script] if _options[:verbose] >= 1
        load script, true
      end

      def list
      end
    end
  end
end
