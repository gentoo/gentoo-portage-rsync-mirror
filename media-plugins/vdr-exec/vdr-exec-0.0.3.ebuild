# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-exec/vdr-exec-0.0.3.ebuild,v 1.1 2011/01/28 21:46:48 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Exec commands like timers at defined times"
HOMEPAGE="http://wirbel.htpc-forum.de/exec/index2.html"
SRC_URI="http://wirbel.htpc-forum.de/exec/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}_compile-warnings.diff" )
