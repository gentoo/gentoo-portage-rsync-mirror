# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-filemagic/ruby-filemagic-0.6.3.ebuild,v 1.1 2015/02/14 02:42:35 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="ChangeLog README TODO"

RUBY_FAKEGEM_TASK_TEST=""

inherit multilib ruby-fakegem

DESCRIPTION="Ruby binding to libmagic"
HOMEPAGE="http://ruby-filemagic.rubyforge.org/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="${DEPEND} sys-apps/file"
RDEPEND="${RDEPEND} sys-apps/file"

each_ruby_configure() {
	${RUBY} -Cext/filemagic extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/filemagic
	mv ext/filemagic/ruby_filemagic$(get_modname) lib/filemagic/ || die
}

each_ruby_test() {
	${RUBY} -Ctest -I../lib filemagic_test.rb || die
}
