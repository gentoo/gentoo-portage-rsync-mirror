# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-hotstreams/leechcraft-hotstreams-0.5.90.ebuild,v 1.3 2013/02/16 21:28:33 ago Exp $

EAPI="4"

inherit eutils leechcraft toolchain-funcs

DESCRIPTION="Provides some cool radio streams to music players like LMP"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="~net-misc/leechcraft-core-${PV}
	dev-libs/qjson"
RDEPEND="${DEPEND}"
