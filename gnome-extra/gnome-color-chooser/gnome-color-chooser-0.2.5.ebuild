# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-color-chooser/gnome-color-chooser-0.2.5.ebuild,v 1.2 2012/05/05 06:25:19 jdhore Exp $

EAPI=1

inherit gnome2 flag-o-matic

DESCRIPTION="GTK+/GNOME color customization tool."
HOMEPAGE="http://gnomecc.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnomecc/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug"

RDEPEND=">=dev-cpp/libglademm-2.6.0:2.4
	>=dev-cpp/gtkmm-2.8.0:2.4
	>=gnome-base/libgnome-2.16.0
	>=gnome-base/libgnomeui-2.14.0
	>=dev-libs/libxml2-2.6.0"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	# Don't pass --enable/disable-assert since it has broken
	# AC_ARG_ENABLE call. Pass -DNDEBUG to cppflags instead.
	use debug || append-cppflags -DNDEBUG

	econf \
		--disable-dependency-tracking \
		--disable-link-as-needed
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS README THANKS ChangeLog  || die "dodoc failed"
}

pkg_postinst() {
	elog "To use gnome-color-chooser themes you may need to add:"
	elog "      include \".gtkrc-2.0-gnome-color-chooser\""
	elog "to ~/.gtkrc-2.0 for each user, otherwise themes may not be applied."

	gnome2_pkg_postinst
}
