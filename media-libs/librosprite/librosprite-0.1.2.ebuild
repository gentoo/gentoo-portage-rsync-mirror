# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/librosprite/librosprite-0.1.2.ebuild,v 1.1 2015/03/22 00:25:11 xmw Exp $

EAPI=5

NETSURF_BUILDSYSTEM=buildsystem-1.3
inherit netsurf

DESCRIPTION="framebuffer abstraction library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/librosprite/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~m68k-mint"
IUSE=""

PATCHES=( "${FILESDIR}"/${P}-Werror.patch )
