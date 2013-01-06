# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/magneto-loader/magneto-loader-136.ebuild,v 1.1 2012/08/24 14:46:19 lxnay Exp $

EAPI="2"
inherit eutils

DESCRIPTION="Official Sabayon Linux Entropy Notification Applet Loader"
HOMEPAGE="http://www.sabayon.org"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

SRC_URI="mirror://sabayon/sys-apps/entropy-${PV}.tar.bz2"
S="${WORKDIR}/entropy-${PV}/magneto"

DEPEND="~sys-apps/magneto-core-${PV}
	~app-admin/rigo-${PV}"
RDEPEND="${DEPEND}"

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="usr/lib" magneto-loader-install || die "make install failed"
}
