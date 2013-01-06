# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-tvonscreen/vdr-tvonscreen-0.7.1.ebuild,v 1.5 2008/04/22 10:41:49 zzam Exp $

IUSE=""
inherit vdr-plugin

DESCRIPTION="VDR plugin: Show EPG like a TV guide"
HOMEPAGE="http://www.js-home.org/vdr/tvonscreen"
SRC_URI="http://beejay.vdr-developer.org/patches/${P}.tar.gz"
KEYWORDS="x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.18"

PATCHES=("${FILESDIR}/${P}-includes.diff"
	"${FILESDIR}/${P}.diff")
