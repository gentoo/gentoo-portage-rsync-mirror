# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-bh-lucidatypewriter-75dpi/font-bh-lucidatypewriter-75dpi-1.0.3.ebuild,v 1.9 2014/09/14 17:29:13 chithanh Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org Bigelow & Holmes Lucida bitmap fonts"
LICENSE="bh-lucida"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf"
