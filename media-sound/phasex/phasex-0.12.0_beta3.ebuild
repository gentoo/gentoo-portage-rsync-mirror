# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/phasex/phasex-0.12.0_beta3.ebuild,v 1.2 2012/05/05 08:45:44 mgorny Exp $

EAPI=2

DESCRIPTION="Software synthesizer (Phase Harmonic Advanced Synthesis EXperiment)"
HOMEPAGE="http://sysex.net/phasex/"
SRC_URI="http://sysex.net/phasex/beta/${P/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	media-sound/jack-audio-connection-kit
	media-libs/alsa-lib
	media-libs/libsamplerate
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${P/_beta3}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO doc/ROADMAP
}
