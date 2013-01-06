# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnome-pilot/gnome-pilot-2.32.0.ebuild,v 1.9 2012/05/03 20:20:58 jdhore Exp $

EAPI="3"
G2CONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Gnome Palm Pilot and Palm OS Device Syncing Library"
HOMEPAGE="http://live.gnome.org/GnomePilot"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="eds"

RDEPEND="
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	>=gnome-base/gconf-2
	dev-libs/libxml2
	>=app-pda/pilot-link-0.11.7
	>=x11-libs/gtk+-2.13:2
	>=dev-libs/dbus-glib-0.88

	eds? ( >=gnome-extra/evolution-data-server-2 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	>=dev-util/gob-2.0.5
	>=dev-lang/perl-5.6
	>=app-text/scrollkeeper-0.3.14
	>=dev-util/intltool-0.35.5"

pkg_setup() {
	DOCS="AUTHORS COPYING* ChangeLog README NEWS"
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable eds eds-conduits)
		--without-hal"
}

src_install() {
	gnome2_src_install
	find "${ED}"/usr/$(get_libdir)/${PN}/conduits -name "*.la" -delete || die
}

pkg_postinst() {
	if ! has_version "app-pda/pilot-link[bluetooth]"; then
		elog "if you want bluetooth support, please rebuild app-pda/pilot-link"
		elog "echo 'app-pda/pilot-link bluetooth >> /etc/portage/package.use"
	fi
}
