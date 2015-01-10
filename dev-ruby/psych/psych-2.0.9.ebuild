# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/psych/psych-2.0.9.ebuild,v 1.1 2015/01/10 22:01:21 mrueg Exp $

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

DEPEND+=" >=dev-libs/libyaml-0.1.6"

ruby_add_bdepend "test? ( >=dev-ruby/minitest-4.0:0 )"

all_ruby_prepare() {
	sed -i -e '1igem "minitest", "~>4.0"' test/psych/helper.rb || die
}

each_ruby_configure() {
	${RUBY} -Cext/${PN} extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/${PN}
	cp ext/${PN}/${PN}$(get_modname) lib/ || die
}

each_ruby_test() {
	${RUBY} -Ilib:test:test/${PN} -S testrb test/${PN}/test_*.rb test/${PN}/{nodes,visitors,json}/test_*.rb || die
}
