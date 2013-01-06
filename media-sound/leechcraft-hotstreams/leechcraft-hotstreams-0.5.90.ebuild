# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-hotstreams/leechcraft-hotstreams-0.5.90.ebuild,v 1.1 2012/12/25 16:38:16 maksbotan Exp $

EAPI="4"

inherit eutils leechcraft toolchain-funcs

DESCRIPTION="Provides some cool radio streams to music players like LMP"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~net-misc/leechcraft-core-${PV}
	dev-libs/qjson"
RDEPEND="${DEPEND}"
