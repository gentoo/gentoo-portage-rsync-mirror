# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils font

MY_P="MuseScore-${PV}"

DESCRIPTION="WYSIWYG Music Score Typesetter"
HOMEPAGE="http://mscore.sourceforge.net"
SRC_URI="mirror://sourceforge/mscore/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
    media-libs/libsndfile
    media-libs/portaudio
    media-sound/fluidsynth
    media-sound/jack-audio-connection-kit
    sys-libs/zlib
    dev-qt/qtcore:5
    dev-qt/qtgui:5
    dev-qt/qtscript:5
    dev-qt/qtsvg:5
    dev-qt/qthelp:5
    "

DEPEND="${RDEPEND}
    dev-texlive/texlive-context
    app-doc/doxygen
    virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"


src_install() {
    emake INSTALL_ROOT="${D}" install
    font_src_install
    dodoc ChangeLog NEWS README
    doman packaging/mscore.1
}