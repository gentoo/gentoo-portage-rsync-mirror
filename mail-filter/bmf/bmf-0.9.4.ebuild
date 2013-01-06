# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bmf/bmf-0.9.4.ebuild,v 1.11 2010/07/08 16:25:41 hwoarang Exp $

inherit toolchain-funcs

IUSE="mysql berkdb"

DESCRIPTION="A fast and small Bayesian spam filter"
HOMEPAGE="http://bmf.sourceforge.net/"
SRC_URI="mirror://sourceforge/bmf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ppc"

DEPEND="mysql? ( virtual/mysql )
	berkdb? ( >=sys-libs/db-3.2.9 )"

src_compile() {
	local myconf

	use mysql || myconf="--without-mysql"
	use berkdb || myconf="${myconf} --without-libdb"

	./configure ${myconf} || die "configure failed"
	emake CC="$(tc-getCC)"
}

src_install() {
	dodoc README AUTHORS ChangeLog
	einstall DESTDIR="${D}"
}

pkg_postinst() {
	elog
	elog "Important: Remember to train bmf before you start using it."
	elog "See the README file for further instructions on training and using bmf"
	elog "with procmail."
	elog
}
