# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xineramaproto/xineramaproto-1.2.1.ebuild,v 1.9 2013/02/21 18:02:23 zmedico Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="X.Org Xinerama protocol headers"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="!<x11-libs/libXinerama-1.0.99.1"
DEPEND="${RDEPEND}"
