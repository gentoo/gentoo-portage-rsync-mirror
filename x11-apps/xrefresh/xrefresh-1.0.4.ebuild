# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xrefresh/xrefresh-1.0.4.ebuild,v 1.9 2012/05/15 14:19:50 aballier Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="refresh all or part of an X screen"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
