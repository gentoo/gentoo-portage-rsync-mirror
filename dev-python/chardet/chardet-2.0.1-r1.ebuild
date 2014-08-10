# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chardet/chardet-2.0.1-r1.ebuild,v 1.9 2014/08/10 21:08:18 slyfox Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_{6,7},3_{2,3}} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Character encoding auto-detection in Python"
HOMEPAGE="http://chardet.feedparser.org/ http://code.google.com/p/chardet/"
SRC_URI="http://chardet.feedparser.org/download/python2-${P}.tgz
	http://chardet.feedparser.org/download/python3-${P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE=""

HTML_DOCS=( docs/ )

src_unpack() {
	# Workaround for bug 459096.
	mkdir ${P} || die
	cd ${P} || die
	unpack ${A}
}

select_source() {
	if [[ ${EPYTHON} == python3* ]]; then
		cd "${S}/python3-${P}" || die
	else
		cd "${S}/python2-${P}" || die
	fi
}

python_compile() {
	select_source
	distutils-r1_python_compile
}

python_install() {
	select_source
	distutils-r1_python_install
}

python_install_all() {
	select_source
	distutils-r1_python_install_all
}
