# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/network_interface/network_interface-0.0.1-r1.ebuild,v 1.1 2013/08/20 15:36:28 zerochaos Exp $

EAPI=5

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_RECIPE_TEST="default"

inherit ruby-fakegem

DESCRIPTION="network_interface layer from metasploit pcaprub"
HOMEPAGE="https://github.com/rapid7/network_interface"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

each_ruby_configure() {
	${RUBY} -C ext/network_interface_ext extconf.rb || die
}

each_ruby_compile() {
	emake -C ext/network_interface_ext
	cp ext/network_interface_ext/network_interface_ext.so lib/ || die
}
