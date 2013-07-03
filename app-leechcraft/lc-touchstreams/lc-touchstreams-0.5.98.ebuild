# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-touchstreams/lc-touchstreams-0.5.98.ebuild,v 1.1 2013/07/03 16:19:40 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="VKontakte music source plugin for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
	>=dev-libs/boost-1.52.0
	dev-qt/qtwebkit:4"
RDEPEND="${DEPEND}"
