# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xcalc/xcalc-1.0.4.1.ebuild,v 1.8 2011/02/14 23:41:04 xarthisius Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="scientific calculator for X"

KEYWORDS="amd64 arm hppa ~mips ppc ppc64 s390 sh sparc x86 ~x86-interix ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="x11-libs/libXaw
	x11-libs/libXt
	x11-libs/libX11"
DEPEND="${RDEPEND}"
