# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/redshift/redshift-1.4.1.ebuild,v 1.6 2010/09/21 07:46:06 scarabeus Exp $

EAPI=3

PYTHON_DEPEND="gtk? 2:2.6"

inherit gnome2-utils python

DESCRIPTION="A screen color temperature adjusting software"
HOMEPAGE="http://jonls.dk/redshift/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gnome gtk nls"

COMMON_DEPEND="|| ( <x11-libs/libX11-1.3.99.901[xcb] >=x11-libs/libX11-1.3.99.901 )
	x11-libs/libXxf86vm
	x11-libs/libxcb
	gnome? ( dev-libs/glib:2
		>=gnome-base/gconf-2 )"
RDEPEND="${COMMON_DEPEND}
	gtk? ( >=dev-python/pygtk-2 )"
DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )"

pkg_setup() {
	use gtk && python_set_active_version 2
}

src_prepare() {
	if use gtk; then
		ln -nfs $(type -P true) py-compile || die
		python_convert_shebangs 2 src/gtk-redshift/gtk-redshift.in
	fi
}

src_configure() {
	local myconf
	use gtk || myconf="--enable-gui=none"

	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		--enable-randr \
		--enable-vidmode \
		$(use_enable gnome gnome-clock) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	use gtk && python_mod_optimize gtk_${PN}
}

pkg_postrm() {
	gnome2_icon_cache_update
	use gtk && python_mod_cleanup gtk_${PN}
}
