# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/coolkey/coolkey-1.1.0-r2.ebuild,v 1.2 2012/05/03 18:16:38 jdhore Exp $

EAPI=3

inherit eutils

DESCRIPTION="Linux Driver support for the CoolKey and CAC products"
HOMEPAGE="http://directory.fedora.redhat.com/wiki/CoolKey"
SRC_URI="http://directory.fedora.redhat.com/download/coolkey/${P}.tar.gz
	mirror://gentoo/${PN}-patches.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="sys-apps/pcsc-lite
	sys-libs/zlib"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

EPATCH_OPTS="-F3 -l"

src_prepare() {
#	EPATCH_SUFFIX="patch" epatch  "${WORKDIR}/${PN}-patches/${PV}"
	epatch "${WORKDIR}/${PN}-patches/${PV}/01_${P}-cache-move.patch"
	epatch "${WORKDIR}/${PN}-patches/${PV}/02_${P}-gcc-4.3.patch"
	epatch "${WORKDIR}/${PN}-patches/${PV}/03_${P}-latest.patch"
	epatch "${WORKDIR}/${PN}-patches/${PV}/04_${P}-simple-bugs.patch"
	epatch "${WORKDIR}/${PN}-patches/${PV}/05_${P}-thread-fix.patch"
	epatch "${WORKDIR}/${PN}-patches/${PV}/06_${P}-CAC-update.patch"
	epatch "${WORKDIR}/${PN}-patches/${PV}/07_${P}-safe-open.patch"
	epatch "${WORKDIR}/${PN}-patches/${PV}/08_${P}-configure-fix.patch"
}

src_configure() {
	econf $(use_enable debug) || die "configure failed"
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	diropts -m 1777
	keepdir /var/cache/coolkey
}
