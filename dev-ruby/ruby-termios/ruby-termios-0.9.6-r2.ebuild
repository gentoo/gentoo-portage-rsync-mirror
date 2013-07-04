# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-termios/ruby-termios-0.9.6-r2.ebuild,v 1.3 2013/07/04 09:13:48 ago Exp $

EAPI=4
USE_RUBY="ruby18 ruby19"

inherit ruby-ng

DESCRIPTION="A Ruby interface to termios"
HOMEPAGE="http://arika.org/ruby/termios"	# trailing / isn't needed
SRC_URI="http://github.com/arika/ruby-termios/tarball/version_0_9_6 -> ${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ~ppc x86 ~x86-macos"
IUSE=""

RUBY_S="arika-${PN}-94fd9ac"

# Tests require a normal TTY, bug 340575. They should all pass when run
# manually.
RESTRICT=test

each_ruby_configure() {
	${RUBY} extconf.rb || die
}

each_ruby_compile() {
	emake || die
}

each_ruby_test() {
	${RUBY} test/test0.rb || die "tests failed"
}

each_ruby_install() {
	emake DESTDIR="${D}" install || die
}

all_ruby_install() {
	dodoc ChangeLog README termios.rd

	insinto /usr/share/doc/${PF}/examples
	doins examples/* || die
}
