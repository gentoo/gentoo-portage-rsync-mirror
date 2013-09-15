# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/hexchat/hexchat-2.9.6.1.ebuild,v 1.1 2013/09/15 18:33:25 hasufell Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_3 )
inherit eutils fdo-mime gnome2-utils mono-env multilib python-single-r1

DESCRIPTION="Graphical IRC client based on XChat"
HOMEPAGE="http://hexchat.github.io/"
SRC_URI="http://dl.hexchat.org/hexchat/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux"
IUSE="dbus fastscroll +gtk gtkspell ipv6 libcanberra libnotify libproxy nls ntlm perl +plugins plugin-checksum plugin-doat plugin-fishlim plugin-sysinfo python sexy spell ssl theme-manager"
REQUIRED_USE="gtkspell? ( spell )
	plugin-checksum? ( plugins )
	plugin-doat? ( plugins )
	plugin-fishlim? ( plugins )
	plugin-sysinfo? ( plugins )
	python? ( ${PYTHON_REQUIRED_USE} )
	sexy? ( spell )
	?? ( gtkspell sexy )"

RDEPEND="dev-libs/glib:2
	dbus? ( >=dev-libs/dbus-glib-0.98 )
	fastscroll? ( x11-libs/libXft )
	gtk? ( x11-libs/gtk+:2 )
	libcanberra? ( media-libs/libcanberra )
	libproxy? ( net-libs/libproxy )
	libnotify? ( x11-libs/libnotify )
	nls? ( virtual/libintl )
	ntlm? ( net-libs/libntlm )
	perl? ( >=dev-lang/perl-5.8.0 )
	plugin-sysinfo? ( sys-apps/pciutils )
	python? ( ${PYTHON_DEPS} )
	spell? (
		app-text/enchant
		gtkspell? ( app-text/gtkspell:2 )
		sexy? ( x11-libs/libsexy )
		!gtkspell? ( !sexy? ( dev-libs/libxml2 ) )
	)
	ssl? ( dev-libs/openssl:0 )
	theme-manager? ( dev-lang/mono )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	theme-manager? ( dev-util/monodevelop )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
	if use theme-manager ; then
		mono-env_pkg_setup
		export XDG_CACHE_HOME="${T}/.cache"
	fi
}

src_prepare() {
	epatch_user
}

src_configure() {
	local myspellconf
	if use spell ; then
		if use gtkspell ; then
			myspellconf="--enable-spell=gtkspell"
		elif use sexy ; then
			myspellconf="--enable-spell=libsexy"
		else
			myspellconf="--enable-spell=static"
		fi
	else
		myspellconf="--disable-spell"
	fi

	econf \
		$(use_enable nls) \
		$(use_enable libproxy socks) \
		$(use_enable ipv6) \
		$(use_enable fastscroll xft) \
		$(use_enable ssl openssl) \
		$(use_enable gtk gtkfe) \
		$(use_enable !gtk textfe) \
		$(usex python "--enable-python=${EPYTHON}" "--disable-python") \
		$(use_enable perl) \
		$(use_enable plugins plugin) \
		$(use_enable plugin-checksum checksum) \
		$(use_enable plugin-doat doat) \
		$(use_enable plugin-fishlim fishlim) \
		$(use_enable plugin-sysinfo sysinfo) \
		$(use_enable dbus) \
		$(use_enable libnotify) \
		$(use_enable libcanberra) \
		--enable-shm \
		${myspellconf} \
		$(use_enable ntlm) \
		$(use_enable libproxy) \
		--enable-minimal-flags \
		$(use_with theme-manager)
}

src_install() {
	emake DESTDIR="${D}" \
		UPDATE_ICON_CACHE=true \
		UPDATE_MIME_DATABASE=true \
		UPDATE_DESKTOP_DATABASE=true \
		install
	dodoc share/doc/{readme,hacking}.md
	use plugin-fishlim && dodoc share/doc/fishlim.md
	prune_libtool_files --all
}

pkg_preinst() {
	if use gtk ; then
		gnome2_icon_savelist
	fi
}

pkg_postinst() {
	if use gtk ; then
		gnome2_icon_cache_update
		einfo
	else
		einfo
		elog "You have disabled the gtk USE flag. This means you don't have"
		elog "the GTK-GUI for HexChat but only a text interface called \"hexchat-text\"."
		elog
	fi

	if use theme-manager ; then
		fdo-mime_desktop_database_update
		fdo-mime_mime_database_update
		elog "Themes are available at:"
		elog "  http://hexchat.org/themes.html"
		elog
	fi

	elog "If you're upgrading from hexchat <=2.9.3 remember to rename"
	elog "the xchat.conf file found in ~/.config/hexchat/ to hexchat.conf"
	elog
	elog "If you're upgrading from hexchat <=2.9.5 you will have to fix"
	elog "your auto-join channel settings, see:"
	elog "  https://bugs.gentoo.org/show_bug.cgi?id=473514#c1"
	elog "Also, some internal hotkeys such as \"Ctrl+l\" (clear screen)"
	elog "have been removed, but you can add them yourself via:"
	elog "  Settings -> Keyboard Shortcuts"
	einfo
	elog "optional dependencies:"
	elog "  media-sound/sox (sound playback if you don't have libcanberra"
	elog "    enabled)"
	elog "  x11-plugins/hexchat-javascript (javascript support)"
	elog "  x11-themes/sound-theme-freedesktop (default BEEP sound,"
	elog "    needs libcanberra enabled)"
	einfo
}

pkg_postrm() {
	if use gtk ; then
		gnome2_icon_cache_update
	fi

	if use theme-manager ; then
		fdo-mime_desktop_database_update
		fdo-mime_mime_database_update
	fi
}
