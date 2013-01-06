# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/spek/spek-0.8.0.ebuild,v 1.1 2012/09/25 18:48:43 xmw Exp $

EAPI=4

DESCRIPTION="Analyse your audio files by showing their spectrogram"
HOMEPAGE="http://www.spek-project.org/"
SRC_URI="https://github.com/downloads/alexkay/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="virtual/ffmpeg
	x11-libs/wxGTK:2.8"

DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"
