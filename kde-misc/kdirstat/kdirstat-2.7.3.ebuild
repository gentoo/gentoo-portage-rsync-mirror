# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdirstat/kdirstat-2.7.3.ebuild,v 1.4 2012/09/24 14:29:14 johu Exp $

EAPI=4

KDE_LINGUAS="de fr hu it ja"
inherit kde4-base

DESCRIPTION="Nice KDE replacement to the du command"
HOMEPAGE="https://bitbucket.org/jeromerobert/k4dirstat/"
SRC_URI="${HOMEPAGE}get/k4dirstat-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND="kde-base/libkonq:4
	sys-libs/zlib"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS CREDITS TODO )

src_unpack() {
	# tarball contains git revision hash, which we don't want in the ebuild.
	default
	mv "${WORKDIR}"/*k4dirstat-* "${S}" || die
}

src_prepare() {
	sed -e "s/Utility/Utility;/" \
		-i src/k4dirstat.desktop || die "fixing .desktop file failed"

	kde4-base_src_prepare
}
