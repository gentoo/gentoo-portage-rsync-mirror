# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-hotstreams/leechcraft-hotstreams-0.5.85.ebuild,v 1.3 2012/12/21 13:34:24 pinkbyte Exp $

EAPI="4"

inherit eutils leechcraft toolchain-funcs

DESCRIPTION="Provides some cool radio streams to music players like LMP"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~net-misc/leechcraft-core-${PV}
	dev-libs/qjson"
RDEPEND="${DEPEND}"
