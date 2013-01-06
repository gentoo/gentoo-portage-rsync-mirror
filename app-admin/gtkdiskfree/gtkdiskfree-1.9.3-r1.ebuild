# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gtkdiskfree/gtkdiskfree-1.9.3-r1.ebuild,v 1.16 2012/05/03 18:02:22 jdhore Exp $

EAPI=4
inherit eutils

DESCRIPTION="Graphical tool to show free disk space"
HOMEPAGE="http://gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE="nls"

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-tempfile.patch \
		"${FILESDIR}"/${PV}-makefile-DESTDIR.patch \
		"${FILESDIR}"/${P}-make-382.patch

	echo 'Categories=GTK;System;Filesystem;' >> gtkdiskfree.desktop
}

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	default
	doicon gtkdiskfree.png
	domenu gtkdiskfree.desktop
}
