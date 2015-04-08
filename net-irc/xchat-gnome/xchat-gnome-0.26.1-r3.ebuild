# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-gnome/xchat-gnome-0.26.1-r3.ebuild,v 1.3 2015/03/25 16:48:28 jlec Exp $

EAPI=5
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"
PYTHON_COMPAT=( python2_7 )

inherit autotools eutils multilib gnome2 python-single-r1

DESCRIPTION="GNOME frontend for the popular X-Chat IRC client"
HOMEPAGE="http://live.gnome.org/Xchat-Gnome"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dbus libnotify cpu_flags_x86_mmx nls perl python spell ssl tcl"

REQUIRED_USE=${PYTHON_REQUIRED_USE}

RDEPEND="
	>=dev-libs/glib-2.18:2
	>=gnome-base/libgnome-2.16.0
	>=gnome-base/gconf-2.8.0
	>=gnome-base/libgnomeui-2.16.0
	>=gnome-base/libglade-2.3.2
	>=media-libs/libcanberra-0.3[gtk]
	>=x11-libs/gtk+-2.14:2
	>=x11-libs/libsexy-0.1.11
	x11-libs/libX11
	spell? ( app-text/enchant )
	ssl? ( >=dev-libs/openssl-0.9.6d:0 )
	perl? ( >=dev-lang/perl-5.6.1 )
	python? ( ${PYTHON_DEPS} )
	tcl? ( dev-lang/tcl:0= )
	dbus? ( >=sys-apps/dbus-0.60 )
	libnotify? ( >=x11-libs/libnotify-0.3.2 )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=app-text/gnome-doc-utils-0.3.2
	nls? ( sys-devel/gettext )"

# gnome-base/gnome-common needed when doing eautoreconf

pkg_setup() {
	# Per configure.ac, shm is disable because of upstream bug #565958
	# --enable-shm
	G2CONF="${G2CONF}
		--enable-canberra
		--disable-schemas-install
		--disable-scrollkeeper
		--disable-static
		--disable-maintainer-mode
		$(use_with ssl openssl)
		$(use_enable perl)
		$(use_enable python)
		$(use_enable tcl tcl /usr/$(get_libdir))
		$(use_enable cpu_flags_x86_mmx mmx)
		$(use_enable dbus)
		$(use_enable nls)
		$(use_enable libnotify notification)"

	DOCS="AUTHORS ChangeLog NEWS"

	use python && python-single-r1_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch

	# https://bugzilla.gnome.org/show_bug.cgi?id=649844
	epatch "${FILESDIR}"/${P}-multilib.patch
	# https://bugzilla.gnome.org/show_bug.cgi?id=650008
	epatch "${FILESDIR}"/${P}-ssl-automagic.patch

	eautoconf

	gnome2_src_prepare

	# Fix build with it documentation, bug #341173
	epatch "${FILESDIR}/${PN}-0.26.1-fix-it-help.patch"
}

src_install() {
	gnome2_src_install

	# install plugin development header
	insinto /usr/include/xchat-gnome
	doins src/common/xchat-plugin.h
}
