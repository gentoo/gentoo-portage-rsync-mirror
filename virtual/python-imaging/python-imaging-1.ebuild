# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/python-imaging/python-imaging-1.ebuild,v 1.5 2014/01/25 03:47:37 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit python-r1

DESCRIPTION="Virtual for Python Imaging Library"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="jpeg tk"

RDEPEND="
	python_targets_python2_6? ( || (
		dev-python/pillow[jpeg?,tk?,python_targets_python2_6(-)]
		dev-python/imaging[jpeg?,tk?,python_targets_python2_6(-)]
	) )
	python_targets_python2_7? ( || (
		dev-python/pillow[jpeg?,tk?,python_targets_python2_7(-)]
		dev-python/imaging[jpeg?,tk?,python_targets_python2_7(-)]
	) )
	python_targets_python3_2? ( dev-python/pillow[jpeg?,tk?,python_targets_python3_2(-)] )
	python_targets_python3_3? ( dev-python/pillow[jpeg?,tk?,python_targets_python3_3(-)] )
"
