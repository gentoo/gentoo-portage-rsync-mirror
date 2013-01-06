# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-touchstreams/leechcraft-touchstreams-0.5.90.ebuild,v 1.1 2012/12/25 16:39:45 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="VKontakte music source plugin for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	>=dev-libs/boost-1.52.0
	x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}"
