# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Kivy/Kivy-1.8.0.ebuild,v 1.3 2014/04/06 10:36:24 eva Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_1,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A software library for rapid development of hardware-accelerated multitouch applications."
HOMEPAGE="http://kivy.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cairo camera doc examples garden gstreamer spell"

DEPEND="dev-python/cython
	garden? ( dev-python/kivy-garden )
	gstreamer? ( dev-python/gst-python:0.10 )
	cairo? ( dev-python/pycairo )
	spell? ( dev-python/pyenchant )
	dev-python/pygame
	dev-python/setuptools
	camera? ( media-libs/opencv )
	virtual/python-imaging
	"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e '/data_files=/d' -i "${S}/setup.py"
}

src_install() {
	distutils-r1_src_install
	use doc && dodoc -r doc/sources/*
	use examples && insinto "/usr/share/doc/${PF}/" && doins -r examples
}
