# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scapy/scapy-2.2.0-r1.ebuild,v 1.3 2012/01/28 15:34:08 phajdan.jr Exp $

EAPI="3"

PYTHON_DEPEND="2:2.6"

inherit eutils distutils

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

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-sendpfast.patch
}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
