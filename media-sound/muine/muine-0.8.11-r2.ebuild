# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/muine/muine-0.8.11-r2.ebuild,v 1.9 2013/10/12 12:13:32 pacho Exp $

EAPI=2

inherit base gnome2 mono eutils multilib flag-o-matic

DESCRIPTION="A music player for GNOME"
HOMEPAGE="http://muine.gooeylinux.org/"
SRC_URI="http://download.gnome.org/sources/muine/0.8/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="flac mad vorbis"

RDEPEND="
	x11-themes/gnome-icon-theme
	>=dev-lang/mono-2
	>=x11-libs/gtk+-2.6:2
	>=dev-dotnet/gtk-sharp-2.12.9:2
	>=dev-dotnet/glade-sharp-2.12.6:2
	>=dev-dotnet/gnome-sharp-2.6:2
	>=dev-dotnet/gconf-sharp-2.6:2
	>=dev-dotnet/gnomevfs-sharp-2.6:2
	>=dev-dotnet/ndesk-dbus-0.4
	>=dev-dotnet/ndesk-dbus-glib-0.3
	>=dev-dotnet/taglib-sharp-2.0.3
	sys-libs/gdbm
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10
	media-libs/gst-plugins-good:0.10
	media-plugins/gst-plugins-gconf:0.10
	media-plugins/gst-plugins-gnomevfs:0.10
	flac? ( media-plugins/gst-plugins-flac:0.10 )
	mad? ( media-plugins/gst-plugins-mad:0.10 )
	vorbis? (
		media-plugins/gst-plugins-ogg:0.10
		media-plugins/gst-plugins-vorbis:0.10
	)
	"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	app-text/scrollkeeper
	gnome-base/gnome-common
	>=dev-util/intltool-0.29
"

pkg_setup() {
	DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS PLUGINS README TODO"
	G2CONF="${G2CONF}
		--enable-compile-warnings=yes
		--docdir=/usr/share/doc/"${PF}"
	"
}

src_prepare() {
	gnome2_src_prepare

	# Fix multimedia key support for >=Gnome-2.22
	epatch "${FILESDIR}/${P}-multimedia-keys.patch"

	# Replace some deprecated gtk functions
	epatch "${FILESDIR}/${P}-drop-deprecated.patch"

	# Update icons, upstream bug #623480
	sed "s:stock_timer:list-add:g" -i src/AddWindow.cs src/StockIcons.cs || die
	sed "s:stock_music-library:folder-music:g" -i data/glade/PlaylistWindow.glade \
		src/Actions.cs src/StockIcons.cs || die

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "sed failed"

	# Drop -DG.*DISABLE_DEPRECATED cflags
	sed 's:-DG.*DISABLE_DEPRECATED::g' -i libmuine/Makefile.am libmuine/Makefile.in || die
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "failed to delete *.la files"
	insinto /usr/$(get_libdir)/${PN}/plugins
	doins "${S}"/plugins/TrayIcon.dll
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog
	elog "Upstream no longer packages the tray icon plugin by default."
	elog "The Gentoo ebuilds will continue to install the plugin, if you don't"
	elog "want to use the plugin, remove TrayIcon.dll from"
	elog "/usr/$(get_libdir)/muine/plugins/"
	elog
}
