# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyFoam/PyFoam-0.5.4-r1.ebuild,v 1.4 2011/04/28 16:26:16 ssuominen Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="Tool to analyze and plot the residual files of OpenFOAM computations"
HOMEPAGE="http://openfoamwiki.net/index.php/Contrib_PyFoam"
SRC_URI="http://openfoamwiki.net/images/a/ae/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extras"

DEPEND="sci-visualization/gnuplot
	|| ( sci-libs/openfoam sci-libs/openfoam-bin )
	extras? (
		dev-python/matplotlib
		dev-python/numpy
		dev-python/ply
		dev-python/PyQt4
		sci-libs/vtk
	)"
RDEPEND="${DEPEND}"
