# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtk-youtube-viewer/gtk-youtube-viewer-2.0.5.ebuild,v 1.4 2012/09/24 23:38:58 hasufell Exp $

EAPI=4

DESCRIPTION="Gtk2 variant of YouTube-Viewer"
HOMEPAGE="http://code.google.com/p/trizen/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/gtk2-perl
	dev-perl/libwww-perl
	dev-perl/XML-Fast
	|| ( media-video/mplayer[X,network]
		media-video/mplayer2[X,network] )
	!>=net-misc/youtube-viewer-3.0.1_p20120924[gtk]
	virtual/freedesktop-icon-theme
	x11-libs/gdk-pixbuf:2[X,jpeg]"
