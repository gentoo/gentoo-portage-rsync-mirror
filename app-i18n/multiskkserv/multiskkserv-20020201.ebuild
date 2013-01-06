# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/multiskkserv/multiskkserv-20020201.ebuild,v 1.16 2011/04/13 15:17:32 ulm Exp $

EAPI="2"

inherit eutils fixheadtails

CDB_PV=0.75
CDB_PN=cdb
CDB_P=${CDB_PN}-${CDB_PV}

DESCRIPTION="SKK server that handles multiple dictionaries"
HOMEPAGE="http://www3.big.or.jp/~sian/linux/products/"
SRC_URI="http://www3.big.or.jp/~sian/linux/products/${P}.tar.bz2
	http://cr.yp.to/cdb/${CDB_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="
	|| (
		>=app-i18n/skk-jisyo-200705[cdb]
		app-i18n/skk-jisyo-cdb
	)"

src_prepare() {
	cd "${WORKDIR}/${CDB_P}" || die
	epatch "${FILESDIR}/${CDB_P}-errno.diff"
	ht_fix_all

	cd "${S}" || die
	ht_fix_all

	cd "${S}/src" || die
	epatch "${FILESDIR}/${P}-gcc34.diff"
}

src_configure() {
	cd "${WORKDIR}/${CDB_P}"
	emake || die
	cd - || die

	cd /usr/share/skk || die
	echo "# Available SKK-JISYO files are:" >> "${S}/multiskkserv.conf"
	for i in *.cdb ; do
		echo "#   ${i}" >> "${S}/multiskkserv.conf"
	done
	cd -

	econf --with-cdb="${WORKDIR}/${CDB_P}" || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	newconfd "${FILESDIR}/multiskkserv.conf" multiskkserv || die

	newinitd "${FILESDIR}/multiskkserv.initd" multiskkserv || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README* || die
}

pkg_postinst() {
	elog "By default, multiskkserv will look up only SKK-JISYO.L."
	elog "If you want to use more dictionaries,"
	elog "edit /etc/conf.d/multiskkserv manually."
}
