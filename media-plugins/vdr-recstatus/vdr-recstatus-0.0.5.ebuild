# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-recstatus/vdr-recstatus-0.0.5.ebuild,v 1.2 2007/12/03 07:20:45 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: displays the recording status of the available devices."
HOMEPAGE="http://www.constabel.net/vdr/plugins.en.htm"
SRC_URI="mirror://gentoo/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.4.6"

RDEPEND=""
