# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/matchbox-desktop-image-browser/matchbox-desktop-image-browser-0.2.ebuild,v 1.8 2012/06/04 00:47:26 xmw Exp $

inherit versionator eutils autotools

MY_PN=${PN/matchbox/mb}
MY_P=${MY_PN}-${PV}

DESCRIPTION="An alpha-ish image browser plug in for matchbox-desktop."
HOMEPAGE="http://matchbox-project.org/"
SRC_URI="http://matchbox-project.org/sources/${MY_PN}/$(get_version_component_range 1-2)/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="debug"

RDEPEND=">=x11-libs/libmatchbox-1.1"
DEPEND="${RDEPEND} x11-wm/matchbox-desktop"

S="${WORKDIR}/${MY_P}"

src_unpack () {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/$P-include_fix.patch
	epatch "${FILESDIR}"/$P-noexec-matchbox-desktop.patch

	eautoreconf
}

src_compile () {
	econf $(use_enable debug) || die "Configuration failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
