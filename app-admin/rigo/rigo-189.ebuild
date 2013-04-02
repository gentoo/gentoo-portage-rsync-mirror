# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rigo/rigo-189.ebuild,v 1.1 2013/04/02 09:36:34 lxnay Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit eutils gnome2-utils fdo-mime python

DESCRIPTION="Rigo, the Sabayon Application Browser"
HOMEPAGE="http://www.sabayon.org"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

SRC_URI="mirror://sabayon/sys-apps/entropy-${PV}.tar.bz2"
S="${WORKDIR}/entropy-${PV}/rigo"

RDEPEND="
	|| ( dev-python/pygobject-cairo:3 dev-python/pygobject:3[cairo] )
	~sys-apps/entropy-${PV}
	~sys-apps/rigo-daemon-${PV}
	sys-devel/gettext
	x11-libs/gtk+:3
	x11-libs/vte:2.90
	>=x11-misc/xdg-utils-1.1.0_rc1_p20120319"
DEPEND=""

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	python_mod_optimize "/usr/lib/rigo/${PN}"
}

pkg_postrm() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	python_mod_cleanup "/usr/lib/rigo/${PN}"
}
