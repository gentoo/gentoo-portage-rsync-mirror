# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-viewer/youtube-viewer-9999.ebuild,v 1.11 2013/02/21 16:14:42 hasufell Exp $

EAPI=4

inherit perl-module git-2

DESCRIPTION="A command line utility for viewing youtube-videos in Mplayer"
HOMEPAGE="http://trizen.googlecode.com"
SRC_URI=""
EGIT_REPO_URI="git://github.com/trizen/${PN}.git"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS=""
IUSE="gtk"

RDEPEND="
	>=dev-lang/perl-5.16.0
	dev-perl/Data-Dump
	dev-perl/libwww-perl
	|| ( media-video/mplayer[X,network]
		media-video/mplayer2[X,network] )
	virtual/perl-File-Spec
	virtual/perl-Getopt-Long
	virtual/perl-Term-ANSIColor
	gtk? (
		>=dev-perl/gtk2-perl-1.244.0
		!net-misc/gtk-youtube-viewer
		virtual/freedesktop-icon-theme
		x11-libs/gdk-pixbuf:2[X,jpeg]
	)"
DEPEND="virtual/perl-Module-Build"

EGIT_SOURCEDIR="${WORKDIR}"
S=${WORKDIR}/WWW-YoutubeViewer

SRC_TEST="do"

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
	elog "  dev-perl/LWP-Protocol-https or dev-perl/libwww-perl[ssl]"
	elog "    (for HTTPS protocol and login support)"
	elog "  dev-perl/TermReadKey (to get the terminal width size)"
	elog "  dev-perl/Term-ReadLine-Gnu (for a better STDIN support)"
	elog "  dev-perl/XML-Fast (faster XML to HASH conversion)"
	elog "  net-misc/gcap (for retrieving Youtube closed captions)"
	elog "  virtual/perl-File-Temp (for posting comments)"
	elog "  virtual/perl-Scalar-List-Utils (to shuffle the playlists (--shuffle)"
	einfo
}
