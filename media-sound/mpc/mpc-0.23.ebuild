# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpc/mpc-0.23.ebuild,v 1.6 2013/05/13 14:54:03 jer Exp $

EAPI=4
inherit bash-completion-r1

DESCRIPTION="A commandline client for Music Player Daemon (media-sound/mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="http://www.musicpd.org/download/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc ppc64 ~sparc ~x86"
IUSE="iconv"

RDEPEND=">=media-libs/libmpdclient-2.2
	iconv? ( virtual/libiconv )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS NEWS README doc/mpd-m3u-handler.sh doc/mppledit
	doc/mpd-pls-handler.sh )

src_configure() {
	econf $(use_enable iconv) \
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	default
	newbashcomp doc/mpc-completion.bash ${PN}
}
