# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-beep/vdr-beep-0.0.6.ebuild,v 1.5 2012/01/15 19:53:33 idl0r Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Use the PC speaker to signalize some events (shutdown, cut done etc.)"
HOMEPAGE="http://deltab.de/vdr/beep.html"
SRC_URI="http://deltab.de/vdr/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

RDEPEND=">=media-video/vdr-1.3.36"
DEPEND="${RDEPEND}
	sys-devel/gettext"
