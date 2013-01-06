# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-undelete/vdr-undelete-0.0.7.ebuild,v 1.1 2012/10/07 18:35:12 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

VERSION="1060" # every bump, new version!

DESCRIPTION="VDR Plugin: Recover deleted recordings of VDR"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-undelete"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.5.7"
RDEPEND="${DEPEND}"
