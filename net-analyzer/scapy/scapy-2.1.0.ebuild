# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scapy/scapy-2.1.0.ebuild,v 1.7 2011/04/19 11:39:14 tomka Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"

inherit distutils

DESCRIPTION="A Python interactive packet manipulation program for mastering the network"
HOMEPAGE="http://www.secdev.org/projects/scapy/"
SRC_URI="http://www.secdev.org/projects/scapy/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gnuplot pyx crypt graphviz imagemagick visual tcpreplay"

DEPEND=""
RDEPEND="net-analyzer/tcpdump
	gnuplot? ( dev-python/gnuplot-py )
	pyx? ( dev-python/pyx )
	crypt? ( dev-python/pycrypto )
	graphviz? ( media-gfx/graphviz )
	imagemagick? ( || ( media-gfx/imagemagick
						media-gfx/graphicsmagick[imagemagick] ) )
	visual? ( dev-python/visual )
	tcpreplay? ( net-analyzer/tcpreplay )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
