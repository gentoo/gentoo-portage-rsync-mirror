# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/webrtc-audio-processing/webrtc-audio-processing-0.1-r1.ebuild,v 1.3 2014/01/12 20:04:24 pacho Exp $

EAPI=5

AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
inherit autotools-multilib

DESCRIPTION="AudioProcessing library from the webrtc.org code base"
HOMEPAGE="http://www.freedesktop.org/software/pulseaudio/webrtc-audio-processing/"
SRC_URI="http://freedesktop.org/software/pulseaudio/${PN}/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86 ~amd64-linux"
IUSE="static-libs"

RDEPEND="abi_x86_32? ( !<=app-emulation/emul-linux-x86-soundlibs-20130224-r1
					!app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)] )"

DOCS=( AUTHORS NEWS README )
