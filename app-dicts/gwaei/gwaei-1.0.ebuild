# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/gwaei/gwaei-1.0.ebuild,v 1.3 2012/05/03 02:18:34 jdhore Exp $

EAPI="1"

inherit eutils gnome2-utils

DESCRIPTION="Japanese-English Dictionary for GNOME"
HOMEPAGE="http://gwaei.sourceforge.net/"
SRC_URI="mirror://sourceforge/gwaei/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk gnome nls"

RDEPEND=">=net-misc/curl-7.18
	>=dev-libs/glib-2.8:2
	gtk? (
		>=gnome-base/gconf-2:2
		>=x11-libs/gtk+-2.14:2
		>=x11-libs/libsexy-0.1.11
	)
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.3.2
	gnome? ( app-text/scrollkeeper )
	nls? ( >=sys-devel/gettext-0.17 )
	virtual/pkgconfig"

src_compile() {
	econf \
		$(use_with gtk gnome) \
		$(use_enable nls) \
		$(use_enable gnome scrollkeeper) \
		--disable-schemas-install || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	rm -rf "${D}/usr/share/doc/${P}"
	dodoc AUTHORS ChangeLog NEWS README
}
pkg_preinst() {
	if use gnome ; then
		gnome2_gconf_savelist
		gnome2_icon_savelist
	fi
}

pkg_postinst() {
	use gnome && gnome2_gconf_install
}
