# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libtrash/libtrash-3.2.ebuild,v 1.1 2008/12/30 01:33:22 matsuu Exp $

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
	epatch "${FILESDIR}/${P}-gentoo.patch"
	sed -i -e "/^INSTLIBDIR/s:local/lib:$(get_libdir):" src/Makefile || die

	# now let's unpack strash too in cash anyone is interested
	cd cleanTrash
	unpack ./strash-0.9.tar.gz
}

src_compile() {
	emake CC="$(tc-getCC)" || die "Error Making Source...Exiting"
}

src_install() {
	dodir /etc /usr/$(get_libdir)
	emake DESTDIR="${D}" install || die "Error Installing ${P}...Exiting"

	dosbin cleanTrash/ct2.pl
	exeinto /etc/cron.daily
	doexe "${FILESDIR}/cleanTrash.cron"

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
	elog
	elog "To use this you have to put the trash library as one"
	elog "of the variables in LD_PRELOAD."
	elog "Example in bash:"
	elog "export LD_PRELOAD=/usr/$(get_libdir)/libtrash.so"
	elog
	elog "Also, see /etc/cron.daily/cleanTrash.cron if you'd like to turn on"
	elog "daily trash cleanup."
	elog
}
