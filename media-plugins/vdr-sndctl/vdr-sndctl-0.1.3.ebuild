# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-sndctl/vdr-sndctl-0.1.3.ebuild,v 1.3 2011/01/18 14:51:22 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Control the volume levels of different controls of your sound-
card according to the volume settings of VDR"
HOMEPAGE="http://www.box.net/shared/qhu44kgcv4"
SRC_URI="mirror://vdrfiles/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.4.1
		media-libs/alsa-lib"
RDEPEND="${DEPEND}"
