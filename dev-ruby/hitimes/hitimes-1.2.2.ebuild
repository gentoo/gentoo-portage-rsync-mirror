# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hitimes/hitimes-1.2.2.ebuild,v 1.2 2014/08/12 22:44:13 blueness Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.md HISTORY.md"

inherit multilib ruby-fakegem

DESCRIPTION="A fast, high resolution timer library"
HOMEPAGE="https://github.com/copiousfreetime/hitimes"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64"
IUSE=""

all_ruby_prepare() {
	sed -i -e "/RUBY_VERSION >= '1.9.2'/,+4d"  spec/spec_helper.rb || die
}

each_ruby_configure() {
	${RUBY} -Cext/hitimes/c extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/hitimes/c V=1
	cp ext/hitimes/c/hitimes$(get_modname) lib/hitimes || die
}

each_ruby_test() {
	${RUBY} -S testrb -Ilib:spec spec/*_spec.rb || die
}
