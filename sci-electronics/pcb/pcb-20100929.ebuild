# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/pcb/pcb-20100929.ebuild,v 1.11 2012/10/24 19:36:23 ulm Exp $

EAPI="3"

inherit fdo-mime gnome2-utils

DESCRIPTION="GPL Electronic Design Automation: Printed Circuit Board editor"
HOMEPAGE="http://www.gpleda.org/"
SRC_URI="mirror://sourceforge/pcb/pcb/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-macos"
IUSE="dbus doc gif gtk jpeg m4lib-png motif nelma gcode nls png xrender test tk toporouter debug"
# toporouter-output USE flag removed, there seems to be no result

CDEPEND="gif? ( >=media-libs/gd-2.0.23 )
	gtk? ( x11-libs/gtk+:2 x11-libs/pango
		dbus? ( sys-apps/dbus ) )
	jpeg? ( >=media-libs/gd-2.0.23[jpeg] )
	motif? ( !gtk? (
		>=x11-libs/motif-2.3:0
		dbus? ( sys-apps/dbus )
		xrender? ( >=x11-libs/libXrender-0.9 ) ) )
	nelma? ( >=media-libs/gd-2.0.23 )
	gcode? ( >=media-libs/gd-2.0.23 )
	nls? ( virtual/libintl )
	png? ( >=media-libs/gd-2.0.23[png] )
	m4lib-png? ( >=media-libs/gd-2.0.23[png] )
	tk? ( >=dev-lang/tk-8 )"
#toporouter-output? ( x11-libs/cairo )

DEPEND="${CDEPEND}
	test? (
		|| ( media-gfx/graphicsmagick[imagemagick] media-gfx/imagemagick )
		sci-electronics/gerbv
	)
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

RDEPEND="${CDEPEND}
	sci-electronics/electronics-menu"

pkg_setup() {
	if use gtk && use motif; then
		elog "Can only build for GTK+ or Motif/Lesstif GUI. GTK+ has priority."
	fi
	if !(use gtk || use motif); then
		elog "Building without GUI, make sure you know what you are doing."
	fi
	if use dbus && !(use gtk || use motif); then
		elog "dbus needs GTK or Motif/Lesstif GUI. Try USE=-dbus or USE=gtk or USE=motif."
	fi
	if (use gtk || (! use gtk && ! use motif)) &&  (use xrender); then
		elog "The XRender extension is only usable with the Motif/Lesstif GUI."
	fi
}

src_prepare() {
	if use test; then
		# adapt the list of tests to run according to USE flag settings
		if ! use png; then
			sed -i '/^hid_png/d' tests/tests.list || die
		fi
		if ! use gcode; then
			sed -i '/^hid_gcode/d' tests/tests.list || die
		fi
	fi
}

src_configure() {
	local myconf
	if use gtk ; then
		myconf="--with-gui=gtk $(use_enable dbus) --disable-xrender"
	elif use motif ; then
		myconf="--with-gui=lesstif $(use_enable dbus) $(use_enable xrender)"
	else
		myconf="--with-gui=batch --disable-xrender --disable-dbus"
	fi

	local exporters="bom gerber ps"
	if (use png || use jpeg || use gif) ; then
		exporters="${exporters} png"
	fi
	use nelma && exporters="${exporters} nelma"
	use gcode && exporters="${exporters} gcode"
	use tk || export WISH="${EPREFIX}/bin/true"

	econf \
		${myconf} \
		$(use_enable doc) \
		$(use_enable gif) \
		$(use_enable jpeg) \
		$(use_enable nls) \
		$(use_enable png) \
		$(use_enable m4lib-png) \
		$(use_enable toporouter) \
		$(use_enable debug) \
		--disable-toporouter-output \
		--with-exporters="${exporters}" \
		--disable-dependency-tracking \
		--disable-rpath \
		--disable-update-mime-database \
		--disable-update-desktop-database \
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
}
# toporouter-output USE flag removed, there seems to be no result
#		$(use_enable toporouter-output) \

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS README NEWS ChangeLog
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
