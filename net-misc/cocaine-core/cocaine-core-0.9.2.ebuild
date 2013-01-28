# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cocaine-core/cocaine-core-0.9.2.ebuild,v 1.1 2013/01/28 08:00:44 patrick Exp $

EAPI=4
DESCRIPTION="Cloud platform, core parts"
HOMEPAGE="http://reverbrain.com/cocaine/"
SRC_URI="https://github.com/cocaine/${PN}/archive/${PV}.tar.gz"

inherit eutils cmake-utils

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/boost
	<net-libs/zeromq-3
	dev-libs/libev
	dev-libs/msgpack
	dev-libs/libcgroup
	"
RDEPEND="${DEPEND}"
