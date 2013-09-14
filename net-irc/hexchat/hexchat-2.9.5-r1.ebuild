# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/hexchat/hexchat-2.9.5-r1.ebuild,v 1.14 2013/09/14 16:36:18 hasufell Exp $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )
inherit autotools eutils gnome2-utils mono multilib python-single-r1

DESCRIPTION="Graphical IRC client based on XChat"
SRC_URI="mirror://github/${PN}/${PN}/${P}.tar.xz"
HOMEPAGE="http://hexchat.github.io/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-linux"
IUSE="dbus fastscroll +gtk ipv6 libnotify libproxy nls ntlm perl +plugins plugin-checksum plugin-doat plugin-fishlim plugin-sysinfo python spell ssl theme-manager"
REQUIRED_USE="plugin-checksum? ( plugins )
	plugin-doat? ( plugins )
	plugin-fishlim? ( plugins )
	plugin-sysinfo? ( plugins )
	python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="dev-libs/glib:2
	dbus? ( >=dev-libs/dbus-glib-0.98 )
	fastscroll? ( x11-libs/libXft )
	gtk? ( x11-libs/gtk+:2 )
	libproxy? ( net-libs/libproxy )
	libnotify? ( x11-libs/libnotify )
	nls? ( virtual/libintl )
	ntlm? ( net-libs/libntlm )
	perl? ( >=dev-lang/perl-5.8.0 )
	plugin-sysinfo? ( sys-apps/pciutils )
	python? ( ${PYTHON_DEPS} )
	spell? (
		app-text/enchant
		dev-libs/libxml2
	)
	ssl? ( dev-libs/openssl:0 )
	theme-manager? ( dev-lang/mono )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	theme-manager? ( dev-util/monodevelop )"

DOCS=""

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	mkdir m4 || die

	epatch \
		"${FILESDIR}"/${PN}-2.9.1-input-box.patch \
		"${FILESDIR}"/${PN}-2.9.5-cflags.patch \
		"${FILESDIR}"/${PN}-2.9.5-gettextize.patch \
		"${FILESDIR}"/${PN}-2.9.5-gobject.patch \
		"${FILESDIR}"/${PN}-2.9.5-fix_leftclick_opens_menu.patch
	epatch -p1 \
		"${FILESDIR}"/${PN}-2.9.5-autoconf-missing-macros.patch

	cp $(type -p gettextize) "${T}"/ || die
	sed -i -e 's:read dummy < /dev/tty::' "${T}/gettextize" || die
	einfo "Running gettextize -f --no-changelog..."
	"${T}"/gettextize -f --no-changelog > /dev/null || die "gettexize failed"
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
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
		--enable-shm \
		$(use_enable spell spell static) \
		$(use_enable ntlm) \
		$(use_enable libproxy)
}

src_compile() {
	default
	if use theme-manager ; then
		export XDG_CACHE_HOME="${T}/.cache"
		cd src/htm || die
		mdtool --verbose build htm-mono.csproj || die
	fi
}

src_install() {
	emake DESTDIR="${D}" UPDATE_ICON_CACHE=true install
	dodoc share/doc/{readme,hacking}.md
	use plugin-fishlim && dodoc share/doc/fishlim.md
	if use theme-manager ; then
		dobin src/htm/thememan.exe
		make_wrapper thememan "mono /usr/bin/thememan.exe"
	fi
	prune_libtool_files --all
}

pkg_preinst() {
	if use gtk ; then
		gnome2_icon_savelist
		gnome2_gconf_savelist
	fi
}

pkg_postinst() {
	if use !gtk ; then
		einfo
		elog "You have disabled the gtk USE flag. This means you don't have"
		elog "the GTK-GUI for HexChat but only a text interface called \"hexchat-text\"."
	else
		gnome2_icon_cache_update
		gnome2_gconf_install
	fi

	if use theme-manager ; then
		einfo
		elog "Themes are available at:"
		elog "  http://hexchat.org/themes.html"
	fi

	ewarn
	ewarn "If you're upgrading from hexchat <=2.9.3 remember to rename"
	ewarn "the xchat.conf file found in ~/.config/hexchat/ to hexchat.conf"
	ewarn
	elog "optional dependencies:"
	elog "  media-sound/sox (sound playback)"
}

pkg_postrm() {
	if use gtk ; then
		gnome2_icon_cache_update
	fi
}
