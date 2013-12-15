# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pcaprub/pcaprub-0.11.3-r1.ebuild,v 1.1 2013/12/15 16:25:11 zerochaos Exp $

EAPI=5

USE_RUBY="ruby19"
inherit multilib ruby-fakegem

DESCRIPTION="Libpcap bindings for ruby compat"
HOMEPAGE="https://rubygems.org/gems/pcaprub"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

each_ruby_configure() {
	${RUBY} -Cext/${PN} extconf.rb || die
}

each_ruby_compile() {
	emake -C ext/${PN}
	cp ext/${PN}/${PN}$(get_modname) lib || die
}
