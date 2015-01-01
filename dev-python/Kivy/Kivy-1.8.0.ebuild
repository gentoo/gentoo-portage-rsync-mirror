# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Kivy/Kivy-1.8.0.ebuild,v 1.5 2015/01/01 21:23:06 slis Exp $

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
	gstreamer? ( dev-python/gst-python )
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
	epatch "${FILESDIR}/cython-fixes.patch"
}

src_install() {
	distutils-r1_src_install
	use doc && dodoc -r doc/sources/*
	use examples && insinto "/usr/share/doc/${PF}/" && doins -r examples
}
