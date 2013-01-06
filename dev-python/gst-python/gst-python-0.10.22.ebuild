# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gst-python/gst-python-0.10.22.ebuild,v 1.13 2012/11/07 20:10:53 tetromino Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit autotools eutils python

DESCRIPTION="A Python Interface to GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org/"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0.10"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="examples test"

RDEPEND="dev-libs/libxml2
	>=dev-python/pygobject-2.28:2
	>=media-libs/gstreamer-0.10.32:0.10
	>=media-libs/gst-plugins-base-0.10.32:0.10"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? (
		media-plugins/gst-plugins-ogg:0.10
		media-plugins/gst-plugins-vorbis:0.10
	)" # tests a "audiotestsrc ! vorbisenc ! oggmux ! fakesink" pipeline

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.10.9-lazy.patch
	python_clean_py-compile_files #396689
	AT_M4DIR="common/m4" eautoreconf
	python_src_prepare
}

src_install() {
	python_src_install
	dodoc AUTHORS ChangeLog NEWS README TODO

	if use examples; then
		docinto examples
		dodoc examples/*
	fi

	python_clean_installation_image
}

src_test() {
	LC_ALL="C" python_src_test
}

pkg_postinst() {
	python_mod_optimize pygst.py gst-0.10
}

pkg_postrm() {
	python_mod_cleanup pygst.py gst-0.10
}
