# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/magneto-kde/magneto-kde-144.ebuild,v 1.1 2012/09/27 11:04:36 lxnay Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit eutils python

DESCRIPTION="Entropy Package Manager notification applet KDE frontend"
HOMEPAGE="http://www.sabayon.org"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

SRC_URI="mirror://sabayon/sys-apps/entropy-${PV}.tar.bz2"
S="${WORKDIR}/entropy-${PV}/magneto"

RDEPEND="~app-misc/magneto-loader-${PV}
	kde-base/pykde4
	dev-python/PyQt4[dbus]"
DEPEND=""

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="usr/lib" magneto-kde-install || die "make install failed"
}

pkg_postinst() {
	python_mod_optimize "/usr/lib/entropy/magneto/magneto/kde"
}

pkg_postrm() {
	python_mod_cleanup "/usr/lib/entropy/magneto/magneto/kde"
}
