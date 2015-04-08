# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fcgi/fcgi-0.9.2.1-r1.ebuild,v 1.3 2015/01/03 01:21:20 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.rdoc README.signals"

inherit multilib ruby-fakegem

DESCRIPTION="FastCGI library for Ruby"
HOMEPAGE="http://github.com/alphallc/ruby-fcgi-ng"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
LICENSE="Ruby"

DEPEND+=" dev-libs/fcgi"
RDEPEND+=" dev-libs/fcgi"

IUSE=""
SLOT="0"

each_ruby_configure() {
	${RUBY} -C ext/fcgi extconf.rb || die "extconf failed"
}

each_ruby_compile() {
	emake V=1 -C ext/fcgi
	cp ext/fcgi/fcgi$(get_modname) lib || die
}
