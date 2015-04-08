# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyode/pyode-1.2.0_p20100322-r1.ebuild,v 1.7 2015/03/07 08:19:49 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 pypy pypy2_0 )
inherit distutils-r1

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
	>=dev-python/pyrex-0.9.4.1[${PYTHON_USEDEP}]"
DEPEND=${RDEPEND}

S=${WORKDIR}/PyODE-snapshot-${SNAPSHOT_DATE}

python_compile() {
	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing"
	distutils-r1_python_compile
}

src_install() {
	distutils-r1_src_install

	# The build system doesnt error if it fails to build
	# the ode library so we need our own sanity check
	[[ -n $(find "${D}" -name ode.so) ]] || die "ode.so is missing"

	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
