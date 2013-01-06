# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-chanman/vdr-chanman-0.0.6.ebuild,v 1.4 2011/01/28 21:21:05 mr_bones_ Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR plugin: change channel with a multi level choice."
HOMEPAGE="http://www.messinalug.org/${PN}/"
SRC_URI="http://www.messinalug.org/${PN}/download/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.6"
RDEPEND="${DEPEND}"
