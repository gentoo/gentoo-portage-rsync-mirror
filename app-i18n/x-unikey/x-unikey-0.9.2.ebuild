# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/x-unikey/x-unikey-0.9.2.ebuild,v 1.11 2012/10/09 13:31:13 naota Exp $

EAPI="1"

inherit eutils gnome2-utils

DESCRIPTION="Vietnamese X Input Method"
HOMEPAGE="http://unikey.sourceforge.net/linux.php"
SRC_URI="mirror://sourceforge/unikey/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls gtk"

DEPEND="x11-libs/libX11
	x11-libs/libSM
	x11-libs/libICE
	nls? ( sys-devel/gettext )
	gtk? ( >=x11-libs/gtk+-2.2:2 )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf
	# --with-gtk-sysconfdir to prevent sandbox violation only
	use gtk && myconf="--with-unikey-gtk --with-gtk-sysconfdir=${D}/etc/gtk-2.0"
	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	if use gtk;then
		dodir etc/gtk-2.0
		emake DESTDIR="${D}" install -C src/unikey-gtk
	fi
	dobin src/xim/ukxim src/gui/unikey
	doenvd "${FILESDIR}"/01x-unikey
	dodoc doc/manual doc/ukmacro doc/unikeyrc
}

pkg_postinst() {
	elog ""
	elog "Go to /etc/env.d/01x-unikey and uncomment appropriate lines"
	elog "to enable x-unikey"
	elog ""
	if use gtk; then
		gnome2_query_immodules_gtk2
		elog "If you want to use x-unikey as the default gtk+ input method,"
		elog "change GTK_IM_MODULE in /etc/env.d/01x-unikey to \"unikey\""
		elog ""
	fi
}

pkg_postrm() {
	use gkt && gnome2_query_immodules_gtk2
}
