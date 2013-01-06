# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-lcdproc/vdr-lcdproc-0.0.10.3.ebuild,v 1.2 2008/08/05 06:57:39 zzam Exp $

inherit vdr-plugin eutils versionator

MY_P=${PN}-$(replace_version_separator 3 -jw ${PV})

DESCRIPTION="VDR plugin: use LCD device for additional output"
HOMEPAGE="http://www.joachim-wilke.de/?alias=vdr-patches&lang=en"
SRC_URI="mirror://gentoo//${MY_P}.tgz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.4
		>=app-misc/lcdproc-0.4.3"

S=${WORKDIR}/${MY_P#vdr-}
