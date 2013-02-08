# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/prism54-firmware/prism54-firmware-1.0.4.3.ebuild,v 1.14 2013/02/08 17:54:36 ssuominen Exp $

DESCRIPTION="firmware for Intersil Prism GT / Prism Duette wireless chipsets"
HOMEPAGE="http://daemonizer.de/prism54/prism54-fw/"
SRC_URI="http://daemonizer.de/prism54/prism54-fw/fw-fullmac/${PV}.arm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
RESTRICT="mirror"

src_unpack() { :; }

src_install() {
	insinto /lib/firmware/
	newins "${DISTDIR}"/${PV}.arm isl3890 || die
}
