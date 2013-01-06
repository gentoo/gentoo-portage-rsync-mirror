# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopengl/pyopengl-3.0.1.ebuild,v 1.16 2012/05/29 14:40:59 aballier Exp $

EAPI="3"
PYTHON_USE_WITH="tk"
PYTHON_USE_WITH_OPT="tk"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.7-pypy-* *-jython 3.*"

inherit distutils

MY_PN="PyOpenGL"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python OpenGL bindings"
HOMEPAGE="http://pyopengl.sourceforge.net/ http://pypi.python.org/pypi/PyOpenGL"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
#	mirror://sourceforge/pyopengl/${MY_P}.tar.gz" # broken mirror for this release
LICENSE="BSD"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="tk"

RDEPEND="media-libs/freeglut
	virtual/opengl
	x11-libs/libXi
	x11-libs/libXmu
	tk? ( dev-tcltk/togl )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="OpenGL"
