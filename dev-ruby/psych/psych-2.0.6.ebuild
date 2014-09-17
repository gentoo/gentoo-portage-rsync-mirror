# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/psych/psych-2.0.6.ebuild,v 1.1 2014/09/17 05:24:46 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc README.rdoc"

inherit multilib ruby-fakegem

DESCRIPTION="A libyaml wrapper for Ruby"
HOMEPAGE="https://github.com/tenderlove/psych"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND+=" dev-libs/libyaml"

ruby_add_bdepend "test? ( dev-ruby/minitest )"

each_ruby_configure() {
	${RUBY} -Cext/${PN} extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/${PN}
	cp ext/${PN}/${PN}$(get_modname) lib/ || die
}

each_ruby_test() {
	${RUBY} -Ilib:test:test/${PN} test/${PN}/test_*.rb || die
	${RUBY} -Ilib:test:test/${PN} test/${PN}/nodes/*.rb || die
	${RUBY} -Ilib:test:test/${PN} test/${PN}/visitors/*.rb || die
	${RUBY} -Ilib:test:test/${PN} test/${PN}/json/*.rb || die
}
