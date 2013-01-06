# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbacpi/bbacpi-0.1.5-r2.ebuild,v 1.1 2012/11/25 10:15:03 xarthisius Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="ACPI monitor for X11"
HOMEPAGE="http://bbacpi.sourceforge.net"
SRC_URI="mirror://sourceforge/bbacpi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libX11
	media-libs/imlib
	x11-misc/xdialog
	sys-power/acpi
	sys-power/acpid"
RDEPEND="${DEPEND}
	media-fonts/font-adobe-100dpi"

DOCS=( AUTHORS ChangeLog README )

src_prepare() {
	epatch "${FILESDIR}"/${P}-noextraquals.diff \
		"${FILESDIR}"/${P}-overflows.diff
	eautoreconf
}
