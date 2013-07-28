# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/spek/spek-0.8.3.ebuild,v 1.1 2013/07/28 02:07:08 xmw Exp $

EAPI=5
WX_GTK_VER="2.8"

inherit autotools eutils wxwidgets

DESCRIPTION="Analyse your audio files by showing their spectrogram"
HOMEPAGE="http://www.spek-project.org/"
SRC_URI="https://github.com/alexkay/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="virtual/ffmpeg
	x11-libs/wxGTK:2.8[X]"

DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.8.1-disable-updates.patch
	eautoreconf
}
