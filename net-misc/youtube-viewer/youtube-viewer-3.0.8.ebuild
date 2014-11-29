# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-viewer/youtube-viewer-3.0.8.ebuild,v 1.3 2014/11/28 22:25:11 dilfridge Exp $

EAPI=5

inherit eutils perl-module vcs-snapshot

DESCRIPTION="A command line utility for viewing youtube-videos in Mplayer"
HOMEPAGE="http://trizen.googlecode.com"
SRC_URI="https://github.com/trizen/youtube-viewer/tarball/${PV} -> ${P}.tar.gz"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	virtual/perl-Text-ParseWords
	virtual/perl-Text-Tabs+Wrap
	gtk? (
		>=dev-perl/gtk2-perl-1.244.0
		virtual/freedesktop-icon-theme
		x11-libs/gdk-pixbuf:2[X,jpeg]
	)"
DEPEND="virtual/perl-Module-Build"

SRC_TEST="do"

S=${WORKDIR}/${P}/WWW-YoutubeViewer

src_prepare() {
	epatch "${FILESDIR}"/${P}-button.patch
	rm share/gtk-youtube-viewer-icons/donate.png || die
	perl-module_src_prepare
}

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
	einfo
	elog "optional dependencies:"
	elog "  dev-perl/LWP-Protocol-https or dev-perl/libwww-perl[ssl]"
	elog "    (for HTTPS protocol and login support)"
	elog "  dev-perl/TermReadKey (to get the terminal width size)"
	elog "  dev-perl/Term-ReadLine-Gnu (for a better STDIN support)"
	elog "  dev-perl/Text-CharWidth (print the results in a fixed-width"
	elog "    format (--fixed-width, -W))"
	elog "  dev-perl/XML-Fast (faster XML to HASH conversion)"
	elog "  net-misc/gcap (for retrieving Youtube closed captions)"
	elog "  virtual/perl-File-Temp (for posting comments)"
	elog "  virtual/perl-Scalar-List-Utils (to shuffle the playlists"
	elog "    (--shuffle, -s))"
	elog "  virtual/perl-threads (threads support)"
	einfo
}
