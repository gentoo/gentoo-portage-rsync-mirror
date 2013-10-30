# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-inifile/ruby-inifile-2.0.0-r2.ebuild,v 1.1 2013/10/29 23:29:58 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

inherit ruby-ng

DESCRIPTION="Small library to parse INI-files in Ruby"
HOMEPAGE="http://raa.ruby-lang.org/project/ruby-inifile/"
SRC_URI="http://gregoire.lejeune.free.fr/${PN}_${PV}.tar.gz"

SLOT="0"
IUSE=""
LICENSE="Ruby"
KEYWORDS="~x86 ~amd64"
RUBY_S=${PN}

each_ruby_test() {
	cd tests
	for test in *.rb ; do
		${RUBY} -I../lib $test || die
	done
}

each_ruby_install() {
	${RUBY} setup.rb config --prefix="${D}"/usr || die
	${RUBY} setup.rb install || die
}

all_ruby_install() {
	dodoc AUTHORS README
}
