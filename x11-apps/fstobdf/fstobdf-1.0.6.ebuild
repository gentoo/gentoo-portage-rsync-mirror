# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/fstobdf/fstobdf-1.0.6.ebuild,v 1.6 2015/02/23 10:44:19 ago Exp $

EAPI=5

inherit xorg-2

DESCRIPTION="generate BDF font from X font server"
KEYWORDS="amd64 ~arm ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libFS"
DEPEND="${RDEPEND}"
