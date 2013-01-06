# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-launchy/leechcraft-launchy-0.5.90.ebuild,v 1.1 2012/12/25 16:46:52 maksbotan Exp $

EAPI="4"

inherit leechcraft toolchain-funcs

DESCRIPTION="Allows one to launch third-party applications (as well as LeechCraft plugins) from LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~net-misc/leechcraft-core-${PV}
	x11-libs/qt-declarative:4"
RDEPEND="${DEPEND}
	~virtual/leechcraft-trayarea-${PV}"
