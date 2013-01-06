# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mediastreamer-x264/mediastreamer-x264-1.4.1.ebuild,v 1.6 2012/05/16 12:18:30 scarabeus Exp $

EAPI="4"

inherit multilib

MY_P="msx264-${PV}"

DESCRIPTION="mediastreamer plugin: add H264 support"
HOMEPAGE="http://www.linphone.org/"
SRC_URI="mirror://nongnu/linphone/plugins/sources/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

DEPEND=">=media-libs/mediastreamer-2.7.0[video]
	>=media-libs/x264-0.0.20100118
	virtual/ffmpeg"
RDEPEND="${DEPEND}"

DOCS="AUTHORS NEWS README"

S=${WORKDIR}/${MY_P}

src_configure() {
	# strict: don't want -Werror
	econf \
		--libdir=/usr/$(get_libdir) \
		--disable-strict
}
