# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-lcdproc/vdr-lcdproc-0.0.10.6.ebuild,v 1.1 2009/02/23 02:14:48 hd_brummy Exp $

EAPI=2

inherit vdr-plugin eutils versionator

MY_P=${PN}-$(replace_version_separator 3 -jw ${PV})

DESCRIPTION="VDR plugin: use LCD device for additional output"
HOMEPAGE="http://www.joachim-wilke.de/?alias=vdr-patches&lang=en"
SRC_URI="http://www.joachim-wilke.de/dl.htm?ct=gz&dir=vdr-patches&file=${PN}-0.0.10-jw6.tgz -> ${P}.tgz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6
		>=app-misc/lcdproc-0.4.3"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P#vdr-}
