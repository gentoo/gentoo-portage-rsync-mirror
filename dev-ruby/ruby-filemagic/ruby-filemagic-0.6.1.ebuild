# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-filemagic/ruby-filemagic-0.6.1.ebuild,v 1.1 2014/08/23 05:57:35 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="ChangeLog README TODO info/filemagic.rd info/example.rb"

RUBY_FAKEGEM_TASK_TEST=""

inherit multilib ruby-fakegem

DESCRIPTION="Ruby binding to libmagic"
HOMEPAGE="http://ruby-filemagic.rubyforge.org/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

# Don't run tests since the descriptions in recent versions of
# sys-apps/file are diverging too much from what the test cases expect.
# https://bugs.gentoo.org/show_bug.cgi?id=366205
RESTRICT="test"

DEPEND="${DEPEND} sys-apps/file"
RDEPEND="${RDEPEND} sys-apps/file"

each_ruby_configure() {
	${RUBY} -Cext/filemagic extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/filemagic || die
	mv ext/filemagic/ruby_filemagic$(get_modname) lib/filemagic/ || die
}

each_ruby_test() {
	${RUBY} -Ctest -I../lib filemagic_test.rb || die
}
