# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/network_interface/network_interface-0.0.1.ebuild,v 1.1 2013/08/19 22:41:53 zerochaos Exp $

EAPI=5

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""

# Tests depend on unpackaged factory_girl
RUBY_FAKEGEM_RECIPE_TEST=""

#RUBY_FAKEGEM_EXTRAINSTALL="app db script spec"

inherit ruby-fakegem

DESCRIPTION="network_interface layer from metasploit pcaprub"
HOMEPAGE="https://github.com/rapid7/network_interface"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
