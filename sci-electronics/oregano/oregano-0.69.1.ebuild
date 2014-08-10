# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/oregano/oregano-0.69.1.ebuild,v 1.9 2014/08/10 20:28:33 slyfox Exp $

EAPI="4"

inherit eutils fdo-mime scons-utils

DESCRIPTION="Oregano is an application for schematic capture and simulation of electrical circuits"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${P/-/_}.orig.tar.gz"
HOMEPAGE="http://oregano.gforge.lug.fi.uba.ar/" # broken
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
LICENSE="GPL-2"
IUSE=""

CDEPEND="
	dev-libs/libxml2:2
	x11-libs/gtk+:2
	gnome-base/libglade:2.0
	gnome-base/libgnome
	>=gnome-base/libgnomeui-2.12
	>=gnome-base/libgnomecanvas-2.12
	>=x11-libs/cairo-1.2
	x11-libs/gtksourceview:2.0"
DEPEND="${CDEPEND}
	>=dev-util/scons-0.96.1
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	sci-electronics/electronics-menu"

src_prepare() {
	# patches from debian
	epatch "${FILESDIR}/${P}-desktop_file_update.patch"
	epatch "${FILESDIR}/${P}-scons_env_flags.patch"
}

src_compile() {
	escons --cache-disable PREFIX=/usr
}

src_install() {
	escons --cache-disable PREFIX=/usr DESTDIR="${D}" RunUpdateMimeDatabase=no \
		install
	dodoc AUTHORS NEWS README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	elog "You'll need to emerge your prefered simulation backend"
	elog "such as spice, ngspice or gnucap for simulation"
	elog "to work."
}
