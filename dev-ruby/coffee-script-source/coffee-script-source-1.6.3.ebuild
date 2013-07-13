# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/coffee-script-source/coffee-script-source-1.6.3.ebuild,v 1.1 2013/07/13 06:09:15 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Ruby CoffeeScript is a bridge to the official CoffeeScript compiler."
HOMEPAGE="https://github.com/rails/coffee-rails"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos ~x86-solaris"

IUSE=""
