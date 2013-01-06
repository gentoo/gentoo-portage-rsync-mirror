# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fe3d/fe3d-0.11.2.ebuild,v 1.6 2010/11/01 15:35:20 fauli Exp $

EAPI=2
WX_GTK_VER="2.8"
inherit autotools eutils wxwidgets

if [[ "${PV}" =~ (_p)([0-9]+) ]] ; then
	inherit subversion
	SRC_URI=""
	FE3D_REV=${BASH_REMATCH[2]}
	ESVN_REPO_URI="http://svn.icapsid.net/fe3d/fe3d/branches/fe3d_0.11/@${FE3D_REV}"
else
	SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}-src.tar.bz2"
fi

DESCRIPTION="A 3D visualization tool for network security information"
HOMEPAGE="http://projects.icapsid.net/fe3d/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 x86"
IUSE=""

RDEPEND="x11-libs/wxGTK:2.8
	>=dev-libs/xerces-c-2.7
	net-analyzer/nmap"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}_${PV}

pkg_setup() {
	check_wxuse opengl
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch \
		"${FILESDIR}"/${P}-coreutils.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS doc/{ChangeLog,README}.txt
}

pkg_postinst() {
	ewarn "This package has known issues:"
	ewarn "1. The radius of the geometry nodes is wrong, causing overlap"
	ewarn "2. Earth (and other) textures are upside down"
	ewarn "3. This package contains some minor memory leaks"
	echo
	elog "Example using a nmap log:"
	elog "/usr/bin/nmap -oX test.xml -O --osscan_limit 192.168.0.0/24"
	elog "/usr/bin/fe3d test.xml"
}
