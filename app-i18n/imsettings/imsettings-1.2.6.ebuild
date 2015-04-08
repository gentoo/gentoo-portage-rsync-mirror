# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/imsettings/imsettings-1.2.6.ebuild,v 1.5 2013/03/02 19:27:25 hwoarang Exp $

EAPI=3

inherit eutils

DESCRIPTION="Delivery framework for general Input Method configuration"
HOMEPAGE="http://tagoh.github.com/imsettings/"
SRC_URI="http://imsettings.googlecode.com/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc qt4 static-libs xfconf"

# X11 connections are required for test.
RESTRICT="test"

RDEPEND=">=dev-libs/check-0.9.4
	>=dev-libs/glib-2.26
	sys-apps/dbus
	>=x11-libs/gtk+-2.12:2
	>=x11-libs/libgxim-0.3.1
	>=x11-libs/libnotify-0.7
	x11-libs/libX11
	qt4? ( dev-qt/qtcore:4 )
	xfconf? ( xfce-base/xfconf )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )"

MY_XINPUTSH="90-xinput"

src_prepare() {
	# Prevent automagic linking to libxfconf-0.
	if ! use xfconf; then
		sed -i -e 's:libxfconf-0:dIsAbLe&:' configure || die
	fi
	if ! use qt4; then
		sed -i -e 's:QtCore:dIsAbLe&:' configure || die
	fi
	epatch "${FILESDIR}"/${PN}-1.2.8.1-glib32.patch
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--with-xinputsh="${MY_XINPUTSH}"
}

src_install() {
	emake DESTDIR="${D}" install || die

	find "${ED}" -name '*.la' -exec rm -f '{}' +

	fperms 0755 /usr/libexec/xinputinfo.sh || die
	fperms 0755 "/etc/X11/xinit/xinitrc.d/${MY_XINPUTSH}" || die

	dodoc AUTHORS ChangeLog NEWS README || die
}

pkg_postinst() {
	if [ ! -e "${EPREFIX}/etc/X11/xinit/xinputrc" ] ; then
		ln -sf xinput.d/xcompose.conf "${EPREFIX}/etc/X11/xinit/xinputrc"
	fi
}
