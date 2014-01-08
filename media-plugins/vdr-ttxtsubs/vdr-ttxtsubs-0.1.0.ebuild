# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-ttxtsubs/vdr-ttxtsubs-0.1.0.ebuild,v 1.4 2014/01/08 11:33:51 hd_brummy Exp $

EAPI=5

inherit vdr-plugin-2

VERSION="96" # every bump, new Version

DESCRIPTION="VDR Plugin: displaying, recording and replaying teletext
based subtitles"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-ttxtsubs"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tar.gz"

KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0[ttxtsubs]"
RDEPEND="${DEPEND}"
