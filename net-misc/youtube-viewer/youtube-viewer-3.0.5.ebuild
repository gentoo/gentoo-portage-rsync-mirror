# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-viewer/youtube-viewer-3.0.5.ebuild,v 1.2 2013/01/07 19:28:28 hasufell Exp $

EAPI=4

inherit perl-module vcs-snapshot

DESCRIPTION="A command line utility for viewing youtube-videos in Mplayer"
HOMEPAGE="http://trizen.googlecode.com"
SRC_URI="https://github.com/trizen/youtube-viewer/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

RDEPEND="
	>=dev-lang/perl-5.16.0
	dev-perl/Data-Dump
	dev-perl/libwww-perl
	dev-perl/XML-Fast
	|| ( media-video/mplayer[X,network]
		media-video/mplayer2[X,network] )
	virtual/perl-File-Spec
	virtual/perl-Getopt-Long
	virtual/perl-Scalar-List-Utils
	virtual/perl-Term-ANSIColor
	gtk? (
		>=dev-perl/gtk2-perl-1.244.0
		!net-misc/gtk-youtube-viewer
		virtual/freedesktop-icon-theme
		x11-libs/gdk-pixbuf:2[X,jpeg]
	)"
DEPEND="virtual/perl-Module-Build"

SRC_TEST="do"

S=${WORKDIR}/${P}/WWW-YoutubeViewer

# build system installs files on "perl Build.PL" too
# do all the work in src_install
src_configure() { :; }
src_compile() { :; }

src_install() {
	use gtk && local myconf="--gtk-youtube-viewer"
	perl-module_src_configure
	perl-module_src_install
}

pkg_postinst() {
	perl-module_pkg_postinst
	einfo
	elog "optional dependencies:"
	elog "  dev-perl/TermReadKey (to get the terminal width size)"
	elog "  dev-perl/Term-ReadLine-Gnu (for a better STDIN support)"
	elog "  net-misc/gcap (for retrieving Youtube closed captions)"
	einfo
}
