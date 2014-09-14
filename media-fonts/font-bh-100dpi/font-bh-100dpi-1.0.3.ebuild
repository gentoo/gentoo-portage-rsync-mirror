# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-bh-100dpi/font-bh-100dpi-1.0.3.ebuild,v 1.10 2014/09/14 17:27:53 chithanh Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org Bigelow & Holmes bitmap fonts"
LICENSE="bh-lucida"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf"
