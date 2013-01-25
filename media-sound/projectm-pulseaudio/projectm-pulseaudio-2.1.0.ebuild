# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/projectm-pulseaudio/projectm-pulseaudio-2.1.0.ebuild,v 1.3 2013/01/25 13:55:49 ago Exp $

EAPI=5

inherit cmake-utils

MY_P=${PN/m-pulseaudio/M}-complete-${PV}-Source

DESCRIPTION="A Qt GUI for projectM that visualizes your pulseaudio output."
HOMEPAGE="http://projectm.sourceforge.net"
SRC_URI="mirror://sourceforge/projectm/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	media-sound/pulseaudio
	media-libs/ftgl
	>=media-libs/libprojectm-2.1.0
	>=media-libs/libprojectm-qt-2.1.0
	virtual/opengl
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}/src/${PN/m/M}"
