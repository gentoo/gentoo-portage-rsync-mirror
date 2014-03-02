# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/ucon64/ucon64-2.0.0.ebuild,v 1.11 2014/03/02 09:39:21 pacho Exp $
EAPI=2
inherit eutils

DESCRIPTION="The backup tool and wonderful emulator's Swiss Army knife program"
HOMEPAGE="http://ucon64.sourceforge.net/"
SRC_URI="mirror://sourceforge/ucon64/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=""
DEPEND=""

S=${WORKDIR}/${P}-src/src

src_prepare() {
	epatch "${FILESDIR}"/${P}-ovflfix.patch \
		"${FILESDIR}"/${P}-zlib.patch
	sed -i \
		-e "/^CFLAGS/s/-O3/${CFLAGS}/" \
		-e "/^LDFLAGS/s/-s$/${LDFLAGS}/" \
		{,libdiscmage/}Makefile.in || die "sed failed"
}

src_configure() {
	local myconf

	if [[ ! -e /usr/include/sys/io.h ]] ; then
		ewarn "Disabling support for parallel port"
		myconf="${myconf} --disable-parallel"
	fi

	econf ${myconf} || die
}

src_install() {
	dobin ucon64 || die "dobin failed"
	dolib.so libdiscmage/discmage.so || die "dolib.so failed"
	cd ..
	dohtml -x src -r -A png,jpg *
}

pkg_postinst() {
	echo
	elog "In order to use ${PN}, please create the directory ~/.ucon64/dat"
	elog "The command to do that is:"
	elog "    mkdir -p ~/.ucon64/dat"
	elog "Then, you can copy your DAT file collection to ~/.ucon64/dat"
	elog
	elog "To enable Discmage support, cp /usr/lib/discmage.so to ~/.ucon64"
	elog "The command to do that is:"
	elog "    cp /usr/lib/discmage.so ~/.ucon64/"
	elog
	elog "Be sure to check ~/.ucon64rc for some options after"
	elog "you've run uCON64 for the first time"
}
