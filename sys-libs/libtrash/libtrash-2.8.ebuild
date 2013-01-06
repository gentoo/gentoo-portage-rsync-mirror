# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libtrash/libtrash-2.8.ebuild,v 1.3 2009/10/13 13:33:07 ssuominen Exp $

inherit eutils toolchain-funcs

DESCRIPTION="provides a trash can by intercepting certain calls to glibc"
HOMEPAGE="http://pages.stern.nyu.edu/~marriaga/software/libtrash/"
SRC_URI="http://pages.stern.nyu.edu/~marriaga/software/libtrash/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.4-gentoo.patch
	sed -i \
		-e "/^INSTLIBDIR/s/lib/$(get_libdir)/" \
		-e "/^CFLAGS/s/$/ ${CFLAGS}/" \
		"${S}"/src/Makefile || die

	# now let's unpack strash too in cash anyone is interested
	cd cleanTrash
	tar -zxf ./strash-0.9.tar.gz
}

src_compile() {
	make CC="$(tc-getCC)" || die "Error Making Source...Exiting"
}

src_install() {
	dodir /etc /usr/$(get_libdir)
	make DESTDIR="${D}" install || die "Error Installing ${P}...Exiting"

	dosbin cleanTrash/ct2.pl
	exeinto /etc/cron.daily
	doexe "${FILESDIR}"/cleanTrash.cron

	dodoc CHANGE.LOG README libtrash.conf TODO config.txt

	docinto cleanTrash
	dodoc cleanTrash/README cleanTrash/cleanTrash

	# new strash installation stuff
	dosbin cleanTrash/strash-0.9/strash
	docinto strash
	dodoc cleanTrash/strash-0.9/README
	doman cleanTrash/strash-0.9/strash.8
}

pkg_postinst() {
	einfo
	einfo "To use this you have to put the trash library as one"
	einfo "of the variables in LD_PRELOAD."
	einfo "Example in bash:"
	einfo "export LD_PRELOAD=/usr/$(get_libdir)/libtrash.so"
	einfo
	einfo "Also, see /etc/cron.daily/cleanTrash.cron if you'd like to turn on"
	einfo "daily trash cleanup."
	einfo
}
