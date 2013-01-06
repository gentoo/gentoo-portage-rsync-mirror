# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/ripper/ripper-007-r1.ebuild,v 1.5 2008/07/14 15:52:20 lack Exp $

ROX_LIB_VER=2.0.0
inherit rox

MY_PN="Ripper"
DESCRIPTION="Ripper - A MP3/OGG ripper/encoder for the ROX Desktop"
HOMEPAGE="http://rox-ripper.googlecode.com"
SRC_URI="http://rox-ripper.googlecode.com/files/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="mp3 ogg cdparanoia"

RDEPEND="
	virtual/cdrtools
	cdparanoia? ( media-sound/cdparanoia )
	mp3? ( media-sound/lame )
	ogg? ( media-sound/vorbis-tools )"

APPNAME=${MY_PN}
APPCATEGORY="AudioVideo;DiscBurning"
S=${WORKDIR}
