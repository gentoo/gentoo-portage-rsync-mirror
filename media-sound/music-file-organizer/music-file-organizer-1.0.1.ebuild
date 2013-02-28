# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/music-file-organizer/music-file-organizer-1.0.1.ebuild,v 1.1 2013/02/28 12:12:33 zx2c4 Exp $

EAPI=4

DESCRIPTION="Organizes audio files into directories based on metadata tags,
along with other metadata utilities."
HOMEPAGE="http://blog.zx2c4.com/813"
SRC_URI="http://git.zx2c4.com/music-file-organizer/snapshot/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/taglib dev-libs/icu"
DEPEND="${RDEPEND} virtual/pkgconfig"

pkg_postinst() {
	einfo
	einfo "The organizemusic utility recursively moves audio files and audio"
	einfo "directories given as its arguments into the directory specified"
	einfo "by the environment variable MUSICDIR. You may want to set this"
	einfo "environment variable inside your .bashrc. If no MUSICDIR variable"
	einfo "is set, it falls back to \"\$HOME/Music/\"."
	einfo
}
