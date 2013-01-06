# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinclassic/vdr-skinclassic-0.0.2.ebuild,v 1.3 2012/06/12 19:08:39 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

IUSE=""
SLOT="0"

DESCRIPTION="vdr skin: based on classic vdr design"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Skinclassic-plugin"
SRC_URI="mirror://gentoo/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="x86"

DEPEND=">=media-video/vdr-1.3.27"
