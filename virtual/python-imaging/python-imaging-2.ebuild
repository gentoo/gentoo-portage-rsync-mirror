# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/python-imaging/python-imaging-2.ebuild,v 1.11 2014/07/06 17:28:21 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy )

inherit python-r1

DESCRIPTION="Virtual for Python Imaging Library"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="jpeg tk"

RDEPEND="dev-python/pillow[jpeg?,tk?,${PYTHON_USEDEP}]"
