# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/magneto-gtk3/magneto-gtk3-136.ebuild,v 1.1 2012/08/24 14:49:29 lxnay Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit eutils python

DESCRIPTION="Entropy Package Manager notification applet GTK3 frontend"
HOMEPAGE="http://www.sabayon.org"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

SRC_URI="mirror://sabayon/sys-apps/entropy-${PV}.tar.bz2"
S="${WORKDIR}/entropy-${PV}/magneto"

RDEPEND="~app-misc/magneto-loader-${PV}
	dev-libs/gobject-introspection
	x11-libs/gdk-pixbuf[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/libnotify[introspection]
"
DEPEND=""

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="usr/lib" magneto-gtk3-install || die "make install failed"
}

pkg_postinst() {
	python_mod_optimize "/usr/lib/entropy/magneto/magneto/gtk3"
}

pkg_postrm() {
	python_mod_cleanup "/usr/lib/entropy/magneto/magneto/gtk3"
}
