# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-sndctl/vdr-sndctl-0.1.5.1.ebuild,v 1.1 2011/01/18 14:51:22 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Control the vol levels of different controls of your sound-
card according to the vol settings of VDR"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-sndctl"
SRC_URI="http://www.vdr-portal.de/board/attachment.php?attachmentid=25497 -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.4.1
		media-libs/alsa-lib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${VDRPLUGIN}-0.1.5-1"
