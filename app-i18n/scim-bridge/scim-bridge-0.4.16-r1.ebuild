# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-bridge/scim-bridge-0.4.16-r1.ebuild,v 1.6 2012/05/03 19:24:26 jdhore Exp $

EAPI="2"

inherit autotools eutils multilib

DESCRIPTION="Yet another IM-client of SCIM"
HOMEPAGE="http://www.scim-im.org/projects/scim_bridge"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc64 ~x86"
IUSE="doc gtk qt4"

RESTRICT="test"

RDEPEND=">=app-i18n/scim-1.4.6
	gtk? (
		>=x11-libs/gtk+-2.2:2
		>=x11-libs/pango-1.1
	)
	qt4? (
		x11-libs/qt-gui:4
		x11-libs/qt-core:4
		>=x11-libs/pango-1.1
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool
	doc? ( app-doc/doxygen )"

update_gtk_immodules() {
	local GTK2_CONFDIR
	has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}
	if [ -x /usr/bin/gtk-query-immodules-2.0 ] ; then
		/usr/bin/gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.4.15.2-qt4.patch"
	epatch "${FILESDIR}/${PN}-0.4.15.2-gcc43.patch"
	epatch "${FILESDIR}/${P}+gcc-4.4.patch"

	# bug #241954
	intltoolize --force
	eautoreconf
}

src_configure() {
	local myconf="$(use_enable doc documents)"
	# '--disable-*-immodule' are b0rked, bug #280887

	if use gtk ; then
		myconf="${myconf} --enable-gtk2-immodule=yes"
	else
		myconf="${myconf} --enable-gtk2-immodule=no"
	fi

	# Qt3 is no longer supported, bug 283429
	myconf="${myconf} --enable-qt3-immodule=no"

	if use qt4 ; then
		myconf="${myconf} --enable-qt4-immodule=yes"
	else
		myconf="${myconf} --enable-qt4-immodule=no"
	fi

	econf ${myconf} || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README || die
}

pkg_postinst() {
	elog
	elog "If you would like to use ${PN} as default instead of scim, set"
	elog " $ export GTK_IM_MODULE=scim-bridge"
	elog " $ export QT_IM_MODULE=scim-bridge"
	elog
	use gtk && update_gtk_immodules
}

pkg_postrm() {
	use gtk && update_gtk_immodules
}
