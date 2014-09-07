# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/yaps/yaps-0.96-r5.ebuild,v 1.2 2014/09/07 13:09:53 ago Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Yet Another Pager Software (optional with CAPI support)"
HOMEPAGE="ftp://sunsite.unc.edu/pub/Linux/apps/serialcomm/machines/"
SRC_URI="capi? ( ftp://ftp.melware.net/capi4yaps/${P}.c4.tgz )
	!capi? ( ftp://sunsite.unc.edu/pub/Linux/apps/serialcomm/machines/${P}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="capi lua slang unicode"

RDEPEND="capi? ( net-dialup/capi4k-utils )
	slang? ( >=sys-libs/slang-1.4 )
	lua? ( dev-lang/lua )
	!media-sound/abcmidi"  # also contains "yaps"
DEPEND="${RDEPEND}
	!capi? ( sys-apps/sed )
	lua? ( virtual/pkgconfig )"

pkg_setup() {
	if ! use capi; then
		ewarn
		ewarn "You are now compiling some very old and unmaintained stuff!"
		ewarn
		ewarn "YAPS with CAPI 2.0 support is actively maintained, but needs"
		ewarn "net-dialup/capi4k-utils installed. We recommend this"
		ewarn "version, since it can still be used with an ordinary"
		ewarn "modem (that's what you probably wanted). So just add 'capi'"
		ewarn "to your USE flags to get the new and maintained version."
		ewarn
	fi
}

src_prepare() {
	use capi && mv -f "${S}.c4" "${S}"
	cd "${S}"

	# apply patches
	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/${P}-getline-rename.patch"

	# fix compile warning
	use capi || \
	sed -i -e 's:^\(.*\)\(<stdlib.h>\):\1\2\n\1<string.h>:g' scr.c

	# if specified, convert all relevant files from latin1 to UTF-8
	if use unicode; then
		for i in yaps.doc; do
			einfo "Converting '${i}' to UTF-8"
			iconv -f latin1 -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi
}

src_compile() {
	local myconf=""
	use lua && myconf="${myconf} LUA=True"
	use slang && myconf="${myconf} SLANG=True"
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" CFLAGS="${CFLAGS}" ${myconf} || die "emake failed"
}

src_install() {
	dobin yaps
	insinto /etc
	doins yaps.rc
	keepdir /usr/lib/yaps
	doman yaps.1
	dohtml yaps.html
	dodoc BUGREPORT COPYRIGHT README yaps.lsm yaps.doc
	newdoc contrib/README README.contrib
	insinto /usr/share/doc/${PF}/contrib
	doins contrib/{m2y.pl,tap.sl}
}

pkg_postinst() {
	elog "Please edit /etc/yaps.rc to suit your needs."
}
