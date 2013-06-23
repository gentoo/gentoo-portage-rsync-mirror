# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsvgtiny/libsvgtiny-0.1.0.ebuild,v 1.3 2013/06/23 16:50:54 xmw Exp $

EAPI=5

inherit netsurf

DESCRIPTION="framebuffer abstraction library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libsvgtiny/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""

RDEPEND=">=net-libs/libdom-0.0.1[xml,static-libs?,${MULTILIB_USEDEP}]
	>=dev-libs/libwapcaplet-0.2.0[static-libs?,${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	dev-util/gperf"
