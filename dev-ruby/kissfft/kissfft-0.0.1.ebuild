# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/kissfft/kissfft-0.0.1.ebuild,v 1.2 2012/10/11 06:34:01 graaff Exp $

EAPI=4

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="ruby interface to kissfft"
HOMEPAGE="https://rubygems.org/gems/kissfft"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

each_ruby_configure() {
	${RUBY} -Cext/${PN} extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/${PN}
	mkdir lib || die
	cp ext/${PN}/${PN}$(get_modname) lib/ || die
}
