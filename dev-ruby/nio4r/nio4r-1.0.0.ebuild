# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nio4r/nio4r-1.0.0.ebuild,v 1.2 2014/05/07 05:19:41 patrick Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

inherit ruby-fakegem

DESCRIPTION="A high performance selector API for monitoring IO objects"
HOMEPAGE="https://github.com/celluloid/nio4r"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND+=" dev-libs/libev"

ruby_add_bdepend "test? ( dev-ruby/rake-compiler )"

RUBY_PATCHES=( "${FILESDIR}"/${P}-extconf.patch )

all_ruby_prepare() {
	rm -rf ext/libev
	sed -i -e 's#"../libev/ev.h"#<ev.h>#' ext/${PN}/libev.h || die
	sed -i -e '/ev.c/d' ext/${PN}/nio4r_ext.c || die
	sed -i -e '/[Cc]overalls/d' -e '/[Bb]undler/d' spec/spec_helper.rb || die
}

each_ruby_configure() {
	${RUBY} -Cext/${PN} extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/${PN}
	cp ext/${PN}/*$(get_modname) lib/ || die
}
