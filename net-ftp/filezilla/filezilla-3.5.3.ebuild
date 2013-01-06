# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/filezilla/filezilla-3.5.3.ebuild,v 1.7 2012/07/29 16:10:44 armin76 Exp $

EAPI=2

WX_GTK_VER="2.8"

inherit autotools eutils flag-o-matic multilib wxwidgets

MY_PV=${PV/_/-}
MY_P="FileZilla_${MY_PV}"

DESCRIPTION="FTP client with lots of useful features and an intuitive interface"
HOMEPAGE="http://filezilla-project.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}_src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc sparc x86"
IUSE="dbus nls test"

RDEPEND=">=app-admin/eselect-wxwidgets-0.7-r1
	>=dev-db/sqlite-3.7
	>=dev-libs/tinyxml-2.6.1-r1[stl]
	net-dns/libidn
	>=net-libs/gnutls-2.8.3
	>=x11-libs/wxGTK-2.8.12:2.8[X]
	x11-misc/xdg-utils
	dbus? ( sys-apps/dbus )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/libtool-1.4
	nls? ( >=sys-devel/gettext-0.11 )
	test? ( dev-util/cppunit )"

S="${WORKDIR}"/${PN}-${MY_PV}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.3.5.1-debug.patch
	append-flags -DTIXML_USE_STL
	eautoreconf
}

src_configure() {
	econf $(use_with dbus) $(use_enable nls locales) \
		--with-tinyxml=system \
		--disable-autoupdatecheck || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doicon src/interface/resources/48x48/${PN}.png || die "doicon failed"

	dodoc AUTHORS ChangeLog NEWS
}
