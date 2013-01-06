# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/povscript+/povscript+-2.1.2.2.18.ebuild,v 1.2 2011/03/02 17:51:59 jlec Exp $

EAPI="1"

inherit versionator

V1=$(get_version_component_range 1 ${PV})
V2=$(get_version_component_range 2 ${PV})
V3=$(get_version_component_range 3 ${PV})
V4=$(get_version_component_range 4 ${PV})
V5=$(get_version_component_range 5 ${PV})

MY_P="molscript-${V1}.${V2}.${V3}pov${V4}.${V5}"
DESCRIPTION="Modified molscript that uses POV-Ray, does thermal ellipsoids, and more"
HOMEPAGE="http://www.stanford.edu/~fenn/povscript/"
SRC_URI="http://www.stanford.edu/~fenn/packs/${MY_P}.tar.gz"
LICENSE="glut molscript"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="
	dev-libs/glib:2
	sci-libs/gts"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	cd "${D}"/usr/bin
	mv molscript povscript+
	mv molauto povauto+
}

pkg_postinst() {
	elog "You must install media-gfx/povray to use the POV backend,"
	elog "which is one of the main features of this over molscript."
}
