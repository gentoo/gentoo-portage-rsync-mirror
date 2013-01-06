# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyode/pyode-1.2.0_p20100322.ebuild,v 1.5 2011/04/14 20:33:21 ranger Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_P="${P/pyode/PyODE}"
SNAPSHOT_DATE="2010-03-22"	# This is a snapshot

DESCRIPTION="Python bindings to the ODE physics engine"
HOMEPAGE="http://pyode.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/PyODE-snapshot-${SNAPSHOT_DATE}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=dev-games/ode-0.7
	>=dev-python/pyrex-0.9.4.1"
DEPEND="${RDEPEND}"

S="${WORKDIR}/PyODE-snapshot-${SNAPSHOT_DATE}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="xode"

src_install() {
	distutils_src_install
	# The build system doesnt error if it fails to build
	# the ode library so we need our own sanity check
	[[ -z $(find "${D}" -name ode.so) ]] && die "failed to build/install :("

	if use examples; then
		insinto "/usr/share/doc/${PF}"
		doins -r examples
	fi
}
