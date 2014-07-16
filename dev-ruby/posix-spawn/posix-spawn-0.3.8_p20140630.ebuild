# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/posix-spawn/posix-spawn-0.3.8_p20140630.ebuild,v 1.2 2014/07/16 05:24:53 graaff Exp $

EAPI=5

# jruby → should be supported but does not work with "rake compile"
USE_RUBY="ruby19 ruby20"
KEYWORDS="~amd64"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md TODO HACKING"
RUBY_FAKEGEM_VERSION="0.3.8.20140630"

inherit ruby-fakegem

DESCRIPTION="The posix-spawn library aims to implement a subset of the Ruby 1.9 Process::spawn"
HOMEPAGE="https://github.com/rtomayko/posix-spawn/"
COMMIT_ID="25a0806ce0335faf958834d9dd6a41ff2288fa56"
SRC_URI="https://github.com/rtomayko/posix-spawn/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT LGPL-2.1"
SLOT="0"
IUSE="test"

RUBY_S="${PN}-${COMMIT_ID}"

each_ruby_configure() {
	${RUBY} -Cext extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext
	cp ext/*$(get_modname) lib/ || die
}

each_ruby_test() {
	${RUBY} -Ilib -S testrb test || die
}
