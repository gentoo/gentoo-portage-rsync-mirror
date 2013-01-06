# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xbitmaps/xbitmaps-1.1.1.ebuild,v 1.10 2012/05/06 00:06:33 aballier Exp $

EAPI=3

XORG_MODULE=data/
XORG_STATIC=no
inherit xorg-2

DESCRIPTION="X.Org bitmaps data"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
