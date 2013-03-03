# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-touchstreams/leechcraft-touchstreams-0.5.90.ebuild,v 1.2 2013/03/02 21:56:53 hwoarang Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="VKontakte music source plugin for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	>=dev-libs/boost-1.52.0
	dev-qt/qtwebkit:4"
RDEPEND="${DEPEND}"
