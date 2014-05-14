# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rinku/rinku-1.7.3.ebuild,v 1.2 2014/05/14 09:09:31 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.markdown"

inherit multilib ruby-fakegem

DESCRIPTION="A Ruby library that does autolinking"
HOMEPAGE="https://github.com/vmg/rinku"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

each_ruby_configure() {
	${RUBY} -Cext/${PN} extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/${PN}
	cp ext/${PN}/${PN}$(get_modname) lib/ || die
}

each_ruby_test() {
	${RUBY} -Ilib test/autolink_test.rb || die
}
