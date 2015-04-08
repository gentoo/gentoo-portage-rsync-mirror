# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/coffee-script/coffee-script-2.2.0-r1.ebuild,v 1.6 2015/01/24 09:50:43 ago Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Ruby CoffeeScript is a bridge to the official CoffeeScript compiler"
HOMEPAGE="https://github.com/josh/ruby-coffee-script https://github.com/rails/coffee-rails"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm x86 ~x64-macos"

IUSE=""

ruby_add_rdepend "dev-ruby/coffee-script-source dev-ruby/execjs"
