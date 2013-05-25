# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aacgain/aacgain-1.8.ebuild,v 1.4 2013/05/25 00:17:46 sbriesen Exp $

EAPI=2
inherit eutils

DESCRIPTION="AACGain normalizes the volume of digital music files using the Replay Gain algorithm."
HOMEPAGE="http://aacgain.altosdesign.com/"
SRC_URI="http://altosdesign.com/aacgain/alvarez/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-apps/sed"

src_prepare() {
	if has_version ">=sys-libs/glibc-2.10"; then
		epatch "${FILESDIR}"/${P}+glibc-2.10.patch
	fi

	# rename internal lrintf function of faad2 (conflicts with glibc)
	sed -i -e "s:lrintf:_lrintf:g" faad2/libfaad/{common.h,lt_predict.c,output.c}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc aacgain/README README.first
}

pkg_postinst() {
	ewarn
	ewarn "BACK UP YOUR MUSIC FILES BEFORE USING AACGAIN!"
	ewarn "THIS IS EXPERIMENTAL SOFTWARE. THERE HAVE BEEN"
	ewarn "BUGS IN PAST RELEASES THAT CORRUPTED MUSIC FILES."
	ewarn
}
