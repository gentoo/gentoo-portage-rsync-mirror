# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xvinfo/xvinfo-1.1.2.ebuild,v 1.10 2013/10/08 05:04:50 ago Exp $

EAPI=5

inherit xorg-2

DESCRIPTION="Print out X-Video extension adaptor information"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libXv
	x11-libs/libX11"
DEPEND="${RDEPEND}"
