# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/matchbox-applet-volume/matchbox-applet-volume-0.1.ebuild,v 1.11 2012/06/04 00:36:04 xmw Exp $

EAPI=1

inherit versionator

MY_PN=${PN/matchbox/mb}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Matchbox panel tray app for controlling volume levels."
HOMEPAGE="http://matchbox-project.org/"
SRC_URI="http://matchbox-project.org/sources/${MY_PN}/$(get_version_component_range 1-2)/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~arm ~hppa ppc x86"
IUSE=""

DEPEND=">=x11-libs/libmatchbox-1.5
	x11-libs/gtk+:2"

RDEPEND="${DEPEND}
	x11-wm/matchbox-panel"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die "Configuration failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
