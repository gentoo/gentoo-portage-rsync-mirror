# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gqrx/gqrx-2.1_p20130708.ebuild,v 1.2 2014/07/07 13:06:58 zerochaos Exp $

EAPI=5

inherit qt4-r2

DESCRIPTION="Software defined radio receiver powered by GNU Radio and Qt"
HOMEPAGE="http://gqrx.dk/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/csete/gqrx.git"
	inherit git-2
	KEYWORDS=""
else
	SRC_URI="https://dev.gentoo.org/~zerochaos/distfiles/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="pulseaudio"

DEPEND=">=net-wireless/gnuradio-3.7_rc:=
	~net-wireless/gr-osmosdr-0.1.0:=
	pulseaudio? ( media-sound/pulseaudio )"
RDEPEND="${DEPEND}"

src_prepare() {
	if use !pulseaudio; then
		sed -i 's/AUDIO_BACKEND = pulse/#AUDIO_BACKEND = pulse/' gqrx.pro || die
	fi
	qt4-r2_src_prepare
}

src_install() {
	dobin gqrx
}
