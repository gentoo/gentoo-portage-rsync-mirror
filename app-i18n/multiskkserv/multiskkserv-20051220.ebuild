# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/multiskkserv/multiskkserv-20051220.ebuild,v 1.5 2011/04/13 15:17:32 ulm Exp $

EAPI="2"

inherit eutils fixheadtails

DESCRIPTION="SKK server that handles multiple dictionaries"
HOMEPAGE="http://www3.big.or.jp/~sian/linux/products/"
SRC_URI="http://www3.big.or.jp/~sian/linux/products/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-db/cdb"
RDEPEND="|| (
		>=app-i18n/skk-jisyo-200705[cdb]
		app-i18n/skk-jisyo-cdb
	)"

src_prepare() {
	ht_fix_all
}

src_configure() {
	econf --with-cdb=yes || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	newconfd "${FILESDIR}"/multiskkserv.conf multiskkserv || die
	newinitd "${FILESDIR}"/multiskkserv.initd multiskkserv || die

	dodoc AUTHORS ChangeLog NEWS README* || die
}

pkg_postinst() {
	elog "By default, multiskkserv will look up only SKK-JISYO.L.cdb."
	elog "If you want to use more dictionaries,"
	elog "edit /etc/conf.d/multiskkserv manually."
}
