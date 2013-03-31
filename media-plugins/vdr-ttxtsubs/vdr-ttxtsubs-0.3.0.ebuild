# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-ttxtsubs/vdr-ttxtsubs-0.3.0.ebuild,v 1.1 2013/03/31 16:23:59 hd_brummy Exp $

EAPI="5"

inherit vdr-plugin-2

VERSION="1281" # every bump, new version!

DESCRIPTION="VDR Plugin: displaying, recording and replaying teletext based subtitles"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-ttxtsubs"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.7.38[ttxtsubs]"
RDEPEND="${DEPEND}"
