#
# ebuild.rb - a ebuild module of LangScan
#
# Copyright (C) 2005 Kenichi Ishibashi <bashi at dream.ie.ariake-nct.ac.jp>
#     All rights reserved.
#     This is free software with ABSOLUTELY NO WARRANTY.
#
# You can redistribute it and/or modify it under the terms of 
# the GNU General Public License version 2.
#

require 'langscan/sh'
require 'langscan/_common'

module LangScan
  module Ebuild
    module_function
    def name
      "ebuild"
    end

    def abbrev
      "ebuild"
    end

    def extnames
      [".ebuild", ".eclass"]
    end

    # LangScan::Ebuild.scan iterates over shell scripts.
    # It yields for each element which is interested by gonzui. 
    def scan(input, &block)
      # delegate to LangScan::Shell.scan
      LangScan::Shell.scan(input, &block)
    end

    LangScan.register(self)
  end
end
