# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/swiftiply/swiftiply-0.6.1.1.ebuild,v 1.1 2013/03/31 15:21:44 tomwij Exp $

EAPI="5"

USE_RUBY="ruby18 ruby19"
inherit ruby-ng ruby-fakegem

MY_COMPANY="swiftcore"
DESCRIPTION="A clustering proxy server for web applications."
HOMEPAGE="http://${PN}.${MY_COMPANY}.org/"
SRC_URI="http://${PN}.${MY_COMPANY}.org/files/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-ruby/eventmachine-0.9.0"

RUBY_FAKEGEM_EXTRAINSTALL="src"
