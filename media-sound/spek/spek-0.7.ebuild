# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/spek/spek-0.7.ebuild,v 1.2 2012/05/05 09:01:45 mgorny Exp $

EAPI=3

DESCRIPTION="Analyse your audio files by showing their spectrogram"
HOMEPAGE="http://www.spek-project.org/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/glib
	virtual/ffmpeg
	>=x11-libs/gtk+-2.18:2"

DEPEND="${RDEPEND}
	dev-lang/vala:0.10
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS || die
}
