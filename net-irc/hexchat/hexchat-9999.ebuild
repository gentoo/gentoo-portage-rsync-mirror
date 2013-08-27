# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/hexchat/hexchat-9999.ebuild,v 1.2 2013/08/27 09:22:44 hasufell Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_3 )
inherit autotools eutils fdo-mime gnome2-utils mono-env multilib python-single-r1 git-2

DESCRIPTION="Graphical IRC client based on XChat"
HOMEPAGE="http://hexchat.github.io/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/hexchat/hexchat.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
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
	ssl? ( >=dev-libs/openssl-0.9.8u )
	theme-manager? ( dev-lang/mono )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	theme-manager? ( dev-util/monodevelop )"

DOCS=""

pkg_setup() {
	use python && python-single-r1_pkg_setup
	use theme-manager && mono-env_pkg_setup
}

src_prepare() {
	mkdir m4 || die
	sed -i \
		-e "/intl\/Makefile/d" \
		-e "/po\/Makefile.in/d" \
		configure.ac || die
	sed -i -e "/SUBDIRS/s/intl//" Makefile.am || die
	sed -i -e 's/Exec=.*$/Exec=thememan %f/' share/misc/htm.desktop || die
	epatch -p1 \
		"${FILESDIR}"/${PN}-2.9.5-autoconf-missing-macros.patch
	epatch_user
	cp $(type -p gettextize) "${T}"/ || die
	sed -i -e 's:read dummy < /dev/tty::' "${T}/gettextize" || die
	einfo "Running gettextize -f --no-changelog..."
	"${T}"/gettextize -f --no-changelog > /dev/null || die "gettexize failed"
	AT_M4DIR="m4" eautoreconf
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
		domenu share/misc/htm.desktop
		insinto /usr/share/mime/packages
		newins share/misc/htm-mime.xml htm.xml
	fi
	prune_libtool_files --all
}

pkg_preinst() {
	if use gtk ; then
		gnome2_icon_savelist
	fi

	if use theme-manager ; then
		fdo-mime_desktop_database_update
		fdo-mime_mime_database_update
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
}

pkg_postrm() {
	if use gtk ; then
		gnome2_icon_cache_update
	fi
}
