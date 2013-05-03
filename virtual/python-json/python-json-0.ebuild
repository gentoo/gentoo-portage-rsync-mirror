# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/python-json/python-json-0.ebuild,v 1.3 2013/05/03 01:08:27 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )
inherit python-r1

DESCRIPTION="A virtual for JSON support in Python, with simplejson fallback"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 arm ~hppa ppc ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

# Only Python 2.5 lacks built-in JSON support. Most packages use
# simplejson fallback, and those packages should use this virtual.
RDEPEND="${PYTHON_DEPS}
	python_targets_python2_5? (
		dev-python/simplejson[python_targets_python2_5] )"
