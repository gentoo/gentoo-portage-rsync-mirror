# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/nikola/nikola-6.3.0.ebuild,v 1.1 2014/02/23 06:50:54 yngwin Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3} )
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

LICENSE="MIT-with-advertising"
SLOT="0"
IUSE="assets charts jinja markdown"

DEPEND="dev-python/docutils" # needs rst2man to build manpage
RDEPEND="${DEPEND}
	python_targets_python2_7? ( =dev-python/configparser-3.2.0* )
	>=dev-python/doit-0.23.0
	dev-python/logbook
	dev-python/lxml
	>=dev-python/mako-0.6
	dev-python/pygments
	dev-python/PyRSS2Gen
	dev-python/python-dateutil
	>=dev-python/pytz-2013d
	>=dev-python/requests-1.0
	dev-python/unidecode
	>=dev-python/yapsy-1.10.2
	virtual/python-imaging
	assets? ( dev-python/assets )
	charts? ( dev-python/pygal )
	jinja? ( >=dev-python/jinja-2.7 )
	markdown? ( dev-python/markdown )"

src_install() {
	distutils-r1_src_install

	# hackish way to remove docs that ended up in the wrong place
	rm -rf "${D}"/usr/share/doc/${PN}

	dodoc AUTHORS.txt CHANGES.txt README.rst docs/*.txt
	doman docs/man/*
}
