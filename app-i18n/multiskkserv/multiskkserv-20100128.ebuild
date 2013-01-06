# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/multiskkserv/multiskkserv-20100128.ebuild,v 1.5 2012/10/09 12:47:55 blueness Exp $

EAPI="3"

inherit eutils fixheadtails autotools

DESCRIPTION="SKK server that handles multiple dictionaries"
HOMEPAGE="http://www3.big.or.jp/~sian/linux/products/"
SRC_URI="http://www3.big.or.jp/~sian/linux/products/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="test"

DEPEND="app-arch/xz-utils
	dev-db/cdb
	test? ( app-i18n/nkf )"
RDEPEND="|| (
		>=app-i18n/skk-jisyo-200705[cdb]
		app-i18n/skk-jisyo-cdb
	)"

src_prepare() {
	ht_fix_all
	epatch "${FILESDIR}"/${P}-cdb.patch
	eautoreconf
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
