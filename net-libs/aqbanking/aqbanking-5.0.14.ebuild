# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-5.0.14.ebuild,v 1.6 2012/09/11 09:53:11 armin76 Exp $

EAPI=2

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://www.aquamaniac.de/sites/download/download.php?package=03&release=85&file=01&dummy=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="+chipcard debug doc examples gtk ofx"

RDEPEND=">=app-misc/ktoblzcheck-1.33
	dev-libs/gmp
	>=sys-libs/gwenhywfar-4.2.1[gtk?]
	virtual/libintl
	ofx? ( >=dev-libs/libofx-0.9.1 )
	chipcard? ( >=sys-libs/libchipcard-5.0.2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	doc? ( app-doc/doxygen )"

MAKEOPTS="${MAKEOPTS} -j1" # 5.0.x fails with -j9 on quadcore

src_configure() {
	local backends="aqhbci aqnone aqpaypal"
	use ofx && backends="${backends} aqofxconnect"

	local myconf
	use gtk && myconf="--enable-gui-tests"

	econf \
		--disable-dependency-tracking \
		$(use_enable debug) \
		$(use_enable doc full-doc) \
		--with-backends="${backends}" \
		--with-docpath=/usr/share/doc/${PF}/apidoc \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die

	rm -rf "${D}"/usr/share/doc/{aqbanking,aqhbci,aqpaypal}

	dodoc AUTHORS ChangeLog NEWS README TODO

	newdoc src/plugins/backends/aqhbci/tools/aqhbci-tool/README \
		README.aqhbci-tool
	newdoc src/plugins/backends/aqpaypal/tools/aqpaypal-tool/README \
		README.aqpaypal-tool

	if use examples; then
		docinto tutorials
		dodoc tutorials/*.{c,h} tutorials/README
	fi

	find "${D}" -name '*.la' -exec rm -f '{}' +
}
