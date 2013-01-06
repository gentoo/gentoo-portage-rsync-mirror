# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/libnss-mysql/libnss-mysql-1.5_p20060915-r1.ebuild,v 1.4 2011/05/28 12:05:24 ranger Exp $

EAPI=2

inherit eutils multilib autotools

KEYWORDS="amd64 ppc ~sparc x86"

DESCRIPTION="NSS MySQL Library."
HOMEPAGE="http://libnss-mysql.sourceforge.net/"
SRC_URI="http://libnss-mysql.sourceforge.net/snapshot/${PN}-${PV/1.5_p/}.tgz"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND="virtual/mysql"
S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-automagic-debug.diff
	eautoconf
}

src_configure() {
	# authentication libraries don't belong into usr,
	# please don't change this
	econf --libdir="/$(get_libdir)" \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die

	find "${D}" -name '*.la' -delete

	newdoc sample/README README.sample
	dodoc AUTHORS DEBUGGING FAQ INSTALL NEWS README THANKS \
		TODO UPGRADING ChangeLog

	for subdir in sample/{linux,freebsd,complex,minimal} ; do
		docinto "${subdir}"
		dodoc "${subdir}/"{*.sql,*.cfg}
	done
}
