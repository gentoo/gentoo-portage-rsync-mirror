# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/nikola/nikola-6.4.0.ebuild,v 1.1 2014/03/21 10:13:50 yngwin Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 ) # 3_3 needs PyRSS2Gen update
inherit distutils-r1

DESCRIPTION="A static website and blog generator"
HOMEPAGE="http://getnikola.com/"
MY_PN="Nikola"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/ralsina/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT-with-advertising Apache-2.0" # Gutenberg
SLOT="0"
IUSE="assets charts hyphenation ipython jinja markdown"
RESTRICT="test" # needs freezegun, coveralls, and phpserialize

DEPEND="dev-python/docutils[${PYTHON_USEDEP}]" # needs rst2man to build manpage
RDEPEND="${DEPEND}
	python_targets_python2_7? ( =dev-python/configparser-3.2.0*[${PYTHON_USEDEP}] )
	dev-python/blinker[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	>=dev-python/doit-0.23.0[${PYTHON_USEDEP}]
	dev-python/logbook[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	>=dev-python/mako-0.6[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/PyRSS2Gen[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	>=dev-python/pytz-2013d[${PYTHON_USEDEP}]
	>=dev-python/requests-1.0[${PYTHON_USEDEP}]
	dev-python/unidecode[${PYTHON_USEDEP}]
	>=dev-python/yapsy-1.10.2[${PYTHON_USEDEP}]
	virtual/python-imaging[${PYTHON_USEDEP}]
	assets? ( dev-python/assets[${PYTHON_USEDEP}] )
	charts? ( dev-python/pygal[${PYTHON_USEDEP}] )
	hyphenation? ( dev-python/pyphen[${PYTHON_USEDEP}] )
	ipython? ( >=dev-python/ipython-1.0.0[${PYTHON_USEDEP}] )
	jinja? ( >=dev-python/jinja-2.7[${PYTHON_USEDEP}] )
	markdown? ( dev-python/markdown[${PYTHON_USEDEP}] )"
# more options as packages will be added:
#	livereload? ( dev-python/livereload[${PYTHON_USEDEP}] )
#	micawber? ( dev-python/micawber[${PYTHON_USEDEP}] )
#	typogrify? ( dev-python/typogrify[${PYTHON_USEDEP}] )

src_install() {
	distutils-r1_src_install

	# hackish way to remove docs that ended up in the wrong place
	rm -rf "${D}"/usr/share/doc/${PN}

	dodoc AUTHORS.txt CHANGES.txt README.rst docs/*.txt
	doman docs/man/*
}
